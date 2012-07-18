module Jobs
  class Sequence
    include Enumerable
    def initialize *jobs
      @jobs = OrderedJobs.new *jobs
    end
    attr_reader :jobs
    def add job
      @jobs << job
    end
    def find job_name
      @jobs.detect { |job| job.name == job_name }
    end
    def each &block
      @jobs.each &block
    end
    def to_s
      @jobs.map(&:name).join
    end
    def == sequence
      ordered == sequence.ordered
    end
    def empty?
      @jobs.empty?
    end
  end
end
