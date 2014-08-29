require 'spec_helper'

describe ApplicationHelper do

  include ApplicationHelper

  describe "#body" do
    let(:post){ FactoryGirl.create(:post) }

    it "should run the body through the markdown parser if it is not imported" do
      md = double :markdown

      expect(RDiscount).to receive(:new).with(post.body).and_return(md)
      expect(md).to receive(:to_html).and_return(post.body)

      result = body(post)
      expect(result).to be_html_safe
    end

    it "should assume the imported data is safe to output as html" do
      post.imported = true
      result = body(post)
      expect(result).to eq(post.body)
      expect(result).to be_html_safe
    end
  end

end
