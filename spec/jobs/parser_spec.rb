require 'spec_helper'

module Jobs
  describe Parser do
    it "should be nil when string argument is empty" do
      Parser.parse("").should be_empty
    end
    it "should create jobs sequence with one job" do
      jobs_sequence = Parser.parse("a =>")
      jobs_sequence.jobs.map(&:name).should eq ["a"]
      jobs_sequence.map(&:dependency).should eq []
    end
    it "should create jobs sequence with two jobs" do
      jobs_sequence = Parser.parse("a =>\nb =>")
      jobs_sequence.jobs.map(&:name).should eq ["a", "b"]
    end
    it "should create jobs sequence with one job with dependency" do
      jobs_sequence = Parser.parse("a => b")
      jobs_sequence.jobs.map(&:name).should eq ["a"]
      jobs_sequence.jobs.first.dependency.should eq "b"
    end
    it "should parse two jobs with dependencies" do
      jobs_sequence = Parser.parse("a => b\nb => c")
      jobs_sequence.jobs.map(&:name).should eq ["a", "b"]
    end
  end #Parser
end
