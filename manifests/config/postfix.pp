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
    $mda,
    $mda_service,
    $mail_domain,
    $username,
    $apikey
) {
    exec { "inet_interfaces":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postconf -e 'inet_interfaces = 127.0.0.1'"
    }

    exec { "myhostname":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postconf -e 'myhostname = $mail_domain'"
    }

    exec { "mydestination":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postconf -e 'mydestination = $mail_domain, localhost'"
    }

    exec { "relayhost":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postconf -e 'relayhost = [smtp.mandrillapp.com]'"
    }

    exec { "smtp_sasl_auth_enable":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postconf -e 'smtp_sasl_auth_enable = yes'"
    }

    exec { "smtp_sasl_password_maps":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postconf -e 'smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd'"
    }

    exec { "smtp_sasl_security_options":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postconf -e 'smtp_sasl_security_options = noanonymous'"
    }

    exec { "smtp_use_tls":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postconf -e 'smtp_use_tls = yes'"
    }

    exec { "smtp_tls_CAfile":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postconf -e 'smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt'"
    }

    service { $mda_service:
        ensure => "running",
        require => [
            Exec["inet_interfaces"],
            Exec["myhostname"],
            Exec["mydestination"],
            Exec["relayhost"],
            Exec["smtp_sasl_auth_enable"],
            Exec["smtp_sasl_password_maps"],
            Exec["smtp_sasl_security_options"],
            Exec["smtp_use_tls"],
            Exec["smtp_tls_CAfile"]
        ]
    }

    file { "sasl_passwd":
        path => "/etc/postfix/sasl_passwd",
        ensure => "present",
        content => template("mandrill/postfix/sasl_passwd")
    }

    exec { "sasl_passwd.db":
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
        command => "postmap /etc/postfix/sasl_passwd",
        require => File["sasl_passwd"]
    }
}
