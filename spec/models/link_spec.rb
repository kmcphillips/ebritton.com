require 'spec_helper'

describe Link do
  let(:link){ FactoryGirl.create(:link) }

  describe "validation" do
    it "should know if the url is valid" do
      link.should be_valid
    end

    it "should know if the url is invalid" do
      link.url = "pie"
      link.should have(1).error_on(:url)
    end
  end
end
