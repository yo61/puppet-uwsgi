# == Class uwsgi::install
#
# This class is called from uwsgi for install.
#
class uwsgi::install(
  $package_ensure
) {

  include ::uwsgi::params
  package{$::uwsgi::params::package_name:
    ensure => $package_ensure,
  }

}
