
#Create an SNS
resource "aws_sns_topic" "cpu_high" {
  name = "cpu_high"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.cpu_high.arn
  protocol  = "email"
  endpoint  = "amir.mam.helmy@gmail.com"
}



# #Attach SNS to Resource based Policy
# resource "aws_sns_topic_policy" "default" {
#   arn    = aws_sns_topic.cpu_high.arn
#   policy = data.aws_iam_policy_document.sns_topic_policy.json
# }



# #Resource based policy 
# data "aws_iam_policy_document" "sns_topic_policy" {
#   statement {
#     effect  = "Allow"
#     actions = ["SNS:Publish"]

#     principals {
#       type        = "Service"
#       identifiers = ["events.amazonaws.com"]
#     }

#     resources = [aws_sns_topic.cpu_high.arn]
#   }
# }


