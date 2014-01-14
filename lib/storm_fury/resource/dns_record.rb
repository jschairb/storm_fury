module StormFury::Resource
  class DNSRecord
    attr_accessor :attributes, :domain, :service

    def self.create(domain, attributes, options = {})
      record = new(domain, attributes, options)
      record.create
    end

    def initialize(domain, attributes, options = {})
      self.attributes = attributes
      self.domain     = domain
      self.service    = options.fetch(:service, Fog::DNS.new(provider: :rackspace))
    end

    def create
      zones      = service.zones.inject([]) { |zones, zone| zones << zone }
      zone       = zones.select { |z| z.domain == domain }.first
      record_attributes = {
        type: 'A',
        name: attributes[:name],
        value: attributes[:ip_address],
        ttl: 300,
        zone: zone,
        service: service
      }
      record = Fog::DNS::Rackspace::Record.new(record_attributes)
      record.save
      record.persisted?
    end
  end
end
