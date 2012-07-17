require 'spec_helper'

module Jobs
  describe Parser do
    let(:job_a) { Job.new "a" }
    let(:job_b) { Job.new "b" }
    let(:job_c) { Job.new "c" }
    it "should be nil when string argument is empty" do
      Parser.parse("").should be_nil
    end
    it "should parse one job" do
      parsed_jobs = Parser.parse("a =>")
      parsed_jobs.should eq [job_a]
      parsed_jobs.map(&:dependency).should eq [nil]
    end
    it "should parse two jobs" do
      parsed_jobs = Parser.parse("a =>\nb =>")
      parsed_jobs.should eq [job_a, job_b]
    end
    it "should parse one job with dependency" do
      parsed_jobs = Parser.parse("a => b")
      parsed_jobs.should eq [job_a]
      parsed_jobs.map(&:dependency).should eq [job_b]
    end
    it "should parse two jobs with dependencies" do
      parsed_jobs = Parser.parse("a => b\nb => c")
      parsed_jobs.should eq [job_a, job_b]
      parsed_jobs.map(&:dependency).should eq [job_b, job_c]
    end

  end #Parser
end
