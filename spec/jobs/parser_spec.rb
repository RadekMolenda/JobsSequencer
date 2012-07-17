require 'spec_helper'

module Jobs
  describe Parser do
    it "should be nil when string argument is empty" do
      Parser.parse("").should be_nil
    end
    it "should parse one job" do
      parsed_jobs = Parser.parse("a =>")
      parsed_jobs.map(&:name).should eq ["a"]
      parsed_jobs.map(&:dependency).should eq [nil]
    end
    it "should parse two jobs" do
      parsed_jobs = Parser.parse("a =>\nb =>")
      parsed_jobs.map(&:name).should eq ["a", "b"]
    end
    it "should parse one job with dependency" do
      parsed_jobs = Parser.parse("a => b")
      parsed_jobs.map(&:name).should eq ["a"]
      parsed_jobs.map(&:dependency).should eq ["b"]
    end
    it "should parse two jobs with dependencies" do
      parsed_jobs = Parser.parse("a => b\nb => c")
      parsed_jobs.map(&:name).should eq ["a", "b"]
      parsed_jobs.map(&:dependency).should eq ["b", "c"]
    end

  end #Parser
end
