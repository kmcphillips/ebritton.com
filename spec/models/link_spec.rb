require 'spec_helper'

describe Link do
  let(:link){ FactoryGirl.create(:link) }

  describe "validation" do
    it "should know if the url is valid" do
      expect(link).to be_valid
    end

    it "should know if the url is invalid" do
      link.url = "pie"
      expect(link).to_not be_valid
    end
  end
end
