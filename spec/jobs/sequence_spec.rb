require 'spec_helper'

module Jobs
  describe Sequence do
    let(:job_a){ Job.new "a" }
    let(:job_c){ Job.new "c" }
    let(:job_f){ Job.new "f" }
    let(:job_b){ Job.new "b", job_c }
    let(:job_e){ Job.new "e", job_f }
    let(:job_d){ Job.new "d", job_e }
    describe "#add" do
      it "should add new job to sequence" do
        sequence = Sequence.new
        sequence.add job_a
        sequence.jobs.map(&:name).should eq ["a"]
      end
    end
    describe "#ordered" do
      it "should be an array with right job order" do
        sequence = Sequence.new job_a, job_c
        sequence.ordered.should eq [job_a, job_c]
      end
      context "when job has a dependency" do
        it "should order jobs in right order" do
          sequence = Sequence.new job_a, job_b, job_c
          sequence.ordered.should eq [job_a, job_c, job_b]
        end
      end
      context "when jobs has dependencies" do
        it "should order jobs in right order" do
          sequence = Sequence.new job_d, job_e, job_f
          sequence.ordered.should eq [job_f, job_e, job_d]
        end
      end
    end
    describe "#to_s" do
      it "should print ordered jobs names" do
        sequence = Sequence.new job_d, job_e, job_f
        sequence.to_s.should eq "fed"
        sequence.add job_a
        sequence.to_s.should eq "fead"
      end
    end
  end #Sequence
  describe "On the beach challenge" do
    context "single job" do
      let(:job) { Job.new "a" }
      it "should print 'a'" do
        sequence = Sequence.new job
        sequence.to_s.should eq "a"
      end
    end
    context "three jobs" do
      let(:job_a){ Job.new "a" }
      let(:job_b){ Job.new "b" }
      let(:job_c){ Job.new "c" }
      it "should print 'abc'" do
        sequence = Sequence.new job_a, job_b, job_c
        sequence.to_s.should eq "abc"
      end
    end
    context "jobs with dependencies" do
      let(:job_a){ Job.new "a" }
      let(:job_c){ Job.new "c" }
      let(:job_b){ Job.new "b", job_c }
      it "should print 'acb'" do
        sequence = Sequence.new job_a, job_b, job_c
        sequence.to_s.should eq "acb"
      end
    end
    context "jobs with more dependencies" do
      let(:job_a){ Job.new "a" }
      let(:job_f){ Job.new "f" }
      let(:job_c){ Job.new "c", job_f }
      let(:job_b){ Job.new "b", job_c }
      let(:job_d){ Job.new "d", job_a }
      let(:job_e){ Job.new "e", job_b }
      it "should print 'afcbde'" do
        sequence = Sequence.new job_a, job_b, job_c, job_d, job_e, job_f
        sequence.to_s.should eq "afcdbe"
      end
    end
  end
end
