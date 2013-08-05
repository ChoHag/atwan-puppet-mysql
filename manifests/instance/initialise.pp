define mysql::instance::initialise
( $instance, $device, $datadir, $sockdir, $daemon_user, $data_source, $server_id )
{
  Exec {
    environment => [
      # This time puppet does the variable interpolation.
      "HOME=/root", # Well naturally puppet strips this
      "datadir=$datadir",
      "basedir=${mysql::basedir}",
      "daemon_user=$daemon_user",
    ],
  }

  $bootstrap_a = [
    "${mysql::basedir}/bin/mysqld",
    '--user="$daemon_user"',
    '--bootstrap',
    '--basedir="$basedir"',
    '--datadir="$datadir"',
    '--log-warnings=0',
    '--loose-skip-nbdcluster',
    '--max_allowed_packet=8M',
    '--default-storage-engine=MyISAM',
    '--net_buffer_length=16K',
  ]
  $bootstrap = join($bootstrap_a, ' ')

  $security_sed = "s/ABC123xyz/secret/g"

  $stdin_a = [
    'echo use mysql\;',
    'cat "$basedir"/share/mysql_system_tables.sql',
    'cat "$basedir"/share/mysql_system_tables_data.sql',
    # Not so useless use of cat
    "cat \"\$basedir\"/share/mysql_security_commands.sql | sed $security_sed",
    'cat "$basedir"/share/fill_help_tables.sql',
  ]
  $stdin = join($stdin_a, ' ; ')

  file { "$datadir/mysql":
    ensure => directory,
    owner  => $daemon_user,
    mode   => 0700,
    notify => Exec["mysql-initialise-$title"],
  }

  -> exec { "mysql-initialise-$title":
    command     => "bash -c '( $stdin ) | $bootstrap'",
    refreshonly => true,
    unless      => 'ls $datadir/mysql/* >/dev/null 2>&1',
  }
}
