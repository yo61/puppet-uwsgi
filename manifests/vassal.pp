define uwsgi::vassal(
  $vassal_user,
  $vassal_group,
  $ini_source  = undef,
  $ini_content = undef,
) {
  
  $both = $ini_source and $ini_content
  $neither = !$ini_source and !$ini_content

  if $both or $neither {
    fail('Only one of "source" and "content" parameters should be specified')
  }

  include ::uwsgi::params

  file{"${::uwsgi::params::emperor_dir}/${name}.ini":
    ensure  => file,
    content => $ini_content,
    source  => $ini_source,
    user    => $vassal_user,
    group   => $vassal_group
  }

}