Vagrant.configure("2") do |config|
  config.vm.box = "bento/amazonlinux-2"
  
  config.vm.provision "shell", path: "setup_aws_linux.sh"
end
