# == Class: uwsgi::config
#
# This class is called from uwsgi for service config.
#
# The parameters are described there
#
class uwsgi::config(
  #$param1,
  #$param2,
  #$param3,
) {

  # validate params here

  include ::uwsgi::params
  file{$::uwsgi::params::config_file:
    content => template("${module_name}/uwsgi.ini.erb'),
  }

}