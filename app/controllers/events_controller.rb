class EventsController < ApplicationController

  def index
    load_sidebar :projects
    @upcoming = Event.upcoming
    @past = Event.past.page(params[:page])
  end

  def show
    load_sidebar :projects
    @event = Event.find_by_permalink!(params[:id])
    @title = ["Event", @event.title]
  end

end

