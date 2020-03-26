require "test_helper"

class Zaikio::Webhook::Test < ActiveSupport::TestCase
  test "has version number" do
    assert_not_nil ::Zaikio::Webhook::VERSION
  end

  test "it is configurable" do
    Zaikio::Webhook.configure do |config|
      config.register_client :my_app do |my_app|
        my_app.shared_secret = "secret"
      end
    end

    client_configurations = Zaikio::Webhook.configuration.client_configurations
    assert_equal "secret", client_configurations[:my_app].shared_secret
  end
end
