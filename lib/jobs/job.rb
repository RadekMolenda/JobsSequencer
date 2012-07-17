module Jobs
  class Job
    def initialize job_name = "", job_dependency = nil
      @name = job_name
      @dependency = job_dependency
    end
    def has_dependency?
      !@dependency.nil?
    end
    attr_accessor :name, :dependency
    def ==(obj)
      obj.name == @name
    end
  end
end
