module StormFury::Resource
  class Server
    attr_accessor :attributes, :service

    def self.create(attributes, options = {})
      server = new(attributes, options)
      server.create
    end

    def initialize(attributes, options = {})
      self.attributes = attributes
      self.service    = options.fetch(:service, StormFury.default_service)
    end

    def create
      service.servers.create(attributes)
    rescue Fog::Compute::RackspaceV2::ServiceError => error
      fail ResourceNotCreatedError, error.message
    end
  end
end
