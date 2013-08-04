define mysql::instance::restore
( $instance, $device, $datadir, $sockdir, $user, $data_source, $server_id )
{
  exec { "check-restore-$datadir":
    command => "bash -c 'echo Restore from backup not possible yet. >&2; test -d \"$datadir\"/mysql'";
  }
}
