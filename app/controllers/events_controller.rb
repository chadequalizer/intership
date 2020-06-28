class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: [:edit, :show, :update, :destroy]
  before_action :check_approve, only: [:edit, :show, :update, :destroy]

  def index
    @events = current_user.events.order(:start_time).approved.page params[:page]
  end

  def new
    @event = Event.new
  end

  def edit
    @event = current_user.events.approved.find(params[:id])
  end

  def create
    if EventService::Create.call(current_user, event_params)
      redirect_to events_path, notice: t('events.notice.new')
    else
      render 'new'
    end
  end

  def show; end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: t('events.notice.edit')
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: t('events.notice.delete')
  end

  private

  def event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :location,
                                  :start_time,
                                  :end_time,
                                  :organizer_email,
                                  :organizer_telegram,
                                  :link)
  end

  def find_event
    @event = current_user.events.approved.find(params[:id])
  end

  def check_approve
    redirect_to events_path, notice: t('events.notice.no_acces') if @event.pending? || @event.declined?
  end
end
