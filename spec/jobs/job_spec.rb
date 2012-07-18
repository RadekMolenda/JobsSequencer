require 'spec_helper'

module Jobs
  describe Job do
    let(:job){ Job.new }
    subject { job }
    it { should respond_to :name }
    it { should respond_to :dependency }
    it { should respond_to :has_dependency? }
    context "when has dependency" do
      before { job.dependency = Job.new("c") }
      subject { job.has_dependency? }
      it { should be_true }
    end
    context "when has no dependency" do
      before { job.dependency = nil }
      subject { job.has_dependency? }
      it { should be_false }
    end
    it "should raise error when trying to create job dependent on itself" do
      lambda { Job.new("a", Job.new("a")) }.should raise_error(JobsCantDependOnThemselvesError)
    end
    it "should raise error when trying to add dependency on itself" do
      job = Job.new "a"
      lambda { job.dependency= job }.should raise_error(JobsCantDependOnThemselvesError)
    end
    it "should raise error when trying to change name of job to name of jobs dependency" do
      job = Job.new "a", Job.new("b")
      lambda { job.name= "b" }.should raise_error(JobsCantDependOnThemselvesError)
    end
  end #Job
end
