# == Class: mandrill
#
# Configures mail service to use Mandrill as a smarthost.
#
# === Parameters
#
# [*mailer*]
#   The name of the mail software installed on the host. This module will try
#   to make a sensible guess for this based on OS family.
# [*mailer_service*]
#   The OS-specific service name of the mailer software. As with the mailer
#   parameter, this will be set based on OS family.
# [*mail_domain*]
#   The mail domain that the host should use for sender addresses. Defaults
#   to the host FQDN.
# [*username*]
#   (Required) Mandrill username.
# [*apikey*]
#   (Required) Mandrill API key created inside your Mandrill account.
#   
# === Supported Platforms
#
# * Debian
# * Ubuntu
# * RedHat Enterprise Linux, CentOS, Scientific Linux
#
# === Examples
#
#  class { "mandrill":
#    username => "registered@email.address",
#    apikey => "7vk6YiOxfzVdTmtRQShR3"
#  }
#
# === Authors
#
# David McNicol <david@mcnicks.org>
#
# === Copyright
#
# Copyright 2014 David McNicol
#
class mandrill (
    $mailer = $mandrill::params::mailer,
    $mailer_service = $mandrill::params::mailer_service,
    $mail_domain = $mandrill::params::mail_domain,
    $username,
    $apikey
) inherits mandrill::params {

    class { "mandrill::config":
        mailer => $mailer,
        mailer_service => $mailer_service,
        mail_domain => $mail_domain,
        username => $username,
        apikey => $apikey
    }
}
