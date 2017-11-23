# Add missing arguments according to terraform/aws documentation.
# Docs: https://www.terraform.io/docs/providers/aws/r/elb.html
resource "aws_elb" "bibleapi_elb" {
  name = "bibleapi-elb"
  security_groups = [ "${aws_security_group.bibleapi_security_group.id}" ]
  connection_draining = true

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  # Configure ELB health checks here
  health_check {
    target = "HTTP:80/"
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 2
    interval = 5
  }

  # Keep these arguments as is:
  subnets = [ "${var.subnet_id}" ]
  internal = true
}