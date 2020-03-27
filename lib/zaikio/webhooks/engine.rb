module Zaikio
  module Webhooks
    class Engine < ::Rails::Engine
      isolate_namespace Zaikio::Webhooks
      engine_name "zaikio_webhooks"
      config.generators.api_only = true
    end
  end
end
