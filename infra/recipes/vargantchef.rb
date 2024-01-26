Vagrant.configure("2") do |config|
  config.vm.box = "bento/amazonlinux-2"

  # Provision with Chef Solo
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "your_cookbook::your_recipe"
    # Specify paths to your cookbooks and roles here
    chef.cookbooks_path = ["path/to/cookbooks"]
    chef.roles_path = "path/to/roles"
  end
end
