class ProjectsController < ApplicationController

  def index
    load_sidebar :projects
    @title = "Works"
    @works = Work.sorted
    @writings = Writing.sorted
  end

  def show
    load_sidebar :projects
    @project = Project.find_by_permalink!(params[:id])
    @title = [@project.class.to_s, @project.title]
  end

end

