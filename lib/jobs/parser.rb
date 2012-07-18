module Jobs
  class Parser
    def parse string
      parse_jobs string
    end
    def self.parse string
      new.parse string
    end

    #I only want to expose parse method
    private
    def parse_job string
      args = string.split("=>").map{ |e| e.delete(" ") }
      args[1] ? Job.new(args[0], args[1]) : Job.new(args[0])
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
