# -*- mode: ruby -*-
# vi: set ft=ruby :

ANSIBLE_PATH = "/Users/yannick/Dropbox/workspace/devboks/nanog80/ansible"

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

# config.vm.network :forwarded_port, guest: 80, host: 8024

  config.vm.provider :virtualbox do |v|
    v.name = "nanog80"
    v.memory = 2048
    v.cpus = 2
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.host_name = "nanog80"
  # config.vm.network "public_network", ip: "192.168.66.24"
  config.vm.network "private_network", ip: "192.168.33.24"
  # config.vm.network "public_network", ip: "192.168.66.24", bridge: [
  #   "en1: Wi-Fi (AirPort)",
  # ]
  config.vm.synced_folder "./", "/workspace/nanog80/",  :owner => "vagrant", :group => "vagrant" #####:mount_options => ['dmode=775', 'fmode=664'] # can also use 'fmode=400'
    
  config.vm.define :nanog80 do |nanog80|
  end

  #Ansible provisioner for docker.
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = ANSIBLE_PATH+"/playbooks/devboks.debian.docker.playbook.yaml"
    ansible.inventory_path = ANSIBLE_PATH+"/inventory/hosts"
    ansible.become = true
  end
  # #Ansible provisioner for ceos
  # config.vm.provision "ansible" do |ansible|
  #   ansible.compatibility_mode = "2.0"
  #   ansible.playbook = ANSIBLE_PATH+"/playbooks/devboks.ceos.deploy.playbook.yaml"
  #   ansible.inventory_path = ANSIBLE_PATH+"/inventory/hosts"
  #   ansible.become = true
  # end
 
end
