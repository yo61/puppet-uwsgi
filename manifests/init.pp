# == Class: uwsgi
#
# Full description of class uwsgi here.
#
# === Parameters
#
# [*param1*]
#   Explanation of this parameter, what it affects, and any default
# [*param2*]
#   Explanation of this parameter, what it affects, and any default
# [*param3*]
#   Explanation of this parameter, what it affects, and any default
# etc.
#
class uwsgi(
  # mandatory params first
  #$param1,
  #$param2,
  #$param3         = $::uwsgi::params::param3,
  $package_name   = $::uwsgi::params::package_name,
  $package_ensure = $::uwsgi::params::package_ensure,
  $service_ensure = 'running',
  $service_enable = true,
) inherits ::uwsgi::params {

  # validate parameters here

  class{'::uwsgi::install':
    package_name   => $package_name,
    package_ensure => $package_ensure,
  }->
  class{'::uwsgi::config':
    #param1 => $param1,
    #param2 => $param2,
    #param3 => $param3,
  }~>
  class{'::uwsgi::service':
    ensure => $service_ensure,
    enable => $service_enable,
  }

  Class['::uwsgi::install']~>
  Class['::uwsgi::service']

  contain
    'uwsgi::config',
    'uwsgi::install',
    'uwsgi::service'

}
