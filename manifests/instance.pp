define mysql::instance (
  $instance  = $name,
  $device    = 'UNDEFINED',
  $datadir   = 'UNDEFINED',
  $sockdir   = 'UNDEFINED',
  $user      = 'UNDEFINED',
  $server_id = 'UNDEFINED',
) {
  user { $user:
    ensure     => present,
    system     => true,
    comment    => 'MySQL user',
    shell      => '/bin/false',
    home       => $datadir,
    managehome => false,
  }

  -> file { $sockdir:
    ensure => directory,
    owner  => $user,
    mode   => '0700'
  }

  # Copy pasta!

  -> mysql::instance::initialise { $title:
    instance  => $instance,
    device    => $device,
    datadir   => $datadir,
    sockdir   => $sockdir,
    user      => $user,
    server_id => $server_id,
  }

  -> mysql::instance::config { $title:
    instance  => $instance,
    device    => $device,
    datadir   => $datadir,
    sockdir   => $sockdir,
    user      => $user,
    server_id => $server_id,
  }

  -> mysql::instance::service { $title:
    instance  => $instance,
    device    => $device,
    datadir   => $datadir,
    sockdir   => $sockdir,
    user      => $user,
    server_id => $server_id,
  }
}
