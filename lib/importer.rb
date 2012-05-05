class Importer

  def initialize(config)
    keys = %w(host username password schema)
    raise "Invalid params. Requires: #{keys.join(", ")}." unless keys.inject(true){|acc,key| acc && config[key]}

    puts "Connecting to database '#{config["schema"]}' with user '#{config["username"]}'..."
    @db = Mysql2::Client.new(
        :host => config["host"],
        :username => config["username"],
        :password => config["password"],
        :database => config["schema"]
    )
    puts "Connected"
  end

  def import!
    begin
      ActiveRecord::Base.transaction do
        clear_tables

      end
    rescue => e
      puts "*** ERROR: Transaction rolled back becasue of exception raised! ***"
      raise e
    end
  end

  protected

  def clear_tables
    puts "Truncating event and news post tables"
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE posts")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE events")
  end


end
