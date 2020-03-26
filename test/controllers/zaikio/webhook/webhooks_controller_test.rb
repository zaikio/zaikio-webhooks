require "test_helper"

module Zaikio
  module Webhook
    class WebhooksControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      def setup
        Zaikio::Webhook.configure do |config|
          config.register_client :my_app do |my_app|
            my_app.shared_secret = "test-secret"
          end
        end
      end

      def signature(shared_secret, data)
        OpenSSL::HMAC.hexdigest("SHA256", shared_secret, data.to_json)
      end

      test "does nothing with no signature / secret" do
        WebhookExecutionJob.expects(:perform_later).never
        WebhookExecutionJob.expects(:perform_now).never
        post zaikio_webhook.root_path("my_app")
        assert_response :success
      end

      test "schedules job with valid signature" do
        data = {
          "name" => "directory.revoked_access_token",
          "payload" => {
            "custom_attribute" => "abc"
          }
        }
        WebhookExecutionJob.expects(:perform_later).with(data)
        WebhookExecutionJob.expects(:perform_now).never
        post zaikio_webhook.root_path("my_app"), params: data.to_json, headers: {
          "X-Loom-Signature" => signature("test-secret", data),
          "Content-Type" => "application/json"
        }
        assert_response :success
      end

      test "does nothing with wrong signature" do
        data = { "name" => "directory.revoked_access_token" }
        WebhookExecutionJob.expects(:perform_later).never
        WebhookExecutionJob.expects(:perform_now).never
        post zaikio_webhook.root_path("my_app"), params: data.to_json, headers: {
          "X-Loom-Signature" => signature("wrong-secret", data),
          "Content-Type" => "application/json"
        }
        assert_response :success
      end
    end
  end
end
