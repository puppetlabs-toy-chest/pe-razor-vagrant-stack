class razor_client {

  package { 'pe-razor-client' :
    ensure   => present,
    provider => puppet_gem,
  }

  package { 'json_pure' :
    ensure   => present,
    provider => puppet_gem,
  }

  file { '/usr/bin/razor' :
    ensure  => link,
    target  => '/opt/puppetlabs/puppet/bin/razor',
    require => Package['pe-razor-client'],
  }

}
