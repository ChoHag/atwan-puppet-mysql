define mysql::instance::service
( $instance, $device, $datadir, $sockdir, $daemon_user, $data_source, $server_id )
{
  file { "/etc/init.d/mysql-$name":
    ensure  => file,
    mode    => '0755',
    content => template('mysql/instance_init.d.erb'),
  }

  -> service { "mysql-$name":
    ensure     => running,
    enable     => true, # on boot
    hasrestart => true,
    hasstatus  => true,
  }
}
