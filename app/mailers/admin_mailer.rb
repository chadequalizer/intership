class AdminMailer < ApplicationMailer
  def new_event(_event, admin)
    mail(to: admin, subject: t('events.mailer.subject.new_event'))
    raise 'check'
  end
end
