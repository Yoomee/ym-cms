module YmCms::MercuryHelper
  
  def mercury_edit_link(*args, &block)
    options = args.extract_options!.reverse_merge(:data => {})
    options[:data][:save_url] ||= args.second
    options[:class] = "#{options[:class]} mercury_edit_link".strip
    link_to(args.first, "/editor" + controller.request.path, options, &block)
  end
  
  def viewing_mercury_edit?
    controller.params[:mercury_frame]
  end
  
  def present_or_editing?(string)
    string.present? || viewing_mercury_edit?
  end
  
end