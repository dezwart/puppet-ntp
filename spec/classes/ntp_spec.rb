require 'spec_helper'

describe 'ntp' do
  packages = [
    'ntp'
  ]

  services = [
    'ntp'
  ]

  files = [
    '/etc/ntp.conf'
  ]

  context 'default' do
    it {
      packages.map { |x| should contain_package(x) }
    }

    it {
      services.map { |x| should contain_service(x) }
    }

    it {
      files.map {
        |x| should contain_file(x).with({
          'ensure' => 'file',
        })
      }
    }
  end
end
