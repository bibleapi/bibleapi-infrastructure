resource "aws_launch_configuration" "bibleapi_launch_configuration" {
  security_groups = [ "${aws_security_group.bibleapi_security_group.id}" ]
  lifecycle { create_before_destroy = true }
  instance_type = "t2.micro"
  # http://cloud-images.ubuntu.com/locator/ec2/
  image_id = "ami-41c12e23"
  key_name = "administrator-key"
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name = "bibleapi-asg"
  min_size = 1
  max_size = 3
  launch_configuration = "${aws_launch_configuration.bibleapi_launch_configuration.name}"
  default_cooldown = 60
  availability_zones = [ "${var.availability_zone_id}" ]
  vpc_zone_identifier = [ "${var.subnet_id}" ]
  tag {
    key = "Name"
    value = "bibleapi-autoscaling-group"
    propagate_at_launch = true
  }
  lifecycle { create_before_destroy = true }
}

resource "aws_autoscaling_policy" "autoscale_group_policy_up_x1" {
  name = "autoscale_group_policy_up_x1"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
}

resource "aws_autoscaling_policy" "autoscale_group_policy_down_x1" {
  name = "autoscale_group_policy_down_x1"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
}
