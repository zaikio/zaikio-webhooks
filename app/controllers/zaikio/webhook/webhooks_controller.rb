module Zaikio
  module Webhook
    class WebhooksController < ApplicationController
      before_action :verify_signature

      def receive_event
        Zaikio::Webhook.webhooks_for(params[:client_name], event_params[:name]).each do |webhook|
          webhook[:job_klass].public_send(webhook[:perform_now] ? :perform_now : :perform_later,
                                          event_params)
        end

        head :ok
      end

      private

      def client_configuration
        Zaikio::Webhook.configuration.find!(params[:client_name])
      end

      def verify_signature
        unless ActiveSupport::SecurityUtils.secure_compare(
          OpenSSL::HMAC.hexdigest("SHA256", client_configuration.shared_secret, request.body.read),
          request.headers["X-Loom-Signature"].to_s
        )
          head :ok
        end
      end

      def event_params
        params.permit(:id, :name, :subject, :timestamp, :version, :link, :received_at, payload: {})
      end
    end
  end
end
