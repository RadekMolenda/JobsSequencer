module Jobs
  class Sequencer
    def arrange jobs
      jobs
    end
    def self.arrange jobs
      new.arrange jobs
    end
  end
end
