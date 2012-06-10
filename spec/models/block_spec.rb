require 'spec_helper'

describe Block do
  let(:block){ FactoryGirl.create(:block) }

  describe "#to_param" do
    it "should return the label" do
      block.to_param.should == block.label
    end
  end

  describe "class method" do
    describe "finders" do
      it "should find the 'bio' block" do
        Block.should_receive(:find_by_label!).with("bio").and_return(block)
        Block.bio.should == block
      end

      it "should find the 'contact' block" do
        Block.should_receive(:find_by_label!).with("contact").and_return(block)
        Block.contact.should == block
      end

      it "should raise when not found" do
        lambda{ Block.bio }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
