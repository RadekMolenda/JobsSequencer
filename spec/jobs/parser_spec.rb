require 'spec_helper'

module Jobs
  describe Parser do
    let(:job_a) { Job.new "a" }
    let(:job_b) { Job.new "b" }
    let(:job_c) { Job.new "c" }
    it "should be nil when string argument is empty" do
      Parser.parse("").should be_nil
    end
    it "should create jobs sequence with one job" do
      jobs_sequence = Parser.parse("a =>")
      jobs_sequence.should eq Sequence.new(job_a)
      jobs_sequence.map(&:dependency).should eq []
    end
    it "should create jobs sequence with two jobs" do
      jobs_sequence = Parser.parse("a =>\nb =>")
      jobs_sequence.should eq Sequence.new job_a, job_b
    end
    it "should create jobs sequence with one job with dependency" do
      jobs_sequence = Parser.parse("a => b")
      jobs_sequence.jobs.map(&:name).should eq ["a"]
      jobs_sequence.jobs.first.dependency.name.should eq "b"
    end
    it "should parse two jobs with dependencies" do
      jobs_sequence = Parser.parse("a => b\nb => c")
      jobs_sequence.jobs.map(&:name).should eq ["a", "b"]
      jobs_sequence.jobs.map(&:dependency).map(&:name).should eq ["b", "c"]
    end
  end #Parser
end
