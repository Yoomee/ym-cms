module YmCms::Slide
  
  def self.included(base)
    base.image_accessor :image
    base.send(:include, YmVideos::HasVideo)    
    base.belongs_to :slideshow    
    base.send(:validates_property, :format, :of => :image, :in => [:jpeg, :jpg, :png, :gif], :message => "must be an image")
    base.validates :position, :numericality => true, :allow_blank => true
    base.validates :image, :presence => true
  end
  
end