module StormFury::CLI::Output
  module Message
    extend self

    def error(text)
      colorized_message(:on_red, "[ERROR] #{text}")
    end

    def failure(text)
      colorized_message(:red, "[FAILURE] #{text}")
    end

    def success(text)
      colorized_message(:green, "[SUCCESS] #{text}")
    end

    private
    def colorized_message(color, text)
      ANSI.send(color, text)
    end
  end
end
