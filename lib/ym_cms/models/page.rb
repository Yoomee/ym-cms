module YmCms::Page
  
  def self.included(base)
    base.send(:include, YmCore::Model)
    base.image_accessor :image    
    base.validates :title, :presence => true
    base.validates :slug, :uniqueness => true, :allow_blank => true
    base.belongs_to :parent, :class_name => "Page"
    base.has_many :all_children, :class_name => "Page", :foreign_key => 'parent_id'
    base.has_many :children, :class_name => "Page", :foreign_key => 'parent_id', :conditions => {:draft => false}
    base.validate :parent_is_not_self_or_child
    base.belongs_to :user
    base.send(:validates_property, :format, :of => :image, :in => [:jpeg, :jpg, :png, :gif], :message => "must be an image")    
    base.scope :root, base.where(:parent_id => nil)
    base.scope :published, lambda {base.where(:draft => false)}
    base.scope :latest, base.order("IFNULL(publication_date, created_at) DESC")
    base.scope :for_month_and_year, lambda {|month, year| {:conditions => ["MONTH(IFNULL(publication_date, created_at))=:month AND YEAR(IFNULL(publication_date, created_at))=:year", {:month => month, :year => year}]}}
    base.has_permalinks
    base.extend(ClassMethods)
    base.delegate(:slug, :to => :root, :prefix => true, :allow_nil => true)
  end
  
  module ClassMethods
    
    def view_names
      %w{basic tiled list}
    end
    
  end
  
  def parents
    [parent, parent.try(:parents)].flatten.compact
  end
  
  def published?
    !draft?
  end  
  
  def root
    root? ? self : parent.root
  end
  
  def root?
    parent.nil?
  end
  
  def to_s
    (short_title.presence || title).html_safe
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