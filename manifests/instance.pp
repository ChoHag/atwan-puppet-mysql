define mysql::instance (
  $instance    = $name,
  $device      = 'UNDEFINED',
  $datadir     = 'UNDEFINED',
  $sockdir     = 'UNDEFINED',
  $daemon_user = 'UNDEFINED',
  $data_source = 'UNDEFINED',
  $server_id   = 'UNDEFINED',
) {
  user { $daemon_user:
    ensure     => present,
    system     => true,
    comment    => "MySQL user for $instance",
    shell      => '/bin/false',
    home       => $datadir,
    managehome => false,
  }

  -> file { $sockdir:
    ensure => directory,
    owner  => $daemon_user,
    mode   => '0700'
  }

  # Copy pasta!

  -> mysql::instance::data { $title:
    instance    => $instance,
    device      => $device,
    datadir     => $datadir,
    sockdir     => $sockdir,
    daemon_user => $daemon_user,
    data_source => $data_source,
    server_id   => $server_id,
  }

  -> mysql::instance::config { $title:
    instance    => $instance,
    device      => $device,
    datadir     => $datadir,
    sockdir     => $sockdir,
    daemon_user => $daemon_user,
    data_source => $data_source,
    server_id   => $server_id,
  }

  -> mysql::instance::service { $title:
    instance    => $instance,
    device      => $device,
    datadir     => $datadir,
    sockdir     => $sockdir,
    daemon_user => $daemon_user,
    data_source => $data_source,
    server_id   => $server_id,
  }
}
