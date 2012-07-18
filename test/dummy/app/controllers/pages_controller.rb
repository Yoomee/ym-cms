class PagesController < ApplicationController

  def self.load_and_authorize_resource
    before_filter :get_page_resource
  end

  include YmCms::PagesController
    
  private
  def get_page_resource
    if params[:id]
      @page = Page.find(params[:id])
    elsif params[:page]
      @page = Page.new(params[:page])
    elsif action_name == "new"
      @page = Page.new
    end
  end
  
end