# == Class uwsgi::params
#
# This class is meant to be called from uwsgi.
# It sets various defaults for this module, and also
# sets variables according to platform
#
class uwsgi::params{
  # these variables are surfaced as parameters in init.pp and may be over-ridden
  $package_ensure = 'present'
  #$listen_port     = 2222

  # these variables are purely internal
  case $::osfamily {
    #'Debian': {
    #  $package_name = 'uwsgi'
    #  $service_name = 'uwsgi'
    #}
    'RedHat', 'Amazon': {
      $package_name       = 'uwsgi'
      $config_file        = '/etc/uwsgi.ini'
      $service_name       = 'uwsgi'
      $service_hasstatus  = true
      $service_hasrestart = true
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
