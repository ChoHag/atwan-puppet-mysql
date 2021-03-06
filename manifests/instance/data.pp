define mysql::instance::data
( $instance, $device, $datadir, $sockdir, $daemon_user, $data_source, $server_id )
{
  file { $datadir:
    ensure => directory,
    owner  => $daemon_user,
    mode   => 0700,
  }

  if $device != 'UNDEFINED' {
    File[$datadir] { require => Data::FS::Device[$device] }
  }

  case $data_source {
    'backup': {
      mysql::instance::restore { $title:
	instance    => $instance,
	device      => $device,
	datadir     => $datadir,
	sockdir     => $sockdir,
	daemon_user => $daemon_user,
	data_source => $data_source,
	server_id   => $server_id,

	require     => File[$datadir],
      }
    }

    default: {
      mysql::instance::initialise { $title:
	instance    => $instance,
	device      => $device,
	datadir     => $datadir,
	sockdir     => $sockdir,
	daemon_user => $daemon_user,
	data_source => $data_source,
	server_id   => $server_id,

	require     => File[$datadir],
      }
    }
  }
}
