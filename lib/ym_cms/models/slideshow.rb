module YmCms::Slideshow
  
  def self.included(base)
    base.belongs_to :attachable, :polymorphic => true
    base.has_many :slides, :dependent => :destroy, :order => "position ASC"
    base.validates :slug, :title, :presence => true, :if => :independent_slideshow
    base.validates :slug, :uniqueness => true, :if => :independent_slideshow
    base.boolean_accessor :independent_slideshow
    base.accepts_nested_attributes_for :slides, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? { |key, value| %w{_destroy media_type}.include?(key) || value.blank? } }
  end
  
end