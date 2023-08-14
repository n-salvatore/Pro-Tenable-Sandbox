resource "aws_sqs_queue" "q" {
  name = "examplequeue"
}

resource "aws_sqs_queue_policy" "test" {
    queue_url = aws_sqs_queue.q.id

    policy = <<EOF
        {
            "Version": "2012-10-17",
            "Id": "Queue1_Policy_UUID",
            "Statement": [{
                "Sid":"Queue1_AnonymousAccess_AllActions_AllowlistIP",
                "Effect": "Allow",
                "Principal": "*",
                "Action": "sqs:GetQueueUrl",
                "Resource": "arn:aws:sqs:*"
            }]
        }
    EOF
}

resource "aws_sqs_queue" "analytics_sqs_queue" {
  name                    = "terraform-analytics-queue"
  sqs_managed_sse_enabled = "0"
}

