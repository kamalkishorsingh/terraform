resource "aws_security_group" "sg" {
	name = "terra_sg"
	description = "security group for the terraform"
	vpc_id = "${var.vpc_id}"
	
## ingress rule for security group

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
}
