module YmCms::UrlHelper
  
  def link_to_slug(*args, &block)
    options = args.extract_options!
    if args.size == 2
      text, slug = [args[0], args[1].to_s]
    else
      text, slug = [nil, args[0].to_s]
    end
    page = ::Page.find_by_slug(slug)
    if block_given?
      link_to(page || "#", options, &block)
    else
      link_to(text || page || slug.titleize.humanize, page || "#", options)
    end
  end
  
end