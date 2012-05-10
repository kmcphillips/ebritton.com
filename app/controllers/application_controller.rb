class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_sidebar(section)
    case section.to_sym
    when :projects
      @sidebar_works = Work.sorted
      @sidebar_writings = Writing.sorted
    else
      raise "Unknown sidebar section"
    end
  end
end
