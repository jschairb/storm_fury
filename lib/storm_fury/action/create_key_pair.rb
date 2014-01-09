require 'fog/rackspace/models/compute_v2/key_pairs'

module StormFury::Action
  class CreateKeyPair
    class KeyNotCreatedError < StandardError; end

    attr_accessor :names
    attr_reader   :key

    def self.run(global_options, options, args)
      create_key_pair = new(global_options, options, args)
      create_key_pair.run
    end

    def initialize(global_options, options, args)
      self.names = args
      @key       = StormFury::Key.new(options[:path])
    end

    def run
      results = names.inject([]) do |results, key|
        results << create_key_pair(key)
        results
      end
      !results.select { |r| r == false }.any?
    end

    private
    def create_key_pair(name)
      key_pair = Fog::Compute::RackspaceV2::KeyPair.new(name: name,
                                                        public_key: key.ssh_public_key,
                                                        private_key: key.private_key,
                                                        fingerprint: key.md5_fingerprint,
                                                        service: StormFury.service)
      key_pair.save
    rescue Fog::Compute::RackspaceV2::ServiceError => error
      fail KeyNotCreatedError, error.message
    end
  end
end
