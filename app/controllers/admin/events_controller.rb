class Admin::EventsController < Admin::BaseController
  before_action :authenticate_admin!
  before_action :find_event, except: [:index, :pending]
  after_action :is_authorized, except: [:new]

  def index
    @events = Event.order(:start_time).page params[:page]
  end

  def pending
    @events = Event.order(:start_time).pending.page params[:page]
  end

  def edit; end

  def show; end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path, notice: t('events.notice.edit')
    else
      render 'edit'
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to admin_events_path, notice: t('events.notice.delete')
  end

  def approve
    @event.approve!
    redirect_to admin_events_path, notice: t('events.notice.approved')
  end

  def decline
    @event.decline!
    redirect_to admin_events_path, notice: t('events.notice.declined')
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
                                  :link,
                                  :state)
  end

  def find_event
    @event = Event.find(params[:id])
  end
end
