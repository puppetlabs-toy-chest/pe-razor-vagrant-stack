class razor_client {
  package { 'razor-client' :
    ensure   => latest,
    provider => puppet_gem,
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
