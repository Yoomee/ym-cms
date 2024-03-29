module YmCms::PagesHelper
  
  def parent_page_select(form, options = {})
    options.reverse_merge!(:label => "Parent")
    current_page = form.object
    return "" if Page.without([current_page] + current_page.children).empty?
    out = form.label(:parent_id, options[:label], :class => 'control-label')
    out << content_tag(:div, form.select(:parent_id, content_tag(:option) + parent_page_option_tags(current_page)), :class => 'controls')
    content_tag(:div, out, :class => 'select control-group optional', :id => 'page_parent_input')
  end
  
  def parent_page_option_tags(current_page, options = {})
    options.reverse_merge!(:pages => Page.root, :indent => 0)
    parent_pages = options[:pages].without([current_page] + current_page.children)
    parent_pages.inject('') do |memo, parent_page|
      ret = "<option value='#{parent_page.id}'"
      ret << " selected='selected'" if current_page.parent == parent_page
      ret << ">#{'&nbsp;&nbsp;&nbsp;' * options[:indent]}#{parent_page}</option>"
      if parent_page.children.present?
        ret << parent_page_option_tags(current_page, :pages => parent_page.children, :indent => options[:indent] + 1)
      end
      memo + ret
    end.html_safe
  end
  
end