define uwsgi::plugin(
  $ensure = 'present'
) {

  require ::uwsgi

  package{"uwsgi::plugin::${name}":
    ensure => $ensure,
  }

}