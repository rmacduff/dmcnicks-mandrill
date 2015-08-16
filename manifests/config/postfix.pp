# == Class: mandrill::config::postfix
#
# Configures postfix to use mandrill as a smarthost.
#
# === Authors
#
# David McNicol <david@mcnicks.org>
#
# === Copyright
#
# Copyright 2014 David McNicol
#

class mandrill::config::postfix (
  $mail_domain,
  $username,
  $apikey
  $relayhost_port,
) {

  package { 'postfix':
    ensure => 'present'
  }

  service { 'postfix':
    ensure  => 'running',
    require => Package['postfix']
  }

  file { 'main.cf':
    ensure  => 'present',
    path    => '/etc/postfix/main.cf',
    content => template('mandrill/postfix/main.cf.erb'),
    require => Package['postfix'],
    notify  => Service['postfix']
  }

  file { 'sasl_passwd':
    ensure  => 'present',
    path    => '/etc/postfix/sasl_passwd',
    content => template('mandrill/postfix/sasl_passwd.erb'),
    require => Package['postfix'],
    notify  => Exec['sasl_passwd.db']
  }

  exec { 'sasl_passwd.db':
    path        => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    command     => 'postmap /etc/postfix/sasl_passwd',
    refreshonly => true,
    require     => Package['postfix'],
    notify      => Service['postfix']
  }
}
