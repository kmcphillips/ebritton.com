module ApplicationHelper

  def body(model)
    if model.respond_to?(:imported?) && model.imported?
      model.body.html_safe
    else
      RDiscount.new(model.body).to_html.html_safe
    end
  end
end
