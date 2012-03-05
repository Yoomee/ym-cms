module YmCms::Slideshow
  
  def self.included(base)
    base.belongs_to :attachable, :polymorphic => true
    base.has_many :slides, :dependent => :destroy, :order => "position ASC"
    base.accepts_nested_attributes_for :slides, :reject_if => :all_blank, :allow_destroy => true
  end
  
end