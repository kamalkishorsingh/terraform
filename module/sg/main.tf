resource "aws_security_group" "rds" {
  name        = "rds_sg"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.sg_name}"
  }
}
