require 'ym_core'
require 'ym_permalinks'
require 'ym_videos'

require 'ym_cms/engine'

module YmCms
end

require 'ym_cms/has_slideshow'
ActiveRecord::Base.extend YmCms::HasSlideshow

Dir[File.dirname(__FILE__) + '/ym_cms/models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/ym_cms/controllers/*.rb'].each {|file| require file }

require 'rack/cache'