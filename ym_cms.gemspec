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

  s.add_dependency 'ym_core', "~> 1.0"
  s.add_dependency "ym_permalinks", "~> 1.0"
  #s.add_dependency "ym_videos", "~> 1.0.0" #TODO removed to get bundle for Rails 4
  s.add_dependency "rack-cache"

  # for testing
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"  
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency "capybara", '~> 1.1.0'
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "ym_tools", '~> 1.0'
  
  s.add_development_dependency "geminabox"

end
