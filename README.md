# There are two files that still is need to be commited in future this is Vargantfile configuration and Refactory Changes in Chef and Terraform
Chef
This EC2 configuration Terraform Ruby Chef JSON
```LUMINOR/
├── infra/
│   ├── recipes/                 # Chef recipes for configuration management
│   │   ├── cloudwatch.rb        # Sets up CloudWatch
│   │   ├── postgresql.rb        # Installs and configures PostgreSQL
│   │   └── ssm.rb               # Installs AWS SSM agent
│   ├── aws_linux.json           # Packer configuration
│   ├── main.tf                  # Terraform main configuration
│   ├── variables.tf             # Terraform variables
│   ├── network.tf               # Terraform network configuration
│   ├── security_groups.tf       # Terraform security groups configuration
│   └── iam.tf                   # Terraform IAM configuration
└── packer/
    └── setup_aws_linux.sh       # Shell script for initial setup
```
New project structure
```
LUMINOR/
├── infra/
│   ├── cookbooks/               # Chef cookbooks
│   │   ├── cloudwatch/          # CloudWatch cookbook
│   │   │   ├── recipes/
│   │   │   │   └── default.rb
│   │   │   └── metadata.rb
│   │   ├── postgresql/          # PostgreSQL cookbook
│   │   │   ├── recipes/
│   │   │   │   └── default.rb
│   │   │   └── metadata.rb
│   │   └── ssm/                 # AWS SSM cookbook
│   │       ├── recipes/
│   │       │   └── default.rb
│   │       └── metadata.rb
│   ├── terraform/               # Terraform configurations
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── network.tf
│   │   ├── security_groups.tf
│   │   └── iam.tf
│   └── packer/                  # Packer configurations
│       ├── aws_linux.json
│       └── setup_aws_linux.sh
└── Vagrantfile

```
New VargantFile
```
Vagrant.configure("2") do |config|
  config.vm.box = "bento/amazonlinux-2"

  # Run the setup_linux.sh script from the packer directory
  config.vm.provision "shell", path: "infra/packer/setup_aws_linux.sh"

  # Provision with Chef Solo
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "cloudwatch"
    chef.add_recipe "postgresql"
    chef.add_recipe "ssm"

    # Specify the new path to your cookbooks
    chef.cookbooks_path = ["./infra/cookbooks"]
    
    # Update the roles path if you have any roles
    chef.roles_path = "path/to/roles" # Update this path as needed
  end
end

```
## Refactoring process for future terraform main.tf file, so the variables should be updated too. 
```
# ... existing configuration ...

# Example usage of for_each to create multiple instances
resource "aws_instance" "example" {
  for_each = var.instance_configuration

  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = each.value.key_name
  # ... other configuration ...

  tags = {
    Name = each.value.name
  }
}
```
## Function implementation inside the bashscripts for optimizing the automation of our robotus solution:

```
# ... existing script ...

main() {
  # Обновление системы
  sudo yum update -y

  # Вызов функций установки
  install_cloudwatch
  install_postgres
  install_aws_ssm

  echo "Установка завершена успешно."
}

# The script will only execute the main function if it's run directly, not when sourced from another script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi

```

# Create Vagrantfile
```
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/amazonlinux-2"
  
  # Provision with the shell script
  config.vm.provision "shell", path: "setup_aws_linux.sh"
  
  # Additional Vagrant configuration as required
end

```
