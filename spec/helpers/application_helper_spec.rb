require 'spec_helper'

describe ApplicationHelper do

  include ApplicationHelper

  describe "#body" do
    let(:post){ FactoryGirl.create(:post) }

    it "should run the body through the markdown parser if it is not imported" do
      md = mock :markdown

      RDiscount.should_receive(:new).with(post.body).and_return(md)
      md.should_receive(:to_html).and_return(post.body)

      result = body(post)
      result.should be_html_safe
    end

    it "should assume the imported data is safe to output as html" do
      post.imported = true
      result = body(post)
      result.should == post.body
      result.should be_html_safe
    end
  end
  
end
