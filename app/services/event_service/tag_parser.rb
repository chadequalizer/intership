module EventService
  class TagParser < ApplicationService
    def initialize(event)
      @event = event
    end

    def call
      description_array = @event.description.downcase.split(/[^0-9a-zA-z]+/)
      Tag.all.each do |tag|
        @event.tag_list.add(tag) if (description_array & tag.keywords.downcase.split(/[^0-9a-zA-z]+/)).any?
      end
      @event.save
    end
  end
end
