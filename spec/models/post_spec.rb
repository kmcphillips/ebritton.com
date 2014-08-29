require 'spec_helper'

describe Post do
  let(:post){ FactoryGirl.create(:post) }

  describe "#sort_by" do
    it "should map to created_at" do
      expect(post).to receive(:created_at).and_return("pie")
      expect(post.sort_by).to eq("pie")
    end
  end

  describe "class method" do
    describe "#find_legacy" do
      it "should find using a scope based on the legacy url date format" do
        expect(Post).to receive(:created_on).with(Date.parse("31/12/1999")).and_return("pie")
        expect(Post.find_legacy("1999/12/31")).to eq("pie")
      end
    end
  end
end
