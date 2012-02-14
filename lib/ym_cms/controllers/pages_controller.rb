module YmCMS::PagesController
  def self.included(base)
    base.expose(:page)
    base.expose(:pages) { Page.root }
  end
  
  def create
    if page.save
      redirect_to page
    else
      render :action => "new"
    end
  end 
  
  def update
    if page.save
      redirect_to page
    else
      render :action => "edit"
    end
  end
end