# == Class uwsgi::install
#
# This class is called from uwsgi for install.
#
class uwsgi::install(
  $package_name,
  $package_ensure
) {

  package{$package_name:
    ensure => $package_ensure,
  }

}
