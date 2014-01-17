require 'ansi/progressbar'

module StormFury::CLI
  class ProgressReport
    attr_reader :bar, :server

    def self.run(server)
      progress_report = new(server)
      progress_report.run
    end

    def initialize(server)
      @bar    = ANSI::Progressbar.new(server.name, 100)
      @server = server
    end

    def increment!(value = nil)
      if value
        value.times { bar.inc }
      else
        bar.inc
      end
    end

    def run
      progress = server.progress.to_i

      until server.ready?
        sleep(2)
        server.reload
        progress = server.progress - progress
        increment! progress
      end
    end
  end
end
