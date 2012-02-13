module YmCms::Page
  def self.included(base)
    base.validates :title, :presence => true
    base.belongs_to :parent, :class_name => "Page"
    base.has_many :children, :class_name => "Page", :foreign_key => 'parent_id'
  end
end