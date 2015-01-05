# == Class uwsgi::service
#
# This class is meant to be called from uwsgi
# It ensures the service is in the desired state
#
class uwsgi::service(
  $enable,
  $ensure,
) {

  include ::uwsgi::params
  service{$::uwsgi::params::service_name:
    ensure     => $ensure,
    enable     => $enable,
    hasstatus  => $::uwsgi::params::service_hasstatus,
    hasrestart => $::uwsgi::params::service_hasrestart,
  }

}
