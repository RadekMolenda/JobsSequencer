require 'spec_helper'

module Jobs
  describe "The challenge" do
    let(:one_job){ "a =>" }
    let(:three_jobs){ "a =>\nb =>\nc =>" }
    let(:three_jobs_d){ "a =>\nb => c\nc =>" }
    let(:six_jobs){ "a =>\nb => c\nc => f\nd => a\ne => b\nf =>" }
    let(:incorrect_three_jobs){ "a =>\nb =>\nc => c" }
    let(:incorrect_c_six_jobs){ "a =>\nb => c\nc => f\nd => a\ne =>\nf => b" }
    context "with empty string" do
      it "should be an empty sequence" do
        sequence = Parser.parse ""
        sequence.should be_empty
      end
    end
    context "with one job" do
      it "should be a sequence with one job" do
        sequence = Parser.parse one_job
        sequence.to_s.should eq "a"
      end
    end
    context "with three jobs" do
      it "should be a sequence of three jobs" do
        sequence = Parser.parse three_jobs
        sequence.to_s.should eq "abc"
      end
    end
    context "with three jobs (one job with dependency)" do
      it "should be a sequence in right order" do
        sequence = Parser.parse three_jobs_d
        sequence.to_s.should eq "acb"
      end
    end
    context "with six jobs (and some dependencies)" do
      it "should be a sequence in right order" do
        sequence = Parser.parse six_jobs
        sequence.to_s.should eq "afcbde"
      end
    end
    context "with job that has incorrect dependency" do
      it "should raise error" do
        lambda{ Parser.parse incorrect_three_jobs }.should raise_error
      end
    end
    context "with jobs that has circular dependencies" do
      it "should raise error" do
        lambda{ Parser.parse incorrect_c_six_jobs }.should raise_error
      end
    end
  end
end
