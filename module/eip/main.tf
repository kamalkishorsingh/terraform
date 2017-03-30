resource "aws_eip" "eip" {
  instance = "${var.instance_id}"
  vpc      = true
}
#resource "aws_internet_gateway" "gw" {
#  vpc_id = "${var.vpc_id}"
#
#	tags {
#	Name = "gw-terra"
#}
#}
