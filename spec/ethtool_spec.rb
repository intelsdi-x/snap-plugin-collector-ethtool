require 'spec_helper'

describe command("/opt/snap/bin/snaptel plugin load /opt/snap/plugins/snap-plugin-publisher-file") do
  its(:exit_status) { should eq 0 }
end

describe command("/opt/snap/bin/snaptel plugin load /opt/snap/plugins/snap-plugin-collector-ethtool") do
  its(:exit_status) { should eq 0 }
end

describe command("/opt/snap/bin/snaptel plugin list") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /file/ }
  its(:stdout) { should match /ethtool/ }
end

describe command("/opt/snap/bin/snaptel task create -t /vagrant/examples/tasks/ethtool-file.json") do
  its(:exit_status) { should eq 0 }
end

# NOTE: need some time to populate task
describe command("sleep 10") do
  its(:exit_status) { should eq 0 }
end

describe file("/tmp/published_netstats") do
  it { should be_file }
  its(:content) { should match /rx_bytes/ }
end
