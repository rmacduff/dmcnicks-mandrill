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
    $mailer_service,
    $mail_domain,
    $username,
    $apikey
) {

    case $mailer {
        "exim", "postfix", "sendmail": {
            class { "mandrill::config::$mailer":
                mailer => $mailer,
                mailer_service => $mailer_service,
                mail_domain => $mail_domain,
                username => $username,
                apikey => $apikey
            }
        }
        default: {
            fail("mandrill module does not support mailer $mailer")
        }
    }
}
