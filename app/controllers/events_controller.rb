class EventsController < ApplicationController

  def index
    @upcoming = Event.upcoming
    @past = Event.past.page(params[:page])
  end

  def show
    @event = Event.find_by_permalink!(params[:id])
  end

end

