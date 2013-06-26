module YmCms::SlideshowsController
  
  def self.included(base)
    base.load_and_authorize_resource
    base.prepend_before_filter(:unnest_params, :only => [:create, :update])
  end

  def edit
    @slideshow.independent_slideshow = true
  end

  def index
    @slideshows = Slideshow.where('slug IS NOT NULL')
  end

  def new
    @slideshow.independent_slideshow = true
  end

  def create
    if @slideshow.save
      flash_notice(@slideshow)
      redirect_to @slideshow
    else
      render :action => "new"
    end  
  end

  def show
  end  
  
  def update
    if @slideshow.update_attributes(params[:slideshow])
      redirect_to @slideshow
    else
      render :action => "edit"
    end
  end
  
  private
  def unnest_params
    params[:slideshow] = params[:slideshow][:slideshow]
  end
  
end
