require 'spec_helper'

describe ApplicationHelper do

  include ApplicationHelper

  describe "#body" do
    let(:post){ FactoryGirl.create(:post) }

    it "should run the body through the markdown parser if it is not imported" do
      
    end

    it "should assume the imported data is safe to output as html" do
      post.imported = true
      
    end
  end
  
end
