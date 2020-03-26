module Zaikio
  module Webhook
    class WebhookExecutionJob < ApplicationJob
      queue_as :default

      def perform(data); end
    end
  end
end
