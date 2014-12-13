# == Class: mandrill::config::exim_debian
#
# Configures exim to use mandrill as a smarthost on debian type hosts.
#
# === Authors
#
# David McNicol <david@mcnicks.org>
#
# === Copyright
#
# Copyright 2014 David McNicol
#
class mandrill::config::exim_debian (
    $mail_domain,
    $required_packages,
    $username,
    $apikey
) {
    
    if $required_packages {
        package { $required_packages:
            ensure => "installed",
            before => Service["exim4"]
        } 
    }

    file { "mailname":
        path => "/etc/mailname",
        ensure => present,
        owner => "root",
        group => "root",
        mode => 0644,
        content => $mail_domain
    } ->

    file { "update-exim4.conf.conf":
        path => "/etc/exim4/update-exim4.conf.conf",
        ensure => present,
        owner => "root",
        group => "root",
        mode => 0644,
        content => template("mandrill/exim/update-exim4.conf.conf.erb")
    } ->

    file { "passwd.client":
        path => "/etc/exim4/passwd.client",
        ensure => present,
        owner => "root",
        group => "Debian-exim",
        mode => 0640,
        content => template("mandrill/exim/passwd.client.erb"),
    } ~>

    service { "exim4":
        ensure => "running"
    }

}
