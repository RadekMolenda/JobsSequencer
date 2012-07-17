require 'spec_helper'

module Jobs
  describe Job do
    subject { Job.new }
    it { should respond_to :name }
    it { should respond_to :dependency }
  end #Job
end
