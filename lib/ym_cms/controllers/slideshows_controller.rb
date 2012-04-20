module YmCms::SlideshowsController
  
  def self.included(base)
    base.expose(:slideshow)
    base.prepend_before_filter(:unnest_params, :only => [:update])
  end
  
  def update
    if slideshow.save
      redirect_to root_path
    else
      render :action => "edit"
    end
  end
  
  private
  def unnest_params
    puts params.inspect
    params[:slideshow] = params[:slideshow][:slideshow]
    puts params.inspect
  end
  
end