module YmCms::Slide
  
  def self.included(base)
    base.belongs_to :slideshow
    base.image_accessor :image
    base.validates :position, :numericality => true, :allow_blank => true
    base.validates :image, :presence => true
  end
  
end