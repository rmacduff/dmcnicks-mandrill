# == Class: mandrill::config::exim
#
# Configures exim to use mandrill as a smarthost.
#
# === Authors
#
# David McNicol <david@mcnicks.org>
#
# === Copyright
#
# Copyright 2014 David McNicol
#
class mandrill::config::exim (
    $mda,
    $mda_service,
    $mail_domain,
    $username,
    $apikey
) {
    
    service { "exim4":
        ensure => "running"
    }

    file { "mailname":
        path => "/etc/mailname",
        ensure => present,
        owner => "root",
        group => "root",
        mode => 0644,
        content => $local_domain
    }

    file { "update-exim4.conf.conf":
        path => "/etc/exim4/update-exim4.conf.conf",
        ensure => present,
        owner => "root",
        group => "root",
        mode => 0644,
        content => template("mandrill/exim/update-exim4.conf.conf.erb")
    }

    file { "passwd.client":
        path => "/etc/exim4/passwd.client",
        ensure => present,
        owner => "root",
        group => "Debian-exim",
        mode => 0640,
        content => template("mandrill/exim/passwd.client.erb")
    }

    File["mailname"] ->
    File["update-exim4.conf.conf"] ->
    File["passwd.client"] ->
    Service["exim4"]
}
