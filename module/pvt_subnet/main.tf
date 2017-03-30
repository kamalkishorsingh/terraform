resource "aws_subnet" "vpc-env" {
  vpc_id     = "${var.vpc-id}"
  cidr_block = "${var.cidr}"
  availability_zone = "${var.az}"
  tags {
    Name = "${var.name}"
  }
}
