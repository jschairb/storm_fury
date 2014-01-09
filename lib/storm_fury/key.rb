require 'forwardable'
require 'sshkey'

module StormFury
  class Key
    class MissingErrorKey < StandardError; end

    attr_reader :path, :ssh_key

    extend Forwardable
    def_delegators :@ssh_key, *SSHKey.public_instance_methods(false)

    def initialize(path)
      @path     = path
      @ssh_key  = initialize_ssh_key
    end

    private
    def expanded_path
      File.expand_path(path)
    end

    def initialize_ssh_key
      SSHKey.new(File.read(expanded_path))
    rescue Errno::ENOENT
      fail MissingKeyError, "No such key file, #{expanded_path}"
    end
  end
end
