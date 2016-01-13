include apt

exec { "apt-get update":
    command => "/usr/bin/apt-get update",
}

package { "apache2":
    require => Exec["apt-get update"],
    ensure => present,
} ->
# Once installed make sure it is started up.
service { "apache2":
    ensure => running,
}

# Update PHP Package directory.
apt::ppa { "ppa:ondrej/php5-5.6":
    ensure => present,
    before => Package['php5'],
 } -> Exec['apt-get update']

# Install python extras.
package { "python-software-properties":
    ensure => present,
    before => Package['php5'],
} -> Exec['apt-get update']

# Install PHP
package { "php5":
    require => Exec['apt-get update'],
    ensure => present,
}

# Create php info file.
file { "/var/www/html/info.php":
    ensure => file,
    content => "<?php phpinfo(); ?>",
    require => Package['apache2'],
}