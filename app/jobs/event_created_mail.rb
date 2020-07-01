class EventCreatedMail < Que::Job
  def run(event)
    @event = event
    admin_mails = Admin.pluck(:email)
    admin_mails.each do |admin_mail|
      AdminMailer.new_event(@event, admin_mail).deliver_now
    end
  end
end
