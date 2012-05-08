class BlogController < ApplicationController

  def index
    @posts = Post.sorted.page(params[:page])
  end

  def show
    @post = Post.find_by_permalink!(params[:id])
  end

  def archive
    @posts = Post.sorted
  end

  def rss
    respond_to do |wants|
      wants.xml do
        
      end
    end
  end

end

