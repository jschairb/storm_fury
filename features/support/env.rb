require 'aruba/cucumber'
require 'fileutils'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')
require 'storm_fury'

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
  mock_home_dir(File.join("/tmp", "storm_fury"))
end

After do
  ENV['RUBYLIB'] = @original_rubylib
  unmock_home_dir
end

def mock_home_dir(mock_home_dir)
  @real_home_dir = ENV['HOME']
  @mock_home_dir = mock_home_dir
  FileUtils.rm_rf mock_home_dir, secure: true
  set_env_home(@mock_home_dir)
end

def unmock_home_dir
  set_env_home(@real_home_dir)
end

def set_env_home(directory)
  ENV['HOME'] = directory
end
