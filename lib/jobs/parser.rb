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
      Job.new *args
    end
    def parse_jobs string
      string.split("\n").map do |line|
        parse_job line
      end
    end
  end
end
