require 'spec_helper'

module Jobs
  describe Sequencer do
    describe "#arrange" do
      it "should be an empty sequence when there are no jobs" do
        Sequencer.arrange("").should be_empty
      end
    end
  end #Sequencer
end
