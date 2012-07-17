module Jobs
  class Parser
    def parse string
      string.empty? ? nil : string
    end
    def self.parse string
      new.parse string
    end
  end
end
