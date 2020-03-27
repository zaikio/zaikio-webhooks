require "test_helper"

class Zaikio::Webhooks::Test < ActiveSupport::TestCase
  test "has version number" do
    assert_not_nil ::Zaikio::Webhooks::VERSION
  end

  test "it is configurable" do
    Zaikio::Webhooks.configure do |config|
      config.register_client :my_app do |my_app|
        my_app.shared_secret = "secret"
      end
    end

    client_configurations = Zaikio::Webhooks.configuration.client_configurations
    assert_equal "secret", client_configurations["my_app"].shared_secret
    assert_equal "secret", Zaikio::Webhooks.configuration.find!(:my_app).shared_secret
  end
end
