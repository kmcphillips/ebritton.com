require 'spec_helper'

describe Event do
  let(:event){ FactoryGirl.create(:event) }

  

  describe "protected method" do
    describe "#set_ends_at" do
      it "should set ends at besed on starts at and number of days" do
        t = Time.now
        event.starts_at = t
        event.days = 3
        event.save!
        event.ends_at.should == (t + 3.days)
      end

      it "should not raise if there is data missing" do
        lambda{ Event.new.send(:set_ends_at) }.should_not raise_error
      end
    end
  end
end