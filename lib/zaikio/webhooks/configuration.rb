require "logger"
require "zaikio/webhooks/client_configuration"

module Zaikio
  module Webhooks
    class Configuration
      attr_writer :logger
      attr_reader :client_configurations

      def initialize
        @client_configurations = {}
      end

      def logger
        @logger ||= Logger.new($stdout)
      end

      def register_client(name)
        @client_configurations[name.to_s] ||= ClientConfiguration.new
        yield(@client_configurations[name.to_s])
      end

      def find!(name)
        @client_configurations[name.to_s] or raise ActiveRecord::RecordNotFound
      end

      def all_client_names
        client_configurations.keys
      end
    end
  end
end
