# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2022-01-04

* Switch `Zaikio::Webhooks::Event#data` from an `OpenStruct` to a `Hash`. Note that `id`,
  `name`, `version` etc are already defined on the `Event` object - however if you need
  access to the raw event payload, you should lookup by hash accessor, e.g.:

```diff
-event.data.client_name
+event.data["client_name"]
```

* Allow usage with Rails 7.x applications

## [0.0.11] - 2021-04-20

* Fix bug where `event.payload` is converted to a String

### [0.0.10] - 2021-03-26

* Only require `railties` and `actionpack` to successfully run

### [0.0.9] - 2021-01-28
* Remove Rails 5 support
* Update Readme
### [0.0.8] - 2021-01-28
* Update rails dependency for Rails 5 support

### [0.0.7] - 2020-01-15
* Add a changelog
* Setup automated gem publishing

[Unreleased]: https://github.com/zaikio/zaikio-webhooks/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/zaikio/zaikio-webhooks/compare/v0.0.11...v0.1.0
[0.0.11]: https://github.com/zaikio/zaikio-webhooks/compare/v0.0.10...v0.0.11
[0.0.10]: https://github.com/zaikio/zaikio-webhooks/compare/v0.0.9...v0.0.10
[0.0.9]: https://github.com/zaikio/zaikio-webhooks/compare/v0.0.8...v0.0.9
[0.0.8]: https://github.com/zaikio/zaikio-webhooks/compare/v0.0.7...v0.0.8
[0.0.7]: https://github.com/zaikio/zaikio-webhooks/compare/55b26b3ea3982f13814d5b96e8650001f43fdc07...v0.0.7
