require 'spec_helper'

describe "Pages" do
  
  describe "GET /pages" do
    it "should list page titles" do
      cms_page = FactoryGirl.create(:page)
      visit pages_path
      page.should have_content(cms_page.title)
    end
  end

  describe "GET /pages#show" do
    let(:cms_page) { FactoryGirl.create(:page, :view_name => "basic") }
    it "should show page title" do
      visit page_path(cms_page)
      page.should have_content(cms_page.title)
    end
    describe "basic view" do
      it "should render views/basic" do
        get page_path(cms_page)        
        response.should render_template("views/basic")
      end
    end
    describe "tiled view" do
      before do
        cms_page.update_attribute(:view_name, "tiled")
      end
      it "should render views/tiled" do
        get page_path(cms_page)        
        response.should render_template("views/tiled")
      end
      it "should only display published children" do        
        FactoryGirl.create(:page, :title => "An unpublished page", :published => false, :parent => cms_page)
        FactoryGirl.create(:page, :title => "A published page", :published => true, :parent => cms_page)
        visit page_path(cms_page)        
        page.should_not have_content("An unpublished page")
        page.should have_content("A published page")        
      end
    end
    describe "list view" do
      before do
        cms_page.update_attribute(:view_name, "list")
      end
      it "should render views/basic" do
        get page_path(cms_page)        
        response.should render_template("views/list")
      end
      it "should only display published children" do        
        FactoryGirl.create(:page, :title => "An unpublished page", :published => false, :parent => cms_page)
        FactoryGirl.create(:page, :title => "A published page", :published => true, :parent => cms_page)
        visit page_path(cms_page)        
        page.should_not have_content("An unpublished page")
        page.should have_content("A published page") 
      end
    end
  end
  
  describe "GET /pages#new" do
    it "should show page form" do
      visit new_page_path
      page.has_css? "form#new_page"
    end
  end
  
  describe "GET /pages#edit" do
    it "should show page form" do
      cms_page = FactoryGirl.create(:page)      
      visit edit_page_path(cms_page)
      page.has_css? "form#edit_page_#{cms_page.id}"
    end
  end
  
  describe "create a page" do
    it "should redirect to pages#show if valid" do
      visit new_page_path
      fill_in 'Title', :with => "New page title"
      click_button 'Save'
      current_url.should eq(page_url(Page.last))
      page.should have_content("New page title")
    end
    it "should render pages#edit if invalid" do
      visit new_page_path
      fill_in 'Title', :with => ""
      click_button 'Save'
      current_url.should eq(pages_url)
      page.has_css? "form#new_page"
    end  
  end
  
  describe "update a page" do
    it "should redirect to pages#show if valid" do
      cms_page = FactoryGirl.create(:page, :title => "Old page title")
      visit edit_page_path(cms_page)
      fill_in 'Title', :with => "Updated page title"
      click_button 'Save'
      current_url.should eq(page_url(cms_page))
      page.should have_content("Updated page title")
    end
    it "should render pages#edit if invalid" do
      cms_page = FactoryGirl.create(:page, :title => "Old page title")
      visit edit_page_path(cms_page)
      fill_in 'Title', :with => ""
      click_button 'Save'
      current_url.should eq(page_url(cms_page))
      page.has_css? "form#edit_page_#{cms_page.id}"
    end   
  end
  
end
