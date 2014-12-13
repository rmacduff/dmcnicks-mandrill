# == Class: mandrill::config::sendmail
#
# Configures sendmail to use mandrill as a smarthost.
#
# === Authors
#
# David McNicol <david@mcnicks.org>
#
# === Copyright
#
# Copyright 2014 David McNicol
#
class mandrill::config::sendmail (
    $mailer,
    $mailer_service,
    $mail_domain,
    $username,
    $apikey
) {

    file { "authinfo":
        path => "/etc/mail/authinfo",
        ensure => "present",
        content => template("mandrill/sendmail/authinfo.erb")
    } ->

    file { "sendmail.mc":
        path => "/etc/mail/sendmail.mc",
        ensure => "present"
    } ->

    file_line { "smart_host":
        path => "/etc/mail/sendmail.mc",
        line => "define(`SMART_HOST', `smtp.mandrillapp.com')dnl",
        match => "^define\\(`SMART_HOST'"
    } ->

    file_line { "authinfo":
        path => "/etc/mail/sendmail.mc",
        line => "FEATURE(`authinfo')dnl"
    } ->
   
    exec { "make":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "make",
        cwd => "/etc/mail"
    } ->

    service { $mailer_service:
        ensure => "running"
    }
}
