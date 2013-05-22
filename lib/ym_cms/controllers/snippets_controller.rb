module YmCms::SnippetsController

  def self.included(base)
    base.load_and_authorize_resource
  end
  
  def index
    @snippets = Snippet.where(:item_id => nil).order(:name)
  end
  
  def update
    @snippet.update_attributes(params[:snippet])
    if @snippet.save
      return_or_redirect_to snippets_path
    else
      render :action => :edit
    end
  end
  
end