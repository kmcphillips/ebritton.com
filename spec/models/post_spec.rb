require 'spec_helper'

describe Post do
  let(:post){ FactoryGirl.create(:post) }

  describe "#sort_by" do
    it "should map to created_at" do
      post.should_receive(:created_at).and_return("pie")
      post.sort_by.should == "pie"
    end
  end

  describe "class method" do
    describe "#find_legacy" do
      it "should find using a scope based on the legacy url date format" do
        Post.should_receive(:created_on).with(Date.parse("31/12/1999")).and_return("pie")
        Post.find_legacy("1999/12/31").should == "pie"
      end
    end
  end
end
