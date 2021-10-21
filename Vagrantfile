Vagrant.configure(2) do |config|
    # [...]
    config.vm.box = "centos/8"
    # config.vm.box_url = ""

    config.vm.define "sjakkuS" do |control|
        control.vm.hostname = "sjakkuS"
        control.vm.network "private_network", ip: "192.168.42.110"
        control.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--name", "sjakkuS"]
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.memory = 1024 
            v.cpus = 1
        end
        # config.vm.provision "shell", inline: <<-SHELL
        # SHELL
            # control.vm.provision "shell", path: "path to script from host"
    end
    config.vm.define "sjakkuSW" do |control|
        control.vm.hostname = "sjakkuSW"
        control.vm.network "private_network", ip: "192.168.42.111"
        control.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--name", "sjakkuSW"]
            v.memory = 1024 
            v.cpus = 1
        end
        # config.vm.provision "shell", inline: <<-SHELL
        #     echo 'World'
        # SHELL
            # control.vm.provision "shell", path: "path to script from host "
    end
end