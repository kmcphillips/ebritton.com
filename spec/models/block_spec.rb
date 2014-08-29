require 'spec_helper'

describe Block do
  let(:block){ FactoryGirl.create(:block) }

  describe "#to_param" do
    it "should return the label" do
      expect(block.to_param).to eq(block.label)
    end
  end

  describe "class method" do
    describe "finders" do
      it "should find the 'bio' block" do
        expect(Block).to receive(:find_by_label!).with("bio").and_return(block)
        expect(Block.bio).to eq(block)
      end

      it "should find the 'contact' block" do
        expect(Block).to receive(:find_by_label!).with("contact").and_return(block)
        expect(Block.contact).to eq(block)
      end

      it "should raise when not found" do
        expect(lambda{ Block.bio }).to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
