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
      job = Job.new args[0]
      job.dependency = args[1].nil? ? nil : Job.new(args[1])
      job
    end
    def parse_jobs string
      sequence = Sequence.new
      string.split("\n").each{ |line|
        sequence.add parse_job(line)
      }
      sequence
    end
  end
end
