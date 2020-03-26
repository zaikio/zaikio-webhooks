module Zaikio
  module Webhook
    class Engine < ::Rails::Engine
      isolate_namespace Zaikio::Webhook
      engine_name "zaikio_webhook"
      config.generators.api_only = true
    end
  end
end
