module Zaikio
  module Webhook
    class WebhookExecutionJob < ApplicationJob
      queue_as :default

      def perform(client_name, data, perform_now: false)
        webhooks = Zaikio::Webhook.webhooks_for(client_name, data["name"],
                                                perform_now: perform_now)

        webhooks.each do |webhook|
          webhook[:block].call(data)
        end
      end
    end
  end
end
