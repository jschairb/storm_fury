module StormFury::CLI
  class Servers < Resource
    def create
      if StormFury::Action::Create.run(global_options, options, args)
        io.puts "[SUCCESS] Created server."
      else
        io.puts "[FAILED] Unable to create server."
      end
    end
  end
end
