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
  s.summary     = "Summary of YmCms."
  s.description = "Description of YmCms."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "ym_core"
  s.add_dependency "ym_permalinks"
  s.add_dependency "rack-cache"
  s.add_dependency "mercury-rails", "~> 0.3.1"

  # for testing
  s.add_development_dependency "mysql2"    
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"  
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency "capybara"
  s.add_development_dependency "guard-rspec"

end
