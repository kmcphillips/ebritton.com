require 'spec_helper'

describe Event do
  let(:event){ FactoryGirl.create(:event) }

  describe "#sort_by" do
    it "should map to starts_at" do
      expect(event).to receive(:starts_at).and_return("pie")
      expect(event.sort_by).to eq("pie")
    end
  end

  describe "protected method" do
    describe "#set_ends_at" do
      it "should set ends at besed on starts at and number of days" do
        t = Time.now
        event.starts_at = t
        event.days = 3
        event.save!

        expect(event.ends_at).to eq(t + 3.days)
      end

      it "should not raise if there is data missing" do
        expect(lambda{ Event.new.send(:set_ends_at) }).to_not raise_error
      end
    end
  end
end
