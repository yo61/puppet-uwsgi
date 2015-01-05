require 'rspec-puppet'

shared_context 'hiera_config' do
  let(:hiera_config) { 'spec/hiera/hiera.yaml' }
  hiera = Hiera.new
end