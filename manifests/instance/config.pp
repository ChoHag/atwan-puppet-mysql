define mysql::instance::config
( $instance, $device, $datadir, $sockdir, $user, $server_id )
{
  file { "$datadir/my.cnf":
    ensure  => file,
    content => template('mysql/instance_my.cnf.erb'),
  }
}

