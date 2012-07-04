module YmCms::PagesController
  
  def self.included(base)
    base.load_and_authorize_resource
    base.send(:include, YmPermalinks::PermalinkableController)
  end
  
  def create
    set_user
    if @page.save
      flash_notice(@page)
      redirect_to @page
    else
      render :action => "new"
    end
  end
  
  def destroy
    @page.destroy
    flash_notice(@page)
    redirect_to @page.parent || pages_path
  end
  
  def new
    set_user
  end
  
  def order
    @page = Page.find_by_id(params[:id])
    @pages_for_ordering = @page.present? ? (@page.children || []) : Page.root
  end
  
  def show
    @page_children = @page.children || []
    render :action => "views/#{@page.view_name}"
  end
  
  def update
    if @page.update_attributes(params[:page])
      flash_notice(@page)
      redirect_to @page
    else
      render :action => "edit"
    end
  end
  
  def update_order
    params[:pages].each do |index, sortable_hash|
      puts "Updating page #{Page.find(sortable_hash[:sortable_id])} to position #{index}"
      Page.find(sortable_hash["sortable_id"]).update_attribute(:position, index)
    end
    redirect_to params[:id] ? page_path(params[:id]) : pages_path
  end
  
  private
  def set_user
    @page.user = current_user if @page.user.nil? && defined?(current_user)
  end
  
end