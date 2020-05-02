class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to @event
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = event.find(params[:id])
  
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
  
    redirect_to events_path
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :location, :starttime, :endtime, :organizeremail, :organizertelegram, :link)
  end
end
