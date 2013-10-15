module YmCms::SlideshowsHelper
  def render_slideshow_by_slug(slug)
    render 'slideshows/slideshow', :slideshow => ::Slideshow.find_by_slug(slug)
  end
end