class mysql::install {
  package {
    $mysql::package:
      ensure => present;
  }
}
