class razor_client {
  # Required for razor-client gem to install properly, since one of the
  # dependencies (`unf`) requires native extensions.
  package { ['gcc', 'gcc-c++']:
    ensure => present,
  }

  package { 'razor-client' :
    ensure   => present,
    provider => puppet_gem,
    require => [Package['gcc'], Package['gcc-c++']],
  }

  package { 'json_pure' :
    ensure   => present,
    provider => puppet_gem,
  }

  file { '/usr/bin/razor' :
    ensure  => link,
    target  => '/opt/puppetlabs/puppet/bin/razor',
    require => Package['razor-client'],
  }

}
