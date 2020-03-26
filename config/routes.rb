Zaikio::Webhook::Engine.routes.draw do
  post "/:client_name", to: "webhooks#receive_event", as: :root
end
