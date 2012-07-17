require 'spec_helper'

module Jobs
  describe Sequence do
    describe "#arrange" do
      it "should be an empty sequence when there are no jobs" do
        Sequence.arrange("").should be_empty
      end
      it "should be a sequence consiting of a single job" do
        Sequence.arrange("a =>").should eq ["a"]
      end
    end
  end #Sequencer
end
