class pe_env {
  $file = '/root/.bashrc_profile'

  file { $file :
    ensure => 'file',
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file_line { 'root_puppet_path':
    ensure  => present,
    line    => 'PATH=/opt/puppet/bin:$PATH; export PATH',
    path    => $file,
    match   => '^PATH.*$',
    require => File[$file],
  }

}
