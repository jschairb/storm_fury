module StormFury
  module CLI
    class UnimplementedResourceError < StandardError; end

    class Resource
      attr_accessor :args, :global_options, :io, :options

      def self.create(global_options, options, args, io = $stdout)
        resource = new(global_options, options, args, io)
        resource.create
      end

      def initialize(global_options, options, args, io = $stdout)
        self.args           = args
        self.global_options = global_options
        self.io             = io
        self.options        = options
      end

      def create
        fail UnimplementedResourceError, "unimplemented method called on base class"
      end
    end
  end
end

require_relative 'cli/keypairs'
require_relative 'cli/servers'
