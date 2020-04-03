require "test_helper"

class Zaikio::Webhooks::EventTest < ActiveSupport::TestCase
  test "event has correct attributes" do
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
    event = Zaikio::Webhooks::Event.new(event_data)

    assert_equal event_data["id"], event.id
    assert_equal event_data["client_name"], event.client_name
    assert_equal event_data["name"], event.name
    assert_equal event_data["version"], event.version
    assert_equal event_data["payload"], event.payload
    assert_equal event_data["link"], event.link
    assert_equal DateTime.new(2019, 11, 26, 10, 58, 9), event.created_at
    assert_equal DateTime.new(2019, 11, 26, 10, 58, 9), event.received_at
    assert_equal "Organization", event.subject_type
    assert_equal "2b271d51-e447-4a16-810f-5abdc596700a", event.subject_id
  end
end
