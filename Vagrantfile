# -*- mode: ruby -*-
# vi: set ft=ruby :

# NOTE: override this via the option --provider {provider_name}
ENV["VAGRANT_DEFAULT_PROVIDER"] = "virtualbox"

Vagrant.configure(2) do |config|
  operating_systems = %w{ centos72 }

  operating_systems.each do |os|
    config.vm.define os do |system|
      system.vm.box = "boxcutter/#{os}"

      $script = <<SCRIPT
curl -sfL https://raw.githubusercontent.com/intelsdi-x/snap-docker/master/install_snap | sudo bash
curl -sfL https://raw.githubusercontent.com/intelsdi-x/snap-docker/master/snapd.conf -o /etc/snap/snapd.conf

curl -sfL https://s3-us-west-2.amazonaws.com/snap.ci.snap-telemetry.io/plugins/snap-plugin-collector-ethtool/master/latest/linux/x86_64/snap-plugin-collector-ethtool -o /opt/snap/plugins/snap-plugin-collector-ethtool
curl -sfL https://s3-us-west-2.amazonaws.com/snap.ci.snap-telemetry.io/plugins/snap-plugin-publisher-file/master/latest/linux/x86_64/snap-plugin-publisher-file -o /opt/snap/plugins/snap-plugin-publisher-file

sudo /opt/snap/bin/snapd -t 0 -l 1 &
echo 'snap provision complete'
SCRIPT

      config.vm.provision :shell, inline: $script

      if Vagrant.has_plugin?("vagrant-serverspec")
        config.vm.provision :serverspec do |spec|
          spec.pattern = "spec/ethtool_spec.rb"
        end
      end
    end
  end
end
