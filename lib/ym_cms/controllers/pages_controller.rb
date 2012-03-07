module YmCms::PagesController
  
  def self.included(base)
    base.expose(:page)
    base.expose(:page_children) { page ? page.children : [] }
  end
  
  def create
    if page.save
      redirect_to page.parent || page
    else
      render :action => "new"
    end
  end
  
  def destroy
    page.destroy
    redirect_to page.parent || pages_path
  end
  
  def mercury_update
    page.title = params[:content][:page_title][:value]
    page.text = params[:content][:page_text][:value]
    page_attrs = {}
    params[:content].each do |k,v|
      page_attrs[k.to_s.sub(/^page_/,'')] = v["value"]
    end
    puts params.inspect
    puts page_attrs.inspect
    page.update_attributes!(page_attrs)
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