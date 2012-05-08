class LegacyController < ApplicationController

  def blog
    if params[:date]
      post = Post.find_legacy(params[:date]).first

      if post
        redirect_to blog_path(post)
      else
        redirect_to blog_index_path
      end
    else
      redirect_to blog_index_path
    end
  end

  def events
    redirect_to events_path
  end

  def bio
    redirect_to bio_path 
  end

  def bloghistory
    redirect_to archive_blog_index_path
  end

  def works
    redirect_to projects_path 
  end

  def links
    redirect_to links_path
  end

  def contact
    redirect_to contact_path
  end

  def default
    redirect_to root_path
  end

end
