class p2p_gateway::service {
  service { 'p2p_gateway':
    ensure => true,
    enable => true,
  }
}
