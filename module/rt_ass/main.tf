resource "aws_route_table_association" "r_ass" {
  subnet_id      = "${var.subnet_id}"
  route_table_id = "${var.rt_id}"
}
