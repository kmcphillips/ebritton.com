class BlogController < ApplicationController

  def index
    @posts = Post.sorted
  end

  def show
    @post = Post.find_by_permalink!(params[:id])
  end

  def archive
    @posts = Post.sorted
  end

end

