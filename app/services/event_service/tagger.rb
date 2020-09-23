module EventService
  class Tagger < ApplicationService
    def initialize(event)
      @event = event
      @description_array = string_to_array(@event.description)
    end

    def call
      Tag.all.each do |tag|
        @event.tag_list.add(tag) if (@description_array & string_to_array(tag.keywords)).any?
      end
      @event.save!
    end

    def string_to_array(string)
      string.downcase.split(/[^0-9a-zA-z]+/)
    end
  end
end
