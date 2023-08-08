resource "aws_sns_topic" "service_topic" {
    name = "service-updates-topic"
    policy = <<EOF
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Action": "sns:GetTopicAttributes",
                    "Principal": {
                        "AWS": "*"
                    },
                    "Resource": "*",
                    "Effect": "Allow",
                    "Sid": ""
                }
            ]
        }
    EOF
}

resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
}
