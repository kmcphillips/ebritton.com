module AdminHelper
  def imported_message
    "This event is imported and cannot be edited."
  end

  def markdown_message
    "This field recognizes #{link_to("Markdown", "http://daringfireball.net/projects/markdown/syntax")} syntax.".html_safe
  end
end
