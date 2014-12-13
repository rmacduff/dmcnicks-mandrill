# == Class: mandrill::params
#
# Manages parameters for the mandrill module.
#
# === Authors
#
# David McNicol <david@mcnicks.org>
#
# === Copyright
#
# Copyright 2014 David McNicol
#
class mandrill::params () {

    # Set mail domain to FQDN by default.
    $mail_domain = $::fqdn

    # Set the mailer and mailer service based on the OS family.
    case $::osfamily {
        "Debian": {
            $mailer = "exim"
            $mailer_service = "exim4"
        }
        "Ubuntu": {
            $mailer = "postfix"
            $mailer_service = "postfix"
        }
        "RedHat", "CentOS", "Scientific": {
            $mailer = "postfix"
            $mailer_service = "postfix"
        }
        default: {
            $mailer = "none"
            $mailer_service = "none"
        }
    }

}
