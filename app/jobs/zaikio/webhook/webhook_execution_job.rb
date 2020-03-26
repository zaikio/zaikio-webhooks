module Zaikio
  module Webhook
    class WebhookExecutionJob
      queue_as :default

      def perform(data); end
    end
  end
end
