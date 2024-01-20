provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "aws_linux_instance" {
  ami           = var.aws_linux_ami
  instance_type = "t2.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.example_sg.name]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  tags = {
    Name = "AwsLinuxInstance"
  }
}

resource "aws_instance" "varbox_linux_instance" {
  ami           = var.varbox_linux_ami
  instance_type = "var.instance_type"
   key_name      = var.key_name
  security_groups = [aws_security_group.example_sg.name]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  tags = {
    Name = "VarboxInstance"
  }
}


# IAM instance profile for the EC2 instances to use the assigned role
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}

# Assuming the CloudWatch and SSM policies are already defined (as shown in iam.tf)

# Attach the SSM policy to the role
resource "aws_iam_policy_attachment" "ssm_policy_attachment" {
  name       = "ssm-policy-attachment"
  roles      = [aws_iam_role.ec2_cloudwatch_role.name]
  policy_arn = aws_iam_policy.ssm_policy.arn
}

# Define the SSM policy (this should be similar to the CloudWatch policy definition)
resource "aws_iam_policy" "ssm_policy" {
  name        = "ssm_policy"
  description = "Policy that allows instances to interact with AWS Systems Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ssm:DescribeAssociation",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "ssm:GetDocument",
          "ssm:DescribeDocument",
          "ssm:GetManifest",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutInventory",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssm:UpdateInstanceInformation"
        ],
        Effect = "Allow",
        Resource = "*",
      },
      # Additional statements as needed
    ]
  })
}

# Attach the IAM role to the EC2 instance profile
resource "aws_iam_role_policy_attachment" "ec2_cloudwatch_role_attachment" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}

# Add any additional resources and configuration needed here...

