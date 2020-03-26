require "logger"
require "zaikio/webhook/client_configuration"

module Zaikio
  module Webhook
    class Configuration
      attr_writer :logger
      attr_reader :client_configurations

      def initialize
        @client_configurations = {}
      end

      def logger
        @logger ||= Logger.new(STDOUT)
      end

      def register_client(name)
        @client_configurations[name] ||= ClientConfiguration.new
        yield(@client_configurations[name])
      end
    end
  end
end
