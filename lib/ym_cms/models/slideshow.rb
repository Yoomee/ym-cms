module YmCms::Slideshow
  
  def self.included(base)
    base.belongs_to :attachable, :polymorphic => true
    base.has_many :slides, :dependent => :destroy, :order => "position ASC"
    base.accepts_nested_attributes_for :slides, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? { |key, value| %w{_destroy media_type} || value.blank? } }
  end
  
end