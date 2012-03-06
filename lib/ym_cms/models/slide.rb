module YmCms::Slide
  
  def self.included(base)
    base.belongs_to :slideshow
    base.image_accessor :image
    base.validates :position, :numericality => true
  end
  
end