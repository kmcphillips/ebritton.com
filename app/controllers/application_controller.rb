class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

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

  def read_only?
    false
  end

  def check_read_only
    if read_only?
      sign_out
      flash[:error] = "You cannot login or use the admin at this time. Site is temporarily in read-only mode."
      redirect_to new_admin_user_session_path
    end

    true
  end
end
