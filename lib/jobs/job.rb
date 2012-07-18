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
      if obj.respond_to?(:name) and obj.respond_to?(:dependency)
        @name == obj.name and obj.dependency == @dependency
      end
    end
    private
    def validate obj
      raise JobsCantDependOnThemselvesError if self.name == obj
    end
  end
end
