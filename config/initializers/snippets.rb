class ActiveRecord::Base
   
  class << self

    def has_snippets(*snippet_names)
      has_many :snippets, :as => :item, :dependent => :destroy, :autosave => true
      accepts_nested_attributes_for :snippets, :allow_destroy => true, :reject_if => :all_blank
      snippet_names.each do |snippet_name|
        define_method snippet_name do
          snippets.detect{|s| s.name == snippet_name.to_s}.try(:text)
        end
        define_method "#{snippet_name}=" do |val|
          if existing_snippet = snippets.detect{|s| s.name == snippet_name.to_s}
            if val.present?
              existing_snippet.reload
              existing_snippet.text = val    
            else
              existing_snippet.mark_for_destruction
            end
          elsif val.present?
            self.snippets_attributes = [{:text => val, :name => snippet_name.to_s}]
          end
          val
        end
      end
    end

  end
  
end