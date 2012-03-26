require 'ym_cms/engine'

module YmCms
end

require 'decent_exposure'
require 'formtastic'

Dir[File.dirname(__FILE__) + '/ym_cms/models/*.rb'].each {|file| require file }

require 'ym_cms/controllers/pages_controller'
require 'rack/cache'
require 'mercury-rails'