require 'spec_helper'

describe Project do
  let(:project){ FactoryGirl.create(:project) }
  let(:file){ Tempfile.new("rspec") }

  describe "validation" do
    describe "#file_with_title" do
      it "should be valid with a file and a title" do
        project.file_title = "pie"
        project.file = file
        expect(project).to be_valid
      end

      it "should with no file and no title" do
        expect(project).to be_valid
      end

      it "should not be valid with a file and no title" do
        project.file = file
        expect(project).to_not be_valid
      end

      it "should not be valid with a title and no file" do
        project.file_title = "pie"
        expect(project).to_not be_valid
      end
    end
  end
end
