class ProjectsController < ApplicationController

  def index
    @title = "Works"
    @works = Work.sorted
    @writings = Writing.sorted
  end

  def show
    @project = Project.find_by_permalink!(params[:id])
  end

end

