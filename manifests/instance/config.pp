define mysql::instance::config
( $instance, $device, $datadir, $sockdir, $user, $data_source, $server_id )
{
  file { "$datadir/my.cnf":
    ensure  => file,
    content => template('mysql/instance_my.cnf.erb'),
  }
}

