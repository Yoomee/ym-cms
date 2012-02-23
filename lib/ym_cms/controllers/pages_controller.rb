module YmCms::PagesController
  
  def self.included(base)
    base.expose(:page)
    base.expose(:pages){Page.scoped_all}
  end
  
  def create
    if page.save
      redirect_to page
    else
      render :action => "new"
    end
  end
  
  def mercury_update
    page.title = params[:content][:page_title][:value]
    page.text = params[:content][:page_text][:value]
    page.save!
    render text: ""
  end
  
  def new
    page.parent_id = params[:parent_id]
  end
  
  def show
    render :action => "views/#{page.view_name}"
  end
  
  def update
    if page.save
      redirect_to page
    else
      render :action => "edit"
    end
  end
  
end