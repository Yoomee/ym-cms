module YmCms::Slideshow
  
  def self.included(base)
    base.belongs_to :attachable, :polymorphic => true
    base.has_many :slides, :dependent => :destroy
  end
  
end