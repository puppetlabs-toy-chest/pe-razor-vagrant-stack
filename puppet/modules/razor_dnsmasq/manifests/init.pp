class razor_dnsmasq {

  $dnsmasq_config_dir = '/etc/dnsmasq.d'
  $dnsmasq_config_file = '/etc/dnsmasq.conf'

  package { 'dnsmasq' :
    ensure => installed,
  }

  service { 'dnsmasq' :
    ensure => running,
    require => Package['dnsmasq'],
  }

  file { "${dnsmasq_config_dir}" : 
    ensure => directory,
  }

  file { "${dnsmasq_config_dir}/hosts" : 
    ensure => file,
    source => 'puppet:///modules/razor_dnsmasq/dnsmasq.d/hosts',
    require => File["${dnsmasq_config_dir}"],
    notify => Service['dnsmasq'],
  }
 
  file { "${dnsmasq_config_dir}/razor" : 
    ensure => file,
    source => 'puppet:///modules/razor_dnsmasq/dnsmasq.d/razor',
    require => File["${dnsmasq_config_dir}"],
    notify => Service['dnsmasq'],
  }

  file { "${dnsmasq_config_dir}/virtualbox" : 
    ensure => file,
    source => 'puppet:///modules/razor_dnsmasq/dnsmasq.d/virtualbox',
    require => File["${dnsmasq_config_dir}"],
    notify => Service['dnsmasq'],
  }

  file { "${dnsmasq_config_file}" :
    ensure => present,
  }

  file_line { 'enable_dnsmasq_confdir':
    line => "conf-dir=${dnsmasq_config_dir}",
    path => "${dnsmasq_config_file}",
    require => File["${dnsmasq_config_file}"],
    notify => Service['dnsmasq'],
  }

  ##Setup TFTP directory
  file { '/var/lib/tftpboot' :
    ensure => directory,
    before => Service['dnsmasq']
  }
  
  file { '/var/lib/tftpboot/undionly-20140116.kpxe' :
    ensure => file,
    source => 'puppet:///modules/razor_dnsmasq/undionly-20140116.kpxe',
  }  

  exec { 'get bootstrap.ipxe from razor server' :
    command => '/usr/bin/wget http://razor-server:8080/api/microkernel/bootstrap?nic_max=1 -O /var/lib/tftpboot/bootstrap.ipxe',
    tries   => 10,
    try_sleep => 30,
    unless  => '/usr/bin/test -s /var/lib/tftpboot/bootstrap.ipxe',
  }
}
