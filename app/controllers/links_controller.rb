class LinksController < ApplicationController

  def index
    @links = Link.sorted
  end

end

