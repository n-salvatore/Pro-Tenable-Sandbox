resource "aws_ecs_task_definition" "test_task_definition" {
  family                = "test-task-family"
  container_definitions = <<EOF
[
  {
    "name": "test-container",
    "image": "test-container-image",
    "environment": [
      {
        "name": "TEST_SECRET_KEY",
        "value": "test-secret-value"
      }
    ],
    "secrets": [
      {
        "name": "ACCESS_TOKEN",
        "valueFrom": "arn:aws:secretsmanager:us-west-2:123456789012:secret:test-access-token"
      },
      {
        "name": "API_KEY",
        "valueFrom": "arn:aws:ssm:us-west-2:123456789012:parameter/test-api-key"
      }
    ]
  }
]
EOF


resource "aws_instance" "test_ec2_instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"

  # Additional configuration for your EC2 instance...

  user_data = <<-EOF
    #!/bin/bash
    export PASSWORD="my-password"
    export ACCESS_TOKEN="my-access-token"
    
    # Rest of the user data script...
  EOF
