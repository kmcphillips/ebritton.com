class BlogController < ApplicationController

  def index
    @title = "Blog"
    @posts = Post.sorted.page(params[:page])
  end

  def show
    @post = Post.find_by_permalink!(params[:id])
    @title = @post.title
  end

  def archive
    load_sidebar :projects
    @title = "Blog Archive"
    @posts = Post.sorted.group_by{|p| p.created_at.year }
  end

  def feed
    respond_to do |wants|
      wants.rss do
        @items = (Post.all + Event.all).sort{|x, y| y.sort_by <=> x.sort_by }
      end
    end
  end

end

