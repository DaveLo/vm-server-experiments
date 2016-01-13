exec { "apt-get update":
    command => "/usr/bin/apt-get update",
}

package { 'mysql-server':
    require => Exec['apt-get update'],
    ensure => installed,
}