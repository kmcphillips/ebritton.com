module ApplicationHelper

  def body(model)
    if model.respond_to?(:imported?) && model.imported?
      model.body.html_safe
    else
      RDiscount.new(model.body).to_html.html_safe
    end
  end

  def nav_active
    @nav || controller.class.to_s.underscore.gsub(/_controller/, "").to_sym
  end

  def obfuscated_mail_to(email, label=nil)
    obfuscated = email.scan(/.{1,10}/).join("[REMOVE_THIS]")
    mail_to(email, label, :encode => "javascript") + "<noscript>#{mail_to(obfuscated, label || email.sub(/\@.*/, ""))}</noscript>".html_safe
  end

  def generated_title
    if @title.blank?
      @title = controller.class.to_s.underscore.gsub(/_controller/, "").humanize
    end

    ["Eliot Britton", @title].flatten.join(" - ")
  end

  def sidebar(section)
    content_for :sidebar do
      render :partial => "shared/sidebar/#{section}"
    end
    nil
  end
end
