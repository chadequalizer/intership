class AdminMailer < ApplicationMailer
  def new_event(event, admin)
    mail(to: admin, subject: t('events.mailer.subject.new_event'))
  end
end
