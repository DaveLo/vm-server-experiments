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

package {
    [
        'bash-completion',
        'cloc',
        'cron',
        'curl',
        'git',
        'gzip',
        'htop',
        'mysql-client',
        'mysql-server',
        'vim',
    ]:
    ensure => present,
    require => Exec['apt-get update'],
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
} ->
package {
    [
        'php-codesniffer',
        'php-doc',
        'php-soap',
        'php5-cli',
        'php5-curl',
        'php5-gd',
        'php5-intl',
        'php5-json',
        'libapache2-mod-php5filter',
        'php5-mcrypt',
        'php5-mysqlnd',
        'php5-oauth',
        'php5-xdebug',
    ]:
    ensure => present,
    require => Exec['apt-get update'],
}

# Create php info file.
file { "/var/www/html/info.php":
    ensure => file,
    content => "<?php phpinfo(); ?>",
    require => Package['apache2'],
}