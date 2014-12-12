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
    $mda,
    $mda_service,
    $mail_domain,
    $username,
    $apikey
) {
    fail("mandrill module does not support MDA sendmail")

}
