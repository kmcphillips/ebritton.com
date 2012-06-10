class Importer

  def initialize(config)
    keys = %w(host username password database)
    raise "Invalid params. Requires: #{keys.join(", ")}." unless keys.all?{|k| config.has_key? k }

    puts "Connecting to database '#{config["database"]}' with user '#{config["username"]}'..."
    @db = Mysql2::Client.new(
        :host => config["host"],
        :username => config["username"],
        :password => config["password"],
        :database => config["database"]
    )
    puts "Connected"
  end

  def import!
    begin
      ActiveRecord::Base.transaction do
        clear_tables

        import_posts
        import_events
        import_bio
        import_contact
        import_links
        import_projects
        import_media
      end
    rescue => e
      puts "*** ERROR: Transaction rolled back becasue of exception raised! ***"
      raise e
    end
  end

  protected

  # I am not trying to be generic here. This will only ever be used once. Don't worry about it. I know this is not good code.
  def import_path
    if Rails.env.development?
      "#{Rails.root}/tmp"
    elsif Rails.env.production?
      raise "Unknown production path"
    else
      raise "Unknown environment for import path"
    end
  end

  def image_path(id, type="jpg")
    "#{import_path}/images/p#{id}.#{type}"
  end

  def clear_tables
    puts "Truncating tables"
    ["posts", "events", "links", "projects", "media"].each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE `#{table}`")
    end
  end

  def import_posts
    puts "Importing posts..."
    @db.query("SELECT id, create_date, title, post FROM blog ORDER BY id ASC").each do |result|
      post = Post.new(:title => result["title"])
      post.body = result["post"].gsub("href=\"images/p", "href=\"/images/p").gsub("src=\"images/thumbs/t", "src=\"/images/thumbs/t")
      post.created_at = result["create_date"]
      post.updated_at = result["create_date"]
      post.id = result["id"]
      post.imported = true

      post.save!
      puts "  News post ##{post.id} created"
    end
    puts "Done"
    puts ""
  end

  def import_events
    puts "Importing events..."
    @db.query("SELECT e.id, e.date, e.duration, e.title, e.description, e.image, e.create_date, i.type FROM event AS e LEFT JOIN image AS i ON e.image = i.id ORDER BY e.id ASC").each do |result|
      event = Event.new(:title => result["title"], :body => result["description"], :starts_at => result["date"], :days => result["duration"])
      event.body = result["description"].gsub("href=\"images/p", "href=\"/images/p").gsub("src=\"images/thumbs/t", "src=\"/images/thumbs/t")
      event.created_at = result["create_date"]
      event.updated_at = result["create_date"]
      event.id = result["id"]
      event.imported = true
      event.image = File.open(image_path(result["image"], result["type"])) if result["image"]

      event.save!
      puts "  Event ##{event.id} created"
    end
    puts "Done"
    puts ""
  end

  def import_bio
    puts "Importing bio..."
    result = @db.query("SELECT b.body, b.image, i.type FROM bio AS b LEFT JOIN image AS i ON b.image = i.id LIMIT 1").first

    body = result["body"].gsub(/<.?p>/, "").gsub(/<.?sup>/, "").gsub("&nbsp;", " ").gsub("&ndash;", "-").gsub("&rsquo;", "'")

    block = Block.bio
    block.body = body
    block.image = File.open(image_path(result["image"], result["type"]))
    block.save!

    puts "Done"
    puts ""
  end

  def import_contact
    puts "Importing contact..."
    result = @db.query("SELECT body FROM contact LIMIT 1").first

    body = result["body"].gsub(/<.?p>/, "").gsub("\r\n \r\n", "\n\n")

    Block.contact.update_attributes!(:body => body)
    
    puts "Done"
    puts ""
  end

  def import_links
    puts "Importing links..."
    @db.query("SELECT url, name, description FROM link ORDER BY id ASC").each do |result|
      link = Link.new :url => result["url"], :title => result["name"], :description => result["description"]
      link.save!

      puts "  Link ##{link.id} created"
    end
    puts "Done"
    puts ""
  end

  def import_media
    puts "Importing media..."
    @db.query("SELECT m.id, m.create_date, m.name, m.description, m.filename, m.secret, m.playlist FROM media AS m WHERE m.id NOT IN (SELECT media_id FROM project_media) ORDER BY id ASC").each do |result|
      media = Media.new :name => result["name"], :description => result["description"]
      media.id = result["id"]
      media.type = (result["playlist"] == "Y" ? "PlaylistItem" : "SecretMedia")
      media.created_at = result["create_date"]
      media.updated_at = result["create_date"]
      media.file = File.open("#{import_path}/media/#{result["filename"]}")

      media.save!
      puts "  Media ##{media.id} of type #{media.type} created (#{result["filename"]})"
    end
    puts "Done"
    puts ""
  end

  def import_projects
    puts "Importing projects..."

    @db.query("SELECT p.id, p.create_date, p.title, p.description, p.type AS project_type, p.date, p.image, i.type, m.name, m.filename FROM project AS p LEFT JOIN project_media AS pm ON pm.project_id = p.id LEFT JOIN media AS m ON m.id = pm.media_id LEFT JOIN image AS i ON i.id = p.image ORDER BY p.id ASC").each do |result|
      case result["project_type"]
      when "w"
        model = Writing
      when "p"
        model = Work
      else
        raise "Unknown project type #{result["type"]}"
      end

      project = model.new :title => result["title"], :body => result["description"], :happened_at => result["date"]
      project.created_at = result["create_date"]
      project.updated_at = result["create_date"]
      project.id = result["id"]
      project.file_title = result["name"]
      project.imported = true
      project.image = File.open(image_path(result["image"], result["type"])) if result["image"]
      project.file = File.open("#{import_path}/media/#{result["filename"]}") if result["filename"]

      project.save!

      puts "  Project ##{project.id} (#{project.class.to_s.downcase}) created"
    end
    puts "Done"
    puts ""
  end

end
