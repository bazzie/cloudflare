require 'spec_helper'
describe 'cloudflare' do
  context 'with default values for all parameters' do
    it { should contain_class('cloudflare') }
  end
end
