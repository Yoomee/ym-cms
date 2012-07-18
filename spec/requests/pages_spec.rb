require 'spec_helper'

describe "Pages" do
  
  describe "GET /pages#index" do    
    before do
      FactoryGirl.create(:page, :title => "Published page")
      FactoryGirl.create(:page, :title => "Draft page", :draft => true)
    end
    describe "when current_user is admin" do
      before do
        stub(:can? => true)
      end
      it "should show all pages" do
        visit pages_path
        page.should have_content("Published page")
        page.should have_content("Draft page")
      end
    end
    describe "when current_user is not admin" do
      it "should only show published pages" do
        visit pages_path
        page.should have_content("Published page")
        page.should_not have_content("Draft page")
      end
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
        FactoryGirl.create(:page, :title => "A draft page", :draft => true, :parent => cms_page)
        FactoryGirl.create(:page, :title => "A published page", :parent => cms_page)
        visit page_path(cms_page)        
        page.should_not have_content("A draft page")
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
        FactoryGirl.create(:page, :title => "A draft page", :draft => true, :parent => cms_page)
        FactoryGirl.create(:page, :title => "A published page", :parent => cms_page)
        visit page_path(cms_page)        
        page.should_not have_content("A draft page")
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
      current_path.should eq(page_path(Page.last))
      page.should have_content("New page title")
    end
    it "should render pages#edit if invalid" do
      visit new_page_path
      fill_in 'Title', :with => ""
      click_button 'Save'
      current_path.should eq(pages_path)
      page.has_css? "form#new_page"
    end  
  end
  
  describe "update a page" do
    it "should redirect to pages#show if valid" do
      cms_page = FactoryGirl.create(:page, :title => "Old page title")
      visit edit_page_path(cms_page)
      fill_in 'Title', :with => "Updated page title"
      click_button 'Save'
      current_path.should eq(page_path(cms_page.reload))
      page.should have_content("Updated page title")
    end
    it "should render pages#edit if invalid" do
      cms_page = FactoryGirl.create(:page, :title => "Old page title")
      visit edit_page_path(cms_page)
      fill_in 'Title', :with => ""
      click_button 'Save'
      current_path.should eq(page_path(cms_page))
      page.has_css? "form#edit_page_#{cms_page.id}"
    end   
  end
  
end
