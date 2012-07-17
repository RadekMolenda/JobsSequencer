module Jobs
  class Parser
    def parse string
      parse_jobs string unless string.empty?
    end
    def self.parse string
      new.parse string
    end

    #I only want to expose parse method
    private
    def parse_job string
      args = string.split("=>").map{ |e| e.delete(" ") }
      if args[1]
        Job.new args[0], Job.new(args[1])
      else
        Job.new args[0]
      end
    end
    def parse_jobs string
      string.split("\n").map{ |line| parse_job line }
    end
  end
end
