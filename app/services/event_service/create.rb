module EventService
  class Create < ApplicationService
    def initialize(user, event_params)
      @event_params = event_params
      @user = user
    end

    def call
      @event = @user.events.build(@event_params)
      CreateAdminMailWorker.perform_async(@event.id) if @event.save
    end
  end
end
