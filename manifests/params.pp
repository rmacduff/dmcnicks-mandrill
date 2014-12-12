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

    # Set the MDA and MDA service based on the OS family.
    case $::osfamily {
        "Debian": {
            $mda = "exim"
            $mda_service = "exim4"
        }
        "Ubuntu": {
            $mda = "postfix"
            $mda_service = "postfix"
        }
        "RedHat", "CentOS", "Scientific": {
            $mda = "sendmail"
            $mda_service = "sendmail"
        }
        default: {
            fail("mandrill module does not support OS family ${::osfamily}")
        }
    }

}
