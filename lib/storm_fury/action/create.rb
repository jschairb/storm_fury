module StormFury::Action
  class Create
    class ServerNotCreateError < StandardError; end

    attr_reader :flavor_id, :image_id, :key_pair, :name, :service

    def self.run(global_options, options, args)
      puts global_options
      puts options
      puts args
      create = new(global_options, options, args)
      create.run
    end

    def initialize(global_options, options, args)
      @flavor_id = options[:flavor_id]
      @image_id  = options[:image_id]
      @key_pair  = options[:key_pair]
      @name      = args.first
      @service   = StormFury.service
    end

    def run
      attributes = {
        flavor_id: flavor_id,
        image_id: image_id,
        keypair: key_pair,
        metadata: {
          deployment: name
        },
        name: name
      }
      create_server(attributes)
    end

    private
    def create_server(attributes)
      server = service.servers.create(attributes)
      puts server.inspect
    rescue Fog::Compute::RackspaceV2::ServiceError => error
      fail ServerNotCreatedError, error.message
    end
  end
end
