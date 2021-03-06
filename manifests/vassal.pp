define uwsgi::vassal(
  $owner,
  $group,
  $ensure = 'present',
  $ini_source  = undef,
  $ini_content = undef,
  $plugins = [],
) {

  uwsgi::plugin{$plugins:}
 
  validate_re($ensure, '^(present|absent)$',
    "${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'."
  )

  $both = $ini_source and $ini_content
  $neither = !$ini_source and !$ini_content
  if $both or $neither {
    fail('Only one of "source" and "content" parameters should be specified')
  }

  include ::uwsgi::params

  $ini_ensure = $ensure ? {
    present => 'file',
    default => $ensure,
  }

  file{"${::uwsgi::params::emperor_dir}/${name}.ini":
    ensure  => $ini_ensure,
    content => $ini_content,
    source  => $ini_source,
    owner   => $owner,
    group   => $group,
  }

}