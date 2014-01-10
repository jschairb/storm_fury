module StormFury
  module Resource
    class ResourceNotCreatedError < StandardError; end
  end
end

require_relative 'resource/server'
