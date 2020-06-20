class EventCreatedMail < Que::Job
  def run(event)
    @event = event
    admin_mails = Admin.all.map(&:email)
    admin_mails.each do |admin|
      AdminMailer.new_event(@event, admin).deliver_now
    end
  end
end
