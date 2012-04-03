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
  
  describe "that has snippets" do
    Page.has_snippets(:test_snippet)
    
    let(:page) { FactoryGirl.create(:page) }
    
    it "has many snippets" do
      page.should have_many(:snippets)
    end
    
    it "responds to snippet name getter" do
      page.should respond_to(:test_snippet)
    end
    
    it "responds to snippet name setter" do
      page.should respond_to("test_snippet=")
    end
    
    it "can set text of snippet" do
      page1 = FactoryGirl.create(:page, :test_snippet => "New snippet text")
      page1.test_snippet.should eq("New snippet text")
    end
    
    it "won't create snippet until page is created" do
      page1 = FactoryGirl.build(:page)
      page1.test_snippet = "New snippet text"
      Snippet.where(:item_id => nil).count.should == 0
    end

    it "can update snippet" do
      page1 = FactoryGirl.create(:page, :test_snippet => "Old snippet text")
      page1.test_snippet = "New snippet text"
      page1.test_snippet.should == "New snippet text"
    end
    
    it "destroy blank snippets" do
      page1 = FactoryGirl.create(:page, :test_snippet => "Snippet text")
      page1.test_snippet = ""
      page1.snippets.where(:name => "test_snippet").count == 0
    end
      
  end
  
end