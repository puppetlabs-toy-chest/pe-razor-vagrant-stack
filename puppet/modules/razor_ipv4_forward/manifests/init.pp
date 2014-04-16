class razor_ipv4_forward {

  file_line { 'ipv4.forward':
    path  => '/etc/sysctl.conf',
    line  => 'net.ipv4.ip_forward = 1',
    match => '^net.ipv4.ip_forward = [01]',
  }

  service { 'network':
    ensure    => 'running',
    subscribe => File_line['ipv4.forward'],
  }
}

