resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  alarm_name = "bibleapi-alarm-cpu-high"
  alarm_description = "This alarm triggers when CPU load in Autoscaling group is high."
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.autoscaling_group.name}"
  }
  statistic = "Average"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  period = 60
  threshold = 40
  # http://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html
  alarm_actions = [
    "${aws_autoscaling_policy.autoscale_group_policy_up_x1.arn}",
  ]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low_alarm" {
  alarm_name = "bibleapi-alarm-cpu-low"
  alarm_description = "This alarm triggers when CPU load in Autoscaling group is low."
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.autoscaling_group.name}"
  }
  statistic = "Average"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "1"
  period = 60
  threshold = 35
  # http://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html
  alarm_actions = [
    "${aws_autoscaling_policy.autoscale_group_policy_down_x1.arn}",
  ]
}

