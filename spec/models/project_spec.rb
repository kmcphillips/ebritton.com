require 'spec_helper'

describe Project do
  let(:project){ FactoryGirl.create(:project) }
  let(:file){ Tempfile.new("rspec") }

  describe "validation" do
    describe "#file_with_title" do
      it "should be valid with a file and a title" do
        project.file_title = "pie"
        project.file = file
        project.should be_valid
      end

      it "should with no file and no title" do
        project.should be_valid
      end

      it "should not be valid with a file and no title" do
        project.file = file
        project.should_not be_valid
      end

      it "should not be valid with a title and no file" do
        project.file_title = "pie"
        project.should_not be_valid
      end
    end    
  end  
end
