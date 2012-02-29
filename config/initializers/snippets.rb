class ActiveRecord::Base
   
  class << self

    def has_snippets(*snippet_names)
      has_many :snippets, :as => :item, :dependent => :destroy, :autosave => true
      snippet_names.each do |snippet_name|
        define_method snippet_name do
          snippets.find_by_name(snippet_name.to_s).try(:text)
        end
        define_method "#{snippet_name}=" do |val|
          snippets.find_or_initialize_by_name(snippet_name.to_s).update_attributes(:text => val)
        end
      end
    end

  end
  
end