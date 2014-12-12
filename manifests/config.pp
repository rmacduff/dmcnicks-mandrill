# == Class: mandrill::config
#
# Manages configuration tasks for the mandrill module. This class defers 
# actual configuration to mda-specific classes based on the $mda parameter.
#
# === Authors
#
# David McNicol <david@mcnicks.org>
#
# === Copyright
#
# Copyright 2014 David McNicol
#
class mandrill::config (
    $mda,
    $mda_service,
    $mail_domain,
    $username,
    $apikey
) {

    case $mda {
        "exim", "postfix", "sendmail": {
            class { "mandrill::config::$mda":
                mda => $mda,
                mda_service => $mda_service,
                mail_domain => $mail_domain,
                username => $username,
                apikey => $apikey
            }
        }
        default: {
            fail("mandrill module does not support MDA $mda")
        }
    }
}
