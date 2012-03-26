$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ym_cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ym_cms"
  s.version     = YmCms::VERSION
  s.authors     = ["Matt Atkins", "Ian Mooney", "Si Wilkins"]
  s.email       = ["matt@yoomee.com", "ian@yoomee.com", "si@yoomee.com"]
  s.homepage    = "http://www.yoomee.com"
  s.summary     = "TODO: Summary of YmCms."
  s.description = "TODO: Description of YmCms."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "ym_core"
  s.add_dependency "ym_search"
  s.add_dependency "decent_exposure", "~> 1.0.1"
  s.add_dependency "formtastic", "~> 2.0.2"
  s.add_dependency "rack-cache"
  s.add_dependency "dragonfly", "~> 0.9.10"
  s.add_dependency "mercury-rails", "~> 0.3.1"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
