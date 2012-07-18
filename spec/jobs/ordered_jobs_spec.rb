require 'spec_helper'

module Jobs
  describe OrderedJobs do
    subject { OrderedJobs.new }
    it { should respond_to :map }
    it { should respond_to :each }
    it { should respond_to :detect }
    it { should respond_to :<< }
    it { should respond_to :empty? }
    it { should respond_to :length }
    context "creation" do
      describe "success" do
        it "should store jobs in right order" do
          job_a = Job.new "a"
          job_b = Job.new "b"
          ordered_jobs = OrderedJobs.new job_a, job_b
          ordered_jobs.map(&:name).should eq ["a", "b"]
        end
        it "should store jobs with dependencies in right order" do
          job_a = Job.new "a"
          job_b = Job.new "b", "c"
          job_c = Job.new "c"
          ordered_jobs = OrderedJobs.new job_a, job_b, job_c
          ordered_jobs.map(&:name).should eq ["a", "c", "b"]
        end
        it "should store three jobs (with some dependencies) sequence in right order" do
          job_a = Job.new "a", "b"
          job_b = Job.new "b", "c"
          job_c = Job.new "c"
          ordered_jobs = OrderedJobs.new job_a, job_b, job_c
          ordered_jobs.map(&:name).should eq ["c", "b", "a"]
        end
      end
      describe "failure" do
        it "should avoid two jobs sequences with circular dependencies" do
          job_a = Job.new "a", "b"
          job_b = Job.new "b", "a"
          lambda { OrderedJobs.new job_a, job_b }.should raise_error(JobsCantHaveCircularDependenciesError)
        end
        it "should avoid three jobs sequences with circular dependencies" do
          job_a = Job.new "a", "b"
          job_b = Job.new "b", "c"
          job_c = Job.new "c", "a"
          lambda { OrderedJobs.new job_a, job_b, job_c }.should raise_error(JobsCantHaveCircularDependenciesError)
        end
      end
    end
  end
end
