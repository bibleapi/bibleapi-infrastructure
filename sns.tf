# Docs: https://www.terraform.io/docs/providers/aws/r/sns_topic.html
resource "aws_sns_topic" "bibleapi_rest_sns" {
  name = "bibleapi-rest-sns"
}