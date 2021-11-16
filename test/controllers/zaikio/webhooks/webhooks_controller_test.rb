require "test_helper"

class MyJob < ApplicationJob
  def perform(event_data); end
end

class MyOtherJob < ApplicationJob
  def perform(event_data); end
end

class MyThirdJob < ApplicationJob
  def perform(event_data); end
end

module Zaikio
  module Webhooks
    class WebhooksControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      def setup
        Zaikio::Webhooks.configure do |config|
          config.register_client :my_app do |my_app|
            my_app.shared_secret = "test-secret"
          end
        end

        Zaikio::Webhooks.reset
      end

      def signature(shared_secret, data)
        OpenSSL::HMAC.hexdigest("SHA256", shared_secret, data.to_json)
      end

      def register_job(perform_now: false)
        Zaikio::Webhooks.on "directory.revoked_access_token", MyJob,
                            perform_now: perform_now
        Zaikio::Webhooks.on "directory.revoked_access_token", MyOtherJob,
                            client_name: "other_app", perform_now: perform_now
        Zaikio::Webhooks.on "directory.revoked_access_token", MyThirdJob,
                            perform_now: !perform_now
      end

      test "does nothing with no signature / secret" do
        register_job
        MyJob.expects(:perform_later).never
        MyJob.expects(:perform_now).never
        post zaikio_webhooks.root_path("my_app")
        assert_response :success
      end

      test "does nothing if no webhook was registered" do
        data = {
          "name" => "directory.revoked_access_token",
          "payload" => {
            "custom_attribute" => "abc"
          }
        }
        MyJob.expects(:perform_later).never
        MyJob.expects(:perform_now).never
        post zaikio_webhooks.root_path("my_app"), params: data.to_json, headers: {
          "X-Loom-Signature" => signature("test-secret", data),
          "Content-Type" => "application/json"
        }
        assert_response :success
      end

      test "schedules job with valid signature" do
        register_job
        data = {
          "name" => "directory.revoked_access_token",
          "payload" => {
            "custom_attribute" => "abc"
          }
        }
        MyJob.expects(:perform_later).with(
          Zaikio::Webhooks::Event.new(data.merge("client_name" => "my_app"))
        )
        MyOtherJob.expects(:perform_later).never
        MyThirdJob.expects(:perform_later).never
        MyThirdJob.expects(:perform_now).with(
          Zaikio::Webhooks::Event.new(data.merge("client_name" => "my_app"))
        )
        MyJob.expects(:perform_now).never
        post zaikio_webhooks.root_path("my_app"), params: data.to_json, headers: {
          "X-Loom-Signature" => signature("test-secret", data),
          "Content-Type" => "application/json"
        }
        assert_response :success
      end

      test "does nothing with wrong signature" do
        register_job
        data = { "name" => "directory.revoked_access_token" }
        MyJob.expects(:perform_later).never
        MyJob.expects(:perform_now).never
        post zaikio_webhooks.root_path("my_app"), params: data.to_json, headers: {
          "X-Loom-Signature" => signature("wrong-secret", data),
          "Content-Type" => "application/json"
        }
        assert_response :success
      end
    end
  end
end
