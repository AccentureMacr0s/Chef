resource "aws_instance" "aws_linux_instance" {
  ami           = var.aws_linux_ami
  instance_type = "t2.micro"
  # Другие необходимые конфигурации
}

resource "aws_instance" "varbox_linux_instance" {
  ami           = var.varbox_linux_ami
  instance_type = "t2.micro"
  # Другие необходимые конфигурации
}


resource "aws_iam_role" "cloudwatch_role" {
  name = "cloudwatch_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ]
  })
}

resource "aws_iam_policy" "cloudwatch_policy" {
  name        = "cloudwatch_policy"
  description = "A policy for CloudWatch to allow EC2 to send metrics"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "cloudwatch:PutMetricData",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup"
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attachment" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}

resource "aws_security_group" "example" {
  name        = "example_security_group"
  description = "Security group for example usage"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
