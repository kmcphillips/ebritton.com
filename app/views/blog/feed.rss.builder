

xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Eliot Britton"
    xml.description "Composer. Teacher. Sound Artist."
    xml.link "http://ebritton.com/"

    @items.each do |obj|
      xml.item do
        xml.title obj.title
        xml.description((obj.imported? ? obj.body : RDiscount.new(obj.body).to_html ).html_safe)
        if obj.is_a? Post    
          xml.pubDate obj.created_at.to_s(:rfc822)
          xml.link blog_url(obj)
          xml.guid blog_url(obj)
        elsif obj.is_a? Event
          xml.pubDate obj.starts_at.to_s(:rfc822)
          xml.link event_url(obj)
          xml.guid event_url(obj)
        end
      end
    end
  end
end
