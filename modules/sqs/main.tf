


resource "aws_sqs_queue" "sqs_queue" {
  count = "${length(var.subscriber_name)}"
  name = "${element(var.subscriber_name, count.index)}"
  delay_seconds             = 10
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue_policy" "sqs_policy" {
  count = "${length(var.subscriber_name)}"
  queue_url = aws_sqs_queue.sqs_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${element(aws_sqs_queue.sqs_queue.*.arn, count.index)}"
    }
  ]
}
POLICY
}




resource "aws_sns_topic_subscription" "sns_subscription" {
  count = "${length(var.subscriber_name)}"
  topic_arn = element(aws_sns_topic.sns_topic.*.arn,count.index )
  protocol  = "sqs"
  endpoint  = element(aws_sqs_queue.sqs_queue.*.arn,count.index )
}

resource "aws_sns_topic" "sns_topic" {
  count = "${length(var.subscriber_name)}"
  name = "${element(var.subscriber_name, count.index)}"