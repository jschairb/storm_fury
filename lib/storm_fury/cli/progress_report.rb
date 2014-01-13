require 'progress_bar'

module StormFury::CLI
  class ProgressReport
    attr_reader :bar, :server

    def self.run(server)
      progress_report = new(server)
      progress_report.run
    end

    def initialize(server)
      @bar    = ProgressBar.new(100, :bar, :percentage, :elapsed)
      @server = server
    end

    def increment!(value = nil)
      if value
        bar.increment! value
      else
        bar.increment
      end
    end

    def run
      progress = server.progress.to_i

      until server.ready?
        sleep(2)
        server.reload
        progress = server.progress - progress
        bar.increment! progress
      end
    end
  end
end
