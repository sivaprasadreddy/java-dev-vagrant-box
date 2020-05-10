# Java Dev Vagrant Box
Ubuntu based Vagrant box with Java development tools pre-installed.

The Vagrant box **sivalabs/ubuntu_bionic64_java** is build using Packer and 
published on Vagrant Cloud: https://app.vagrantup.com/sivalabs/boxes/ubuntu_bionic64_java

## How to use?

**Vagrantfile**

```
Vagrant.configure("2") do |config|
  config.vm.box = "sivalabs/ubuntu_bionic64_java"
  config.vm.box_version = "0.0.1"
end
```

The following tools are pre-installed:
1. SDKMAN
2. JDK 8 and JDK 11
3. Maven using SDKMAN 
4. Gradle using SDKMAN
5. Docker, Docker Compose
6. jq
 
## How to build?

```shell script
java-dev-vagrant-box> packer build packer.json
```

After creating the box you can upload it through Web UI https://app.vagrantup.com/boxes/new
or using API https://www.vagrantup.com/docs/vagrant-cloud/api.html#create-a-box
