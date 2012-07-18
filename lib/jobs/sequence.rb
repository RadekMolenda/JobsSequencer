module Jobs
  class JobsCantHaveCircularDependenciesError < StandardError
  end
  class Sequence
    include Enumerable
    def initialize *jobs
      @jobs = *jobs || []
      validate
    end
    attr_reader :jobs
    def add job
      @jobs << job
      validate
    end
    def find job_name
      @jobs.detect { |job| job.name == job_name }
    end
    def ordered
      ordered_jobs = []
      while ordered_jobs.length < @jobs.length
        @jobs.each do |job|
          if ordered_jobs.include? job
            next
          else
            add_job ordered_jobs, job
          end
        end
      end
      ordered_jobs
    end
    def each
      @jobs.each
    end
    def to_s
      ordered.map(&:name).join
    end
    def == sequence
      ordered == sequence.ordered
    end
    def empty?
      @jobs.empty?
    end
    private
    def add_job jobs, job
      job.has_dependency? ? add_job_with_dependency(jobs, job) : jobs.push(job)
    end
    def add_job_with_dependency jobs, job
      jobs.include?(find(job.dependency)) ? jobs.push(job) : get_job(jobs, job)
    end
    def get_job jobs, job
      unless jobs.include? job
        job.has_dependency? ? get_job(jobs, find(job.dependency)) : jobs.push(job)
      end
    end
    def validate
      @jobs.each do |job|
        jobs = []
        search jobs, job
      end
    end
    def search jobs, job
      jobs.push job
      if job and job.has_dependency?
        #check for circrular dependencies
        if jobs.include? find(job.dependency)
          raise JobsCantHaveCircularDependenciesError
        else
          search jobs, find(job.dependency)
        end
      end
    end
  end
end
