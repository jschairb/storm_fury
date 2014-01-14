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
        else
          io.puts "[FAILED] Unable to create DNS record."
        end
      else
        io.puts "[FAILED] Unable to create server."
      end
    end
  end
end
