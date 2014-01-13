module StormFury::CLI
  class Keypairs < Resource
    def create
      if StormFury::Action::CreateKeyPair.run(global_options, options, args)
        io.puts "[SUCCESS] Created key pair."
      else
        io.puts "[FAILED] Unable to create key pair."
      end
    end
  end
end
