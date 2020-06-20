module EventCreator
  class CreateEvent < ApplicationService
    def initialize(user, event_params)
      @event_params = event_params
      @user = user
    end

    def call
      @event = @user.events.build(@event_params)
      EventCreatedMail.run(@event) if @event.save
    end
  end
end
