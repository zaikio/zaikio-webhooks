$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "zaikio/webhooks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "zaikio-webhooks"
  spec.version     = Zaikio::Webhooks::VERSION
  spec.authors     = ["Zaikio GmbH"]
  spec.email       = ["js@crispymtn.com"]
  spec.homepage    = "https://www.zaikio.com/"
  spec.summary     = "Handle incoming Zaikio loom webhooks"
  spec.description = "Handle incoming Zaikio loom webhooks"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0", ">= 6.0.2.2"
end
