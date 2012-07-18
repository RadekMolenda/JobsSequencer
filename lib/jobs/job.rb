module Jobs
  class JobsCantDependOnThemselvesError < StandardError
  end
  class Job
    def initialize job_name = "", job_dependency = nil
      @name = job_name
      @dependency = job_dependency
      validate job_dependency
    end
    attr_accessor :name, :dependency
    def has_dependency?
      !@dependency.nil?
    end
    def dependency= obj
      validate obj
      @dependency = obj
    end
    def name= name
      @name= name
      validate dependency
    end
    def == obj
      obj.name == name
    end
    private
    def validate obj
      if obj
        raise JobsCantDependOnThemselvesError if self == obj
      end
    end
  end
end
