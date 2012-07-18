require 'spec_helper'

module Jobs
  describe Sequence do
    subject { Sequence.new }
    it { should respond_to :empty? }
    let(:job_a){ Job.new "a" }
    let(:job_c){ Job.new "c" }
    let(:job_f){ Job.new "f" }
    let(:job_b){ Job.new "b", "c" }
    let(:job_e){ Job.new "e", "f" }
    let(:job_d){ Job.new "d", "e" }
    describe "#add" do
      it "should add new job to sequence" do
        sequence = Sequence.new
        sequence.add job_a
        sequence.map(&:name).should eq ["a"]
      end
    end
    describe "#ordered" do
      it "should be an array with right job order" do
        sequence = Sequence.new job_a, job_c
        sequence.map(&:name).should eq ["a", "c"]
      end
      context "when job has a dependency" do
        it "should order jobs in right order" do
          sequence = Sequence.new job_a, job_b, job_c
          sequence.map(&:name).should eq ["a", "c", "b"]
        end
      end
      context "when jobs has dependencies" do
        it "should order jobs in right order" do
          sequence = Sequence.new job_d, job_e, job_f
          sequence.map(&:name).should eq ["f", "e", "d"]
        end
      end
    end
    describe "#to_s" do
      it "should print ordered jobs names" do
        sequence = Sequence.new job_d, job_e, job_f
        sequence.to_s.should eq "fed"
        sequence.add job_a
        sequence.to_s.should eq "feda"
      end
    end
    it "should raise error when trying to create sequence with a circular dependency" do
      job_g = Job.new "g", "c"
      job_c.dependency = "g"
      lambda { Sequence.new job_g, job_c }.should raise_error(JobsCantHaveCircularDependenciesError)
    end
    it "should raise error when trying to add job that will create a circular dependency" do
      job_g = Job.new "g", "c"
      job_c.dependency= "g"
      sequence = Sequence.new job_g
      lambda { sequence.add job_c }.should raise_error(JobsCantHaveCircularDependenciesError)
    end
    it "should raise error when trying to add jobs that will create a circular dependency" do
      job_1 = Job.new "b", "c"
      job_2 = Job.new "c", "f"
      job_3 = Job.new "f", "b"
      sequence = Sequence.new job_1, job_2
      lambda { sequence.add job_3 }.should raise_error(JobsCantHaveCircularDependenciesError)
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
      let(:job_b){ Job.new "b", "c" }
      it "should print 'acb'" do
        sequence = Sequence.new job_a, job_b, job_c
        sequence.to_s.should eq "acb"
      end
    end
    context "jobs with more dependencies" do
      let(:job_a){ Job.new "a" }
      let(:job_f){ Job.new "f" }
      let(:job_c){ Job.new "c", "f" }
      let(:job_b){ Job.new "b", "c" }
      let(:job_d){ Job.new "d", "a" }
      let(:job_e){ Job.new "e", "b" }
      it "should print 'afcbde'" do
        sequence = Sequence.new job_a, job_b, job_c, job_d, job_e, job_f
        sequence.to_s.should eq "afcbde"
      end
    end
  end
end
