module StormFury::Action
  class Create
    class ServerNotCreateError < StandardError; end

    attr_reader :flavor_id, :image_id, :key_pair, :name, :service

    def self.run(global_options, options, args)
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

    def run(wait = true)
      attributes = {
        flavor_id: flavor_id,
        image_id: image_id,
        keypair: key_pair,
        metadata: {
          deployment: name
        },
        name: name
      }
      server = create_server(attributes)
      return true unless wait

      wait_for_finish(server)
    end

    private
    def create_server(attributes)
      StormFury::Resource::Server.create(attributes)
     rescue StormFury::Resource::ResourceNotCreatedError => error
      fail ServerNotCreatedError, error.message
    end

    def wait_for_finish(server)
      bar = StormFury::Context::CLI::Progress.new
      progress = server.progress.to_i

      until server.ready?
        sleep(2)
        server.reload
        progress = server.progress - progress
        bar.increment! progress
      end
      true
    end
  end
end
