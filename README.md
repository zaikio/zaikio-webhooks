# Zaikio::Webhook

Gem that enables you to easily subscribe to Zaikio's webhooks. It also enables
other gems to subscribe to events.

## Installation

1. Add this line to your application's Gemfile:

```ruby
gem 'zaikio-webhook'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install zaikio-webhook
```

2. Configure the gem:

```rb
# config/initializers/zaikio_webhook.rb

Zaikio::Webhook.configure do |config|
  config.register_client :my_app do |my_app|
    my_app.shared_secret = "test-secret"
  end
end
```

3. Mount Engine

```rb
mount Zaikio::Webhook::Engine => "/zaikio/webhook"
```


## Usage

Coming Soon
