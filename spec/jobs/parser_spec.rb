require 'spec_helper'

module Jobs
  describe Parser do
    let(:job) { Job.new "a" }
    it "should be nil when string argument is empty" do
      Parser.parse("").should be_nil
    end
    it "should be one job" do
      pending "Job class not introduced yet"
      parsed_job = Parser.parse("a =>")
      parsed_job.name.should eq job.name
      parsed_job.dependency.should eq job.dependency
    end
  end #Parser
end
