module YmCms::Slide
  
  def self.included(base)
    base.image_accessor :image
    base.send(:include, YmVideos::HasVideo)    
    base.belongs_to :slideshow    
    base.send(:validates_property, :format, :of => :image, :in => [:jpeg, :jpg, :png, :gif], :message => "must be an image", :if => :has_image?)
    base.validates :position, :numericality => true, :allow_blank => true
    base.validates :image, :presence => true, :if => :has_image?
    base.validates :video_url, :presence => true, :if => :has_video?
    base.send :attr_writer, :media_type
  end
  
  def has_image?
    media_type == 'image'
  end
  
  def has_video?
    media_type == 'video'
  end
  
  def media_type
    @media_type ||= begin
      case 
      when video_url.present?
        'video'
      else
        'image'
      end
    end
  end
  
  
end

YmCms::Slide::MEDIA_TYPES = %w{image video}