class LinksController < ApplicationController

  def index
    load_sidebar :bio
    @links = Link.sorted
  end

end

