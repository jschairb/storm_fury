module StormFury::CLI
  class Servers < Resource
    def create
      # -m metadata
      # -d domain
      # -e environment
      # -h host
      # -n deployment name

      attributes = {}.tap do |attrs|
        [:flavor_id, :image_id, :keypair].each do |opt|
          attrs[opt] = options[opt]
        end
        attrs[:name] = args.first
      end

      server = StormFury::Server.create(attributes, options)
      if server.persisted?
        io.puts "[SUCCESS] Created server."
      else
        io.puts "[FAILED] Unable to create server."
      end
    end
  end
end
