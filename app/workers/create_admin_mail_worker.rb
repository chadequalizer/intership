class CreateAdminMailWorker
  include Sidekiq::Worker
  sidekiq_options

  def perform(event_id)
    @event = Event.find(event_id)
    find_admin_mails
    @admin_mails.each do |admin_mail|
      AdminMailer.new_event(@event, admin_mail).deliver_now
    end
  end

  private

  def find_admin_mails
    @admin_mails = Admin.pluck(:email)
  end
end
