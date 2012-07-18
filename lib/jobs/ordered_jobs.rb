#OrderedJobs
#I am using this class in Sequence class for storing jobs in right order
module Jobs
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
    #each time new_job is added to this class it is inserted at the right position
    def add new_job
      # at the beginning we can add new_job at the last position of array
      at = @jobs.length
      # we are looking for first job that is dependent on new_job
      @jobs.each_with_index do |job, index|
        at = index if job.dependency == new_job.name
      end
      @jobs.insert at, new_job
      # once the new_job is added to jobs array,
      # we should check if new_job dependency job is located before or after new_job's position
      # if dependency is located after new_job it means we have Circular Dependency
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
