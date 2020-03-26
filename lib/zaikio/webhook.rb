require "zaikio/webhook/configuration"
require "zaikio/webhook/engine"

module Zaikio
  module Webhook
    class << self
      attr_accessor :configuration

      def configure
        self.configuration ||= Configuration.new
        yield(configuration)
      end

      def reset
        @webhooks = {}
      end

      def webhooks_for(client_name, event_name, options = {})
        (@webhooks.dig(client_name.to_s, event_name.to_s) || []).select do |webhook|
          webhook[:options] == options
        end
      end

      def on(event_name, client_name: nil, perform_now: false, &block)
        @webhooks ||= {}

        client_names = Array(client_name || configuration.all_client_names).map(&:to_s)
        client_names.each do |name|
          @webhooks[name] ||= {}
          @webhooks[name][event_name.to_s] ||= []
          @webhooks[name][event_name.to_s] << {
            options: {
              perform_now: perform_now
            },
            block: block
          }
        end
      end
    end
  end
end
