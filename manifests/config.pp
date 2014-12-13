# == Class: mandrill::config
#
# Manages configuration tasks for the mandrill module. This class defers 
# actual configuration to mailer-specific classes based on the $mailer
# parameter.
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
    $mailer,
    $mail_domain,
    $required_packages,
    $username,
    $apikey
) {

    # Work out whether we have a specific configuration that works for
    # the given mailer and operating system.

    case $mailer {
        "postfix": { $mailer_config = "postfix" }
        "exim": {
            case $::osfamily {
                "Debian": { $mailer_config = "exim_debian" }
            }
        }
        "sendmail": {
            case $::osfamily {
                "Debian": { $mailer_config = "sendmail_debian" }
                "RedHat": { $mailer_config = "sendmail_redhat" }
            }
        }
    }

    # Apply the configuration if one has been found.

    if $mailer_config {
        class { "mandrill::config::$mailer_config":
            mail_domain => $mail_domain,
            required_packages => $required_packages,
            username => $username,
            apikey => $apikey
        }
    } else {
        fail("mandrill module does not support $mailer on $::osfamily")
    }
}
