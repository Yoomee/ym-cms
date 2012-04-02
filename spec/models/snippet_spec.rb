require 'spec_helper'  

describe Snippet do
  
  it { should belong_to(:item) }

  describe do  
    
    let(:snippet) { FactoryGirl.create(:snippet) } 
    
    it "should be valid" do
      snippet.should be_valid
    end
      
  end
  
end