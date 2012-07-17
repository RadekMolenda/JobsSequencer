require 'spec_helper'

module Jobs
  describe Sequence do
    let(:job_a){ Job.new "a" }
    let(:job_b){ Job.new "b", "c" }
    let(:job_c){ Job.new "c" }
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
          pending "Jobs class needs to be refactored a litle"
          sequence = Sequence.new job_a, job_b, job_c
          sequence.ordered.should eq [job_a, job_c, job_b]
        end
      end
    end
  end #Sequencer
end
