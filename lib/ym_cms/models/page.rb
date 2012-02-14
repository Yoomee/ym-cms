module YmCms::Page
  def self.included(base)
    base.validates :title, :presence => true
    base.belongs_to :parent, :class_name => "Page"
    base.has_many :children, :class_name => "Page", :foreign_key => 'parent_id'
    base.validate :parent_is_not_self_or_child
    base.scope :root, base.where(:parent_id => nil)
  end
  
  private
  def parent_is_not_self_or_child
    if parent_id.present?
      if parent_id == id
        errors.add(:parent, "can't be this page")
      elsif child_ids.include?(parent_id)
        errors.add(:parent, "can't be a child of this page")
      end
    end
  end
end