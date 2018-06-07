# -*- mode: ruby -*-
# vi: set ft=ruby :

vagrant_dir = File.dirname(__FILE__)

#Vagrant.require_plugin('oscar')

require_relative 'debugkit/lib/puppet_debugging_kit/logging'

if defined? Oscar
  require_relative 'debugkit/lib/puppet_debugging_kit'

  # Oscar will load all YAML files in each directory listed below. Directories
  # that appear later in the array will append or overwrite config loaded from
  # directories that appear first in the array. The deep_merge gem is used to
  # effect this behavior.
  config_dirs = %w[
    debugkit/data/puppet_debugging_kit
    debugkit/config
    config
  ].map{|d| File.expand_path(d, vagrant_dir)}

  Vagrant.configure('2', &ConfigBuilder.load(:yaml_erb, :yamldir, config_dirs))

  # Ensure directory exists for local content repo
  #stackdir = '/Users/Shared/pe-razor-stack'
  #link     = File.expand_path('files', vagrantdir)

  # Right now this only works for *nix like operatingsystems, but presumably we
  # could support Windows Junctions as well.
  #Dir.mkdir(stackdir, 0755) unless File.exists?(stackdir)
  #File.symlink(stackdir, link) unless File.symlink?(link)
else
  PuppetDebuggingKit::Logging.global_logger.warn 'Oscar not available. No VMs will be defined.'
end
