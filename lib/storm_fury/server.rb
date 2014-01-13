module StormFury
  class Server
    attr_reader   :attributes, :options
    attr_accessor :service

    def self.create(attributes, options = {})
      server = new(attributes, options)
      server.create
    end

    def initialize(attributes, options = {})
      @attributes  = attributes
      @options     = options
      self.service = options.fetch(:service, StormFury.default_service)
    end

    def create
      Resource::Server.create(attributes, { service: service })
    end
  end
end
