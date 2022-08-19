resource "aws_sns_topic" "user_updates" {
  name = "pokemon-fun-facts-topic"
}

resource "aws_sns_topic_subscription" "poke_sub_email" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = "test@gmail.com"
}