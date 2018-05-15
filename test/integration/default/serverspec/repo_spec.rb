require 'serverspec'

# Required by serverspec
set :backend, :exec

describe yumrepo("extenda-centraloffice-release") do
  it { should exist }
end

describe yumrepo("extenda-centraloffice-release") do
  it { should be_enabled }
end

describe yumrepo("extenda-centraloffice-develop") do
  it { should exist }
end

describe yumrepo("extenda-centraloffice-develop") do
  it { should be_enabled }
end

describe yumrepo("extenda-storeagent-release") do
  it { should exist }
end

describe yumrepo("extenda-storeagent-release") do
  it { should be_enabled }
end

describe yumrepo("extenda-storeagent-develop") do
  it { should exist }
end

describe yumrepo("extenda-storeagent-develop") do
  it { should be_enabled }
end

describe file("/etc/yum/pluginconf.d/extenda-s3.conf") do
  it { should exist }
end

describe file("/usr/lib/yum-plugins/extenda-s3.py") do
  it {should exist}
end

# check to see if we can connect to the private yum repo at
# https://s3-eu-west-1.amazonaws.com/extenda-packages/bar
# and find the package named 'bello'
describe command("yum repolist") do
  its(:exit_status) { should eq 0 }
end

# describe command("yum install -y bello") do
#   its(:exit_status) { should eq 0 }
# end

# describe package("bello") do
#   it {should be_installed}
# end
