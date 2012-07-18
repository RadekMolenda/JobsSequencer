module Jobs
  class Sequence
    include Enumerable
    def initialize *jobs
      @jobs = OrderedJobs.new *jobs
    end
    def add job
      @jobs << job
    end
    def each &block
      @jobs.each &block
    end
    def to_s
      map(&:name).join
    end
    def empty?
      @jobs.empty?
    end
  end
end
