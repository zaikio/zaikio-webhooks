Zaikio::Webhook::Engine.routes.draw do
  get '/:app_name', to: 'webhooks#receive_event'
end
