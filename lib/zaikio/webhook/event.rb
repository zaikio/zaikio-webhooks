require "ostruct"

module Zaikio
  module Webhook
    class Event
      extend Forwardable
      attr_reader :data
      def_delegators :data, :id, :name, :version, :payload, :link

      def initialize(event_data)
        @data = OpenStruct.new(event_data)
      end

      def created_at
        DateTime.parse(data.timestamp)
      end

      def received_at
        DateTime.parse(data.received_at)
      end

      def subject_id
        data.subject.split("/").last
      end

      def subject_type
        data.subject.split("/").first == "Org" ? "Organization" : "Person"
      end

      def ==(other)
        data == other.data
      end
    end
  end
end
