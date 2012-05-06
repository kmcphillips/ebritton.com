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
      end
    rescue => e
      puts "*** ERROR: Transaction rolled back becasue of exception raised! ***"
      raise e
    end
  end

  protected

  def clear_tables
    puts "Truncating tables"
    ["posts", "events", "links"].each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE `#{table}`")
    end
  end

  def import_posts
    puts "Importing posts..."
    @db.query("SELECT id, create_date, title, post FROM blog ORDER BY id ASC").each do |result|
      post = Post.new(:title => result["title"], :body => result["post"])
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
      event.created_at = result["create_date"]
      event.updated_at = result["create_date"]
      event.id = result["id"]
      event.imported_image = "#{result["image"]}.#{result["type"]}" if result["image"].to_i > 0
      event.imported = true

      event.save!
      puts "  Event ##{event.id} created"
    end
    puts "Done"
    puts ""
  end

  def import_bio
    puts "Importing bio..."
    result = @db.query("SELECT body, image FROM bio LIMIT 1").first

    body = result["body"].gsub(/<.?p>/, "").gsub(/<.?sup>/, "").gsub("&nbsp;", " ").gsub("&ndash;", "-").gsub("&rsquo;", "'").gsub(/^\s*/, "")

    puts "TODO: Import bio image"

    block = Block.bio
    block.update_attributes!(:body => body)

    puts "Done"
    puts ""
  end

  def import_contact
    puts "Importing contact..."
    result = @db.query("SELECT body FROM contact LIMIT 1").first

    body = result["body"].gsub(/<.?p>/, "").gsub("\r\n \r\n", "\n")

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

  def import_projects
    puts "Importing projects..."

    puts "TODO: Import project image"
    puts "TODO: Import project media"

    @db.query("SELECT id, create_date, title, description, type, date, image FROM project ORDER BY id ASC").each do |result|
      case result["type"]
      when "w"
        model = Writing
      when "p"
        model = Project
      else
        raise "Unknown project type #{result["type"]}"
      end

      project = model.new :title => result["title"], :body => result["description"], :happened_at => result["date"]
      project.created_at = result["create_date"]
      project.updated_at = result["create_date"]
      project.id = result["id"]

      project.save!

      puts "  Project ##{project.id} (#{project.class.to_s.downcase}) created"
    end
    puts "Done"
    puts ""
  end

end
