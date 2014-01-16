module StormFury::CLI
  class Servers < Resource
    def create
      # -m metadata
      # -e environment
      # -h host
      # -n deployment name

      domain = options[:domain]
      name   = args.first

      host   = [name, domain].join('.')

      attributes = {}.tap do |attrs|
        [:flavor_id, :image_id, :keypair].each do |opt|
          attrs[opt] = options[opt]
        end
        attrs[:name]     = host
        attrs[:metadata] = { deployment: name }
      end

      server = StormFury::Server.create(attributes, options)

      if server.persisted?
        ProgressReport.run(server)
        io.puts "[SUCCESS] Created server."

        if StormFury::Resource::DNSRecord.create(domain, { ip_address: server.ipv4_address, name: host })
          io.puts "[SUCCESS] Created DNS record."
          ssh = Fog::SSH.new(server.ipv4_address, server.username, { keys: [File.expand_path(options[:keypath])] })
          if ssh.run("curl -L http://bootstrap.saltstack.org | sh -s -- -n git v0.17.4").first.status == 0
            io.puts "[SUCCESS] Bootstrapped salt minion."
          else
            io.puts "[FAILURE] Unable to bootstrap salt minion."
          end
        else
          io.puts "[FAILED] Unable to create DNS record."
        end

      else
        io.puts "[FAILED] Unable to create server."
      end
    end
  end
end
