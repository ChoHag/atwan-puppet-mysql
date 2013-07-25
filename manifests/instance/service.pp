define mysql::instance::service
( $instance, $device, $datadir, $sockdir, $user, $server_id )
{
  file { "/etc/init.d/mysql-$name":
    ensure  => file,
    mode    => '0755',
    content => template('mysql/instance_init.d.erb'),
  }

#  -> service { "mysql-instance-${title}":
#    ...
#  }
}
