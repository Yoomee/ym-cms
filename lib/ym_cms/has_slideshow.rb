module YmCms::HasSlideshow
  def has_slideshow
    class_eval do
      has_one :slideshow, :as => :attachable
      accepts_nested_attributes_for :slideshow, :reject_if => :all_blank
      before_save :delete_slideshow_if_no_slides
      send(:include, InstanceMethods)
    end
  end
  
  module InstanceMethods
    private
    def delete_slideshow_if_no_slides
      slideshow.mark_for_destruction if slideshow && slideshow.slides.size.zero?
    end
  end

end
