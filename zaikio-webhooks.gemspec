$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "zaikio/webhooks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "zaikio-webhooks"
  spec.version     = Zaikio::Webhooks::VERSION
  spec.authors     = ["Zaikio GmbH"]
  spec.email       = ["js@crispymtn.com"]
  spec.homepage    = "https://github.com/zaikio/zaikio-webhooks"
  spec.summary     = "Handle incoming Zaikio loom webhooks"
  spec.description = "Handle incoming Zaikio loom webhooks"
  spec.license     = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["changelog_uri"] = "https://github.com/zaikio/zaikio-webhooks/blob/main/CHANGELOG.md"
    spec.metadata["source_code_uri"] = "https://github.com/zaikio/zaikio-webhooks"
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.required_ruby_version = ">= 2.6.5"

  spec.add_dependency "actionpack", ">= 6.0.2.2", "< 8"
  spec.add_dependency "activejob", ">= 6.0.2.2", "< 8"
  spec.add_dependency "railties", ">= 6.0.2.2", "< 8"
end
