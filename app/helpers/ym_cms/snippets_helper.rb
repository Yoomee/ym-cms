module YmCms::SnippetsHelper

  def edit_snippet_link(name, options={})
    options.reverse_merge!(:link_text => "edit")
    snippet = ::Snippet.find_or_create_by_name(name)
    link_to(options[:link_text], edit_snippet_path(snippet), options) if can?(:edit, snippet)
  end
  
  def snippet_text(name,text=nil)
    snippet = ::Snippet.find_or_initialize_by_name(name)
    if snippet.new_record? || snippet.text.nil?
      snippet.text = text
      snippet.save
    end
    snippet.to_s.html_safe
  end

end
