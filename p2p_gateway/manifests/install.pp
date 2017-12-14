class p2p_gateway::install inherits p2p_gateway {
    if $p2p_gateway::gwmode == "discovery" {
        $zyre_bind = false
        $pubsub_endpoint = false
        $control_endpoint = false
        $startparam = "disco ${::p2p_gateway::disco_proto}://${::p2p_gateway::disco_ip}:${::p2p_gateway::disco_port}"
    }
    elsif $p2p_gateway::gwmode == "client" {
        $zyre_bind = true
        $pubsub_endpoint = true
        $control_endpoint = true
        $startparam = $::fqdn
    } else {
        warning("This p2p_gateway module requires a gwmode to be set.")
        $zyre_bind = false
        $pubsub_endpoint = false
        $control_endpoint = false
        $startparam = $::fqdn
    }
    user { $p2p_gateway::user:
        ensure  => present,
        comment => "p2pgateway user",
        home    => $p2p_gateway::home_directory,
        system  => true,
        shell   => "/bin/bash",
    } ->
    group { $p2p_gateway::group:
        ensure  => present,
        require => User[$p2p_gateway::user],
    }
    file { $p2p_gateway::home_directory:
        ensure => 'directory',
        owner  => $p2p_gateway::user,
        group  => $p2p_gateway::group,
    }
    file { $p2p_gateway::config_directory:
        ensure => 'directory',
        owner  => $p2p_gateway::user,
        group  => $p2p_gateway::group,
    }
    file { $p2p_gateway::bin_directory:
        ensure => 'directory',
        owner  => $p2p_gateway::user,
        group  => $p2p_gateway::group,
    }
    file { $p2p_gateway::working_directory:
        ensure => 'directory',
        owner  => $p2p_gateway::user,
        group  => $p2p_gateway::group,
    }
    # gateway binary
    exec { 'wget -q ${p2p_gateway::binary}':
        cwd     => "${p2p_gateway::bin_directory}/",
        creates => "${p2p_gateway::bin_directory}/gateway",
        path    => ['/bin', '/usr/bin']
    }
    file { "${p2p_gateway::bin_directory}/gateway":
        owner  => $p2p_gateway::user,
        group  => $p2p_gateway::group,
        mode   => "0755",
    }
    # service file
    file { "/etc/systemd/system/p2p_gateway.service":
        ensure  => "file",
        content => template('p2p_gateway/p2p_gateway.service.erb'),
        owner   => "root",
        group   => "root",
        notify  => Exec["p2p daemon reload"],
    }
    exec { "p2p daemon reload":
        command     => "systemctl daemon-reload",
        path        => [ '/usr/bin', '/bin', '/usr/sbin', '/sbin' ],
        refreshonly => true,
    } -> Service['p2p_gateway']
    # env file
    file { "${p2p_gateway::config_directory}/p2p_gateway.env":
        ensure  => "file",
        content => template('p2p_gateway/p2p_gateway.env.erb'),
        owner   => $p2p_gateway::user,
        group   => $p2p_gateway::group,
        notify  => Service['p2p_gateway'],
    }
}
