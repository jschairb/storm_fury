require 'storm_fury/version.rb'
require 'fog'

module StormFury
  def self.default_domain
    "example.org"
  end

  # 1GB RAM, 20 GB SSD disk
  def self.default_flavor_id
    "performance1-1"
  end

  # CentOS 6.04
  def self.default_image_id
    "f70ed7c7-b42e-4d77-83d8-40fa29825b85"
  end

  def self.default_keypair
    "storm-deploy"
  end

  def self.default_keypair_path
    File.expand_path("~/.ssh/id_rsa")
  end

  def self.default_service
    service
  end

  def self.fog_config_file
    File.expand_path("~/.fog")
  end

  def self.service
    @service ||= Fog::Compute.new({ provider: 'rackspace', rackspace_region: :dfw, version: :v2 })
  end
end

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file
require 'storm_fury/action'
require 'storm_fury/cli'
require 'storm_fury/key'
require 'storm_fury/resource'
require 'storm_fury/server'
