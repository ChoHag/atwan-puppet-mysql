class mysql(
  $package   = params_lookup('package'),
  $instances = params_lookup('instances'),
  $basedir   = params_lookup('basedir'),
) inherits mysql::params {
     class { 'mysql::install': }
  -> class { 'mysql::all_instances': }
  -> Class['mysql']
}

class mysql::all_instances {
  create_resources('mysql::instance', $mysql::instances)
}
