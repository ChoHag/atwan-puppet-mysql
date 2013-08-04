class mysql::userspace {
  file { "/etc/profile.d/mysql.sh":
    ensure => file,
    content => template('mysql/profile_d.sh.erb'),
  }
}
