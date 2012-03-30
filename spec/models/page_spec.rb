require 'spec_helper'

describe Page do
  
  it { should belong_to(:parent) }
  it { should have_many(:children) }
  it { should have_many(:all_children) }
  it { should validate_presence_of(:title) }

  describe do  
    
    let(:page) { FactoryGirl.create(:page) } 
    
    it "should be valid" do
      page.should be_valid
    end
    
    it "should validate presence of title" do
      page.title = nil
      page.should have(1).error_on(:title)
    end
    
    it "cannot be it's own parent" do
      page.parent_id = page.id
      page.should have(1).error_on(:parent)
    end
  
    it "cannot be a child of it's child" do
      child_page = FactoryGirl.create(:page, :title => "Child page", :parent => page, :id => page.id + 1)
      page.parent_id = child_page.id
      page.should have(1).error_on(:parent)
    end
    
    it "should have the default view name" do
      page.view_name.should eq('basic')
    end
    
  end
  
end