require "zaikio/webhooks/configuration"
require "zaikio/webhooks/event"
require "zaikio/webhooks/event_serializer"
require "zaikio/webhooks/engine"

module Zaikio
  module Webhooks
    class << self
      attr_accessor :configuration
      attr_reader :webhooks

      def configure
        self.configuration ||= Configuration.new
        yield(configuration)
        @after_configuration_callbacks ||= []
        (@after_configuration_callbacks || []).each(&:call)
        @after_configuration_callbacks = []
      end

      def after_configuration(&block)
        if configuration
          yield
        else
          @after_configuration_callbacks ||= []
          @after_configuration_callbacks << block
        end
      end

      def reset
        @webhooks = {}
      end

      def webhooks_for(client_name, event_name)
        (@webhooks.dig(client_name.to_s, event_name.to_s) || {})
      end

      def on(event_name, job_klass, client_name: nil, perform_now: false)
        @webhooks ||= {}

        after_configuration do
          client_names = Array(client_name || configuration.all_client_names).map(&:to_s)
          client_names.each do |name|
            @webhooks[name] ||= {}
            @webhooks[name][event_name.to_s] ||= {}
            @webhooks[name][event_name.to_s][job_klass] = {
              perform_now: perform_now
            }
          end
        end
      end
    end
  end
end
