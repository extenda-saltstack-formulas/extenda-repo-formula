require 'serverspec'

# Required by serverspec
set :backend, :exec

describe yumrepo("extenda-centraloffice-release") do
  it { should_not exist }
end

describe yumrepo("extenda-centraloffice-develop") do
  it { should exist }
end

describe yumrepo("extenda-centraloffice-develop") do
  it { should be_enabled }
end
