module YmCms::SlugHelper
  
  def slug_is?(slug)
    defined?(page) && page.slug == slug.to_s
  end
  
  def root_slug_is?(slug)
    defined?(page) && page.root_slug == slug.to_s
  end
  
end