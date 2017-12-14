class p2p_gateway (
    $bin_directory       = $p2p_gateway::params::bin_directory,
    $working_directory   = $p2p_gateway::params::working_directory,
    $config_directory    = $p2p_gateway::params::config_directory,
    $home_directory      = $p2p_gateway::params::home_directory,
    $user                = $p2p_gateway::params::user,
    $group               = $p2p_gateway::params::group,
    $localname           = $p2p_gateway::params::localname,
    $ip                  = $p2p_gateway::params::ip,
    $private_key_path    = $p2p_gateway::params::private_key_path,
    $public_key_dir_path = $p2p_gateway::params::public_key_dir_path,
    $disco_proto         = $p2p_gateway::params::disco_proto,
    $disco_ip            = $p2p_gateway::params::disco_ip,
    $disco_port          = $p2p_gateway::params::disco_port,
    $zyre_proto          = $p2p_gateway::params::zyre_proto,
    $zyre_ip             = $p2p_gateway::params::zyre_ip,
    $zyre_port           = $p2p_gateway::params::zyre_port,
    $pubsub_proto        = $p2p_gateway::params::pubsub_proto,
    $pubsub_ip           = $p2p_gateway::params::pubsub_ip,
    $pubsub_port         = $p2p_gateway::params::pubsub_port,
    $control_proto       = $p2p_gateway::params::control_proto,
    $control_ip          = $p2p_gateway::params::control_ip,
    $control_port        = $p2p_gateway::params::control_port,
    $disable_curve       = $p2p_gateway::params::disable_curve,
    $gwmode              = $p2p_gateway::params::gwmode,
    $binary              = "", # http://myrepo.com/gateway
) inherits p2p_gateway::params {
    anchor { 'p2p_gateway::begin': } ->
    class { 'p2p_gateway::install': } ->
    class { 'p2p_gateway::service': } ->
    anchor { 'p2p_gateway::end': }
}
