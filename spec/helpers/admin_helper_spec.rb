require 'spec_helper'

describe AdminHelper do

  include AdminHelper

  describe "#imported_message" do
    it "should be a string" do
      expect(imported_message).to be_a(String)
    end
  end
end
