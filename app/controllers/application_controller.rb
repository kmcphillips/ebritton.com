class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_sidebar(section)
    case section.to_sym
    when :projects
      @sidebar_works = Project.other.sorted
      @sidebar_writings = Project.written.sorted
    when :bio
      @sidebar_bio = Block.bio
    else
      raise "Unknown sidebar section"
    end
  end
end
