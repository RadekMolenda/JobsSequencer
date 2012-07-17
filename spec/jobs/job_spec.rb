require 'spec_helper'

module Jobs
  describe Job do
    let(:job){ Job.new }
    subject { job }
    it { should respond_to :name }
    it { should respond_to :dependency }
    it { should respond_to :has_dependency? }
    context "when has dependency" do
      before { job.dependency = "c" }
      subject { job.has_dependency? }
      it { should be_true }
    end
    context "when has no dependency" do
      before { job.dependency = nil }
      subject { job.has_dependency? }
      it { should be_false }
    end
  end #Job
end
