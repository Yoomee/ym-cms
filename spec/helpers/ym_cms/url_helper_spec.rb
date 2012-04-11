require 'spec_helper'

describe YmCms::UrlHelper do

  describe "link_to_slug" do
    
    describe "when page doesn't exist" do
    
      it "returns link_to '#'" do
        link_to_slug("A link", 'no-slug').should == link_to("A link", "#")
      end
    
      it "returns link_to '#' with default value of slug humanized" do
        link_to_slug('no-slug').should == link_to("No slug", "#")
      end
    
      it "returns link_to '#' with contents of block" do
        link_to_slug('no-slug') { "A link" }.should == link_to("#") { "A link"}
      end
    
    end

    describe "when page exists" do

      before do
        @page = FactoryGirl.build(:page)
        Page.stub(:find_by_slug => @page)
      end

      it "returns link_to page" do
        link_to_slug("A link", 'a-slug').should == link_to("A link", @page)
      end
      
      it "returns link_to page with default value of page.to_s" do
        link_to_slug('a-slug').should == link_to(@page, @page)
      end
    
      it "returns link_to page with contents of block if page exists with slug" do
        link_to_slug('a-slug') { "A link" }.should == link_to(@page) { "A link" }
      end
      
    end
    
  end
  
end