class razor_node_classification {

  file { '/etc/puppetlabs/puppet/manifests/site.pp' :
    ensure => file,
    #I couldn't figure out how to use puppet apply with the puppet:///
    source => 'puppet:///modules/razor_node_classification/site.pp',
    #source =>  '/vagrant/modules/razor_node_classification/files/site.pp'
  }

}
