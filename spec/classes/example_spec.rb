require 'spec_helper'

describe 'uwsgi' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "uwsgi class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('uwsgi::params') }
        it { should contain_class('uwsgi::install').that_comes_before('uwsgi::config') }
        it { should contain_class('uwsgi::config') }
        it { should contain_class('uwsgi::service').that_subscribes_to('uwsgi::config') }

        it { should contain_service('uwsgi') }
        it { should contain_package('uwsgi').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'uwsgi class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('uwsgi') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
