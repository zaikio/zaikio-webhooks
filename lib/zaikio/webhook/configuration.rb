require "logger"

module Zaikio
  module Webhook
    class Configuration
      attr_writer :logger

      def logger
        @logger ||= Logger.new(STDOUT)
      end
    end
  end
end
