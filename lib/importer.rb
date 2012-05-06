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
      end
    rescue => e
      puts "*** ERROR: Transaction rolled back becasue of exception raised! ***"
      raise e
    end
  end

  protected

  def clear_tables
    puts "Truncating tables"
    ["posts"].each do |table|
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
  end

  
end
