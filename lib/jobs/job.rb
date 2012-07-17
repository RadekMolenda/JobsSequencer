module Jobs
  class JobsCantDependOnThemselvesError < StandardError
  end
  class Job
    def initialize job_name = "", job_dependency = nil
      @name = job_name
      @dependency = job_dependency
      if job_dependency
        raise JobsCantDependOnThemselvesError if self == job_dependency
      end
    end
    def has_dependency?
      !@dependency.nil?
    end
    attr_accessor :name, :dependency
    def ==(obj)
      obj.name == name
    end
  end
end
