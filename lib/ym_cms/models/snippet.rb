module YmCms::Snippet
  
  def self.included(base)
    base.belongs_to :item, :polymorphic => true
    base.validates :name, :uniqueness => {:scope => [:item_id, :item_type]}, :unless => Proc.new{|snippet| snippet.item_id.nil? || snippet.item_type.blank?}
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def site_snippet(name)
      find_or_create_by_name_and_item_id(name.to_s, nil)
    end
    
  end
  
  def to_s
    text
  end

end