require "test_helper"

class Zaikio::Webhook::WebhookExecutionJobTest < ActiveSupport::TestCase
  def setup
    Zaikio::Webhook.reset
  end

  def job
    Zaikio::Webhook::WebhookExecutionJob.new
  end

  test "performs only perform_now jobs for the correct client and event" do
    mock = OpenStruct.new(execute: nil)
    mock2 = OpenStruct.new(execute: nil)
    mock3 = OpenStruct.new(execute: nil)
    mock4 = OpenStruct.new(execute: nil)

    mock.expects(:execute)
    mock2.expects(:execute).never
    mock3.expects(:execute).never
    mock4.expects(:execute).never

    event = {
      "id" => "abc",
      "name" => "directory.revoked_access_token"
    }

    Zaikio::Webhook.on "directory.revoked_access_token", perform_now: true do |e|
      mock.execute
      assert_equal event, e
    end
    Zaikio::Webhook.on "directory.revoked_access_token" do
      mock2.execute
    end
    Zaikio::Webhook.on "directory.other_event", perform_now: true do
      mock3.execute
    end
    Zaikio::Webhook.on "directory.revoked_access_token",
                       client_name: "other_client", perform_now: true do
      mock4.execute
    end

    job.perform("my_app", event, perform_now: true)
  end
end
