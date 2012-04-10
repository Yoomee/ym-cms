module YmCms::UrlHelper
  def link_to_slug(*args, &block)
    if block_given?
      link_to(::Page.find_by_slug(args.first), args.second || {}, &block)
    else
      link_to(args.first, ::Page.find_by_slug(args.second), args.third || {})
    end
  end
end