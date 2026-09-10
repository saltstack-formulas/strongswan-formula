# frozen_string_literal: true

package_name =
  if system.platform[:name] == 'ubuntu'
    'strongswan-starter'
  elsif system.platform[:family] == 'debian'
    'strongswan-charon'
  else
    'strongswan'
  end

control 'Strongswan package' do
  title 'should be installed'

  describe package(package_name) do
    it { should be_installed }
  end
end
