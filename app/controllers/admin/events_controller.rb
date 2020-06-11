class Admin::EventsController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @events = Event.order(:start_time).page params[:page]
  end

  def edit
      @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to [:admin, @event], notice: t('events.notice.edit')
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to admin_events_path, notice: t('events.notice.delete')
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
end
