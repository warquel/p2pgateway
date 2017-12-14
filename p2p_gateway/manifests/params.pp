class p2p_gateway::params (
    $bin_directory       = "/srv/p2pgateway/bin",
    $working_directory   = "/srv/p2pgateway/var",
    $config_directory    = "/srv/p2pgateway/etc",
    $home_directory      = "/srv/p2pgateway",
    $user                = "p2pgateway",
    $group               = "p2pgateway",
    $localname           = $::fqdn,
    $ip                  = $::ipaddress,
    $private_key_path    = "client.key_secret",
    $public_key_dir_path = "./public_keys",
    $disco_proto         = "tcp",
    $disco_ip            = $::ipaddress,
    $disco_port          = "9999",
    $zyre_proto          = "tcp",
    $zyre_ip             = "*",
    $zyre_port           = "5670",
    $pubsub_proto        = "tcp",
    $pubsub_ip           = "127.0.0.1",
    $pubsub_port         = "14000",
    $control_proto       = "tcp",
    $control_ip          = "127.0.0.1",
    $control_port        = "14001",
    $disable_curve       = false,
    $gwmode              = "discovery",
) {
}
