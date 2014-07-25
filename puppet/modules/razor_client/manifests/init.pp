class razor_client {

  package { 'pe-razor-client' :
    ensure   => present,
    provider => pe_gem,
  }

  package { 'json_pure' :
    ensure   => present,
    provider => pe_gem,
  }

  file { '/usr/bin/razor' :
    ensure  => link,
    target  => '/opt/puppet/bin/razor',
    require => Package['razor-client'],
  }

}
