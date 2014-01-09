# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','storm_fury','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'storm_fury'
  s.version = StormFury::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
bin/storm_fury
lib/storm_fury/version.rb
lib/storm_fury.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','storm_fury.rdoc']
  s.rdoc_options << '--title' << 'storm_fury' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'storm_fury'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.8.1')
  s.add_runtime_dependency('fog')
  s.add_runtime_dependency('pry')
  s.add_runtime_dependency('sshkey')
end
