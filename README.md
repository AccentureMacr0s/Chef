# Chef
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
