class EventsController < ApplicationController
  def index
    @events = Event.order(:start_time).page params[:page]
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def create
    @event = Event.new(event_params)
    
    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
  
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
  
    redirect_to events_path, notice: t('events.notice.delete')
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :location, :start_time, :end_time, :organizer_email, :organizer_telegram, :link)
  end
end
