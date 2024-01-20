variable "aws_linux_ami" {
  description = "AMI ID for AWS Linux 2"
  type        = string
}

variable "varbox_linux_ami" {
  description = "AMI ID for Varbox Linux 2"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-west-2"
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instances"
  type        = string
  // Не устанавливайте значение по умолчанию для AMI, так как оно может меняться
}

variable "instance_type" {
  description = "The instance type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instance"
  type        = string
  // Не устанавливайте значение по умолчанию для ключа, его нужно будет указать при развертывании
}

# Если вы используете IAM роли и политики, их также можно определить как переменные
variable "cloudwatch_role_name" {
  description = "The name of the IAM role for CloudWatch"
  type        = string
  default     = "ec2_cloudwatch_role"
}

variable "ssm_policy_name" {
  description = "The name of the IAM policy for SSM"
  type        = string
  default     = "ssm_policy"
}

# Добавьте любые другие переменные, которые требуются для вашей конфигурации
# Например, если у вас есть параметры для сетевой конфигурации, вы можете определить их здесь
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "The availability zone to use for the subnet"
  type        = string
  default     = "us-west-2a"
}

# ... продолжите определять переменные в соответствии с потребностями вашей инфраструктуры
