#
#
# PXE Boot VM (no images provided)
#
# ft=ruby

Vagrant.configure(2) do |config|

  # Global hostmanager manages /etc/hosts
  config.hostmanager.enabled = true

  # Global provisioning
  config.vm.provision :salt, run: 'always' do |salt|
    salt.run_highstate  = true
    salt.verbose        = true
    salt.colorize       = true
    salt.masterless     = true
  end

  # Synced folders
  config.vm.synced_folder   'saltstack/.', '/vagrant', disabled: true
  config.vm.synced_folder   'saltstack/etc/minion.d/', '/etc/salt/minion.d'
  config.vm.synced_folder   'saltstack/salt', '/srv/salt'
  config.vm.synced_folder   'saltstack/pillar', '/srv/pillar'
  config.vm.synced_folder   'saltstack/formulas', '/srv/formulas'
  config.vm.synced_folder   'assets/tftpboot', '/srv/tftpboot'
  config.vm.synced_folder   'assets/www-root', '/srv/www/'

  # How many minions? (1)
  (1..1).each do |i|

    config.vm.define "pxeboot" do |pxeboot|
      # Internal Network (VirtualBox)
      pxeboot.vm.network "private_network", ip: "10.11.0.#{i}",
        virtualbox__intnet: true

      pxeboot.vm.host_name = "pxeboot#{i}-vagrant"
      pxeboot.vm.provision :hostmanager

      pxeboot.vm.provider :virtualbox do |provider,override|
        provider.memory = 2048
        override.vm.box = 'bento/debian-8.4'
      end
    end

  end

end
