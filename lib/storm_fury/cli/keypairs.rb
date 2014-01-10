module StormFury::CLI
  class Keypairs < Resource
    def create
      if StormFury::Action::CreateKeyPair.run(global_options, options, args)
        puts "[SUCCESS] Created key pair."
      else
        puts "[FAILED] Unable to create key pair."
      end
    end
  end
end
