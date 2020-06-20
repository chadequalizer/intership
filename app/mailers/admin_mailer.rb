class AdminMailer < ApplicationMailer
  def new_event(_event, admin)
    mail(to: admin, subject: 'New Event Created')
  end
end
