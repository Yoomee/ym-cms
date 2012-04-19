module YmCms::PagesController
  
  def self.included(base)
    base.expose(:page)
    base.expose(:page_children) { page ? page.children : [] }
    base.send(:include, YmPermalinks::PermalinkableController)
  end
  
  def create
    set_user
    if page.save
      flash_notice(page)
      redirect_to page
    else
      render :action => "new"
    end
  end
  
  def destroy
    page.destroy
    flash_notice(page)
    redirect_to page.parent || pages_path
  end
  
  def mercury_update
    page_attrs = {}
    params[:content].each do |k,v|
      page_attrs[k.to_s.sub(/^page_/,'')] = v["value"]
    end
    page.update_attributes!(page_attrs)
    render text: ""
  end
  
  def new
    page.parent_id = params[:parent_id]
    set_user
  end
  
  def show
    render :action => "views/#{page.view_name}"
  end
  
  def update
    if page.save
      flash_notice(page)
      redirect_to page
    else
      render :action => "edit"
    end
  end
  
  private
  def set_user
    page.user = current_user if page.user.nil? && defined?(current_user)
  end
  
end