require "test_helper"

class Zaikio::Webhooks::EventSerializerTest < ActiveSupport::TestCase
  test "it stably serializes then deserializes an Event" do
    event_data = {
      "client_name" => "my_app",
      "id" => "62abcc92-e17e-4db0-b78e-13369251474b",
      "name" => "directory.machine_added",
      "subject" => "Org/2b271d51-e447-4a16-810f-5abdc596700a",
      "timestamp" => "2019-11-26T10:58:09.000Z",
      "version" => "1.0",
      "received_at" => "2019-11-26T10:58:09.000Z",
      "payload" => {
        "machine_id" => "9709f0f1-d00b-48fa-bb01-8c52bbd7296e",
        "site_id" => "80ef6969-0b4d-4959-8833-875d601f0922"
      },
      "link" => "https://directory.sandbox.zaikio.com/api/v1/machines/9709f0f1-d00b-48fa-bb01-8c52bbd7296e"
    }
    params = ActionController::Parameters.new(event_data).permit(
      :id, :client_name, :name, :subject, :timestamp, :version, :link, :received_at, payload: {}
    )
    event = Zaikio::Webhooks::Event.new(params)

    serialized = Zaikio::Webhooks::EventSerializer.serialize(event)
    deserialized = Zaikio::Webhooks::EventSerializer.deserialize(serialized)

    assert_equal event, deserialized
  end
end
