require 'spec_helper'

describe YmCms::MercuryHelper do

  describe "viewing_mercury_edit?" do
    
    it "returns true if request.path contains '/editor/'" do
      controller.params.stub!(:[], :mercury_frame).and_return true
      viewing_mercury_edit?.should be_true
    end
    
    it "returns false if request.path doesn't contains '/editor/'" do
      controller.params.stub!(:[], :mercury_frame).and_return false
      viewing_mercury_edit?.should be_false
    end
    
  end
  
  describe "mercury_edit_link" do
    it "returns a link with an href of mercury url and a data-save_url of second argument" do
      controller.request.stub!(:path).and_return '/current_path'
      mercury_edit_link("Edit link", "/update_path").should == link_to("Edit link", "/editor/current_path", :class => "mercury_edit_link", :data => {:save_url => "/update_path"})
    end
  end
  
end