require "test_helper"

class Zaikio::Webhook::Test < ActiveSupport::TestCase
  test "has version number" do
    assert_not_nil ::Zaikio::Webhook::VERSION
  end
end
