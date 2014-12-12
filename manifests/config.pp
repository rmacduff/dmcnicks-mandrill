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
    $username,
    $apikey
) {

    if defined(Class["mandrill::config::$mda"]) {
        class { "mandrill::config::$mda":
            mda => $mda,
            mda_service => $mda_service,
            username => $username,
            apikey => $apikey
        }
    } else {
        fail("mandrill module does not support MDA $mda")
    }
}
