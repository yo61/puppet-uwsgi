require 'spec_helper'

common_facts = {
  concat_basedir: '/tmp',
  memorysize: '2 GB',
  processorcount: '2',
}

supported_os = [
  {
    kernel: 'Linux',
    osfamily: 'RedHat',
    operatingsystem: 'redhat',
    operatingsystemrelease: '6.4',
  }
]

unsupported_os = [
  {
    kernel: 'Solaris',
    osfamily: 'Solaris',
    operatingsystem: 'Nexenta',
  }
]

describe 'uwsgi' do
  include_context 'hiera_config'

  context 'supported operating systems' do
    supported_os.each do |os|
      let(:facts) { os.merge(common_facts) }
      describe "uwsgi class with all parameters on #{os[:operatingsystem]} #{os[:operatingsystemrelease]}" do
        let(:params) {
          {
            'param1' => 'one',
            'param2' => 'two',
            'param3' => 'three'
          }
        }

        it { should compile.with_all_deps }

        it { should contain_class('uwsgi') }
        it { should contain_class('uwsgi::params') }
        it { should contain_class('uwsgi::install').that_comes_before('uwsgi::config') }
        it { should contain_class('uwsgi::config') }
        it { should contain_class('uwsgi::service').that_subscribes_to('uwsgi::config') }

        it { should contain_service('uwsgi') }
        it { should contain_package('uwsgi').with_ensure('present') }

        it { should contain_file('/etc/uwsgi.conf') }
      end
    end
  end

  context 'unsupported operating system' do
    unsupported_os.each do |os|
      describe "profile_base class without any parameters on #{os[:operatingsystem]} #{os[:operatingsystemrelease]}" do
        let(:facts) { os.merge(common_facts) }
        it { expect { should contain_package('uwsgi') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
      end
    end
  end
end
