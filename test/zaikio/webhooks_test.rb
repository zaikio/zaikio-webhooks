require "test_helper"

class MyTestJob
end

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

  test "configure webhooks lazily" do
    Zaikio::Webhooks.configuration = nil
    Zaikio::Webhooks.reset
    Zaikio::Webhooks.on "my_event", MyTestJob
    assert_equal({}, Zaikio::Webhooks.webhooks)

    Zaikio::Webhooks.configure do |config|
      config.register_client :my_app do |my_app|
        my_app.shared_secret = "secret"
      end
    end

    assert_equal({
                   "my_app" => { "my_event" => [{ perform_now: false, job_klass: MyTestJob }] }
                 }, Zaikio::Webhooks.webhooks)

    Zaikio::Webhooks.on "my_other_event", MyTestJob

    assert_equal([{ perform_now: false, job_klass: MyTestJob }],
                 Zaikio::Webhooks.webhooks["my_app"]["my_other_event"])
  end
end
