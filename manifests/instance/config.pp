define mysql::instance::config
( $instance, $device, $datadir, $sockdir, $daemon_user, $data_source, $server_id )
{
  file { "$datadir/my.cnf":
    ensure  => file,
    content => template('mysql/instance_my.cnf.erb'),
  }
}

