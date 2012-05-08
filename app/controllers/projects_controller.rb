class ProjectsController < ApplicationController

  def index
    @works = Works.sorted
    @writings = Writings.sorted
  end

  def show
    @project = Project.find_by_permalink!(params[:id])
  end

end

