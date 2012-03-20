module YmCms::Page
  
  def self.included(base)
    base.validates :title, :presence => true
    base.validates :slug, :uniqueness => true, :allow_blank => true
    base.belongs_to :parent, :class_name => "Page"
    base.has_many :children, :class_name => "Page", :foreign_key => 'parent_id'
    base.validate :parent_is_not_self_or_child
    base.scope :root, base.where(:parent_id => nil)
    base.scope :published, base.where(:published => true)
    base.extend(ClassMethods)
    base.image_accessor :image
  end
  
  module ClassMethods
    
    def view_names
      %w{basic tiled list}
    end
    
  end

  def has_image?
    !image_uid.blank?
  end
  
  def to_s
    title.html_safe
  end
  
  private
  def parent_is_not_self_or_child
    if parent_id.present?
      if parent_id == id
        errors.add(:parent, "can't be this page")
      elsif !new_record? && child_ids.include?(parent_id)
        errors.add(:parent, "can't be a child of this page")
      end
    end
  end
  
end