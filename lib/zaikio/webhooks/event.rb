require "ostruct"

module Zaikio
  module Webhooks
    class Event
      extend Forwardable

      attr_reader :id, :name, :version, :payload, :link, :client_name, :data

      def_delegators :data, :to_h

      def initialize(event_data)
        event_data = event_data.to_h.stringify_keys

        event_data.each do |key, value|
          instance_variable_set("@#{key}", value)
        end

        @data = event_data
      end

      def created_at
        DateTime.parse(data["timestamp"])
      end

      def received_at
        DateTime.parse(data["received_at"])
      end

      def subject_id
        data["subject"].split("/").last
      end

      def subject_type
        data["subject"].split("/").first == "Org" ? "Organization" : "Person"
      end

      def ==(other)
        data == other.data
      end
    end
  end
end
