Rails.application.routes.draw do
  mount Zaikio::Webhook::Engine => "/zaikio/webhooks"
end
