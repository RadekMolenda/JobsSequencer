module Jobs
  class Job
    def initialize job_name = "", job_dependency = nil
      @name = job_name
      @dependency = job_dependency
    end
    attr_accessor :name, :dependency
  end
end
