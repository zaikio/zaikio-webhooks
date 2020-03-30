module Zaikio
  module Webhooks
    class EventSerializer < ActiveJob::Serializers::ObjectSerializer
      def serialize?(argument)
        argument.is_a? Event
      end

      def serialize(event)
        super(event.to_h)
      end

      def deserialize(data)
        Event.new(data)
      end
    end
  end
end
