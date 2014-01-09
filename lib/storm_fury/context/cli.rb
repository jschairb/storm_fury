require 'progress_bar'

module StormFury::Context
  class CLI
    class Progress
      attr_reader :bar

      def initialize
        @bar = ProgressBar.new(100, :bar, :percentage, :elapsed)
      end

      def increment!(value = nil)
        if value
          bar.increment! value
        else
          bar.increment
        end
      end
    end
  end
end
