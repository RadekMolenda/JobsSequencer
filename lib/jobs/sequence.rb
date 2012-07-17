module Jobs
  class Sequence
    def initialize *jobs
      @jobs = *jobs || []
    end
    attr_reader :jobs
    def add job
      @jobs << job
    end
    def ordered
      @jobs
    end
  end
end
