module Jobs
  class JobsCantHaveCircularDependenciesError < StandardError
  end
  class OrderedJobs
    include Enumerable
    def initialize *jobs
      @jobs = []
      jobs.each do |job|
        add job
      end
    end
    attr_reader :jobs
    def each &block
      @jobs.each &block
    end
    def empty?
      @jobs.empty?
    end
    def add new_job
      at = @jobs.length
      @jobs.each_with_index do |job, index|
        at = index if job.dependency == new_job.name
      end
      @jobs.insert at, new_job
      @jobs.each_with_index do |job, index|
        raise JobsCantHaveCircularDependenciesError if new_job.dependency == job.name and index > at
      end
    end
    def length
      @jobs.length
    end
    alias :<< :add
  end
end
