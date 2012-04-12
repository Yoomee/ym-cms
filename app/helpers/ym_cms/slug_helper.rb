module YmCms::SlugHelper
  
  def slug_is?(slug)
    respond_to?(:page) && page.slug == slug.to_s
  end
  
  def root_slug_is?(slug)
    respond_to?(:page) && page.root.slug == slug.to_s
  end
  
end