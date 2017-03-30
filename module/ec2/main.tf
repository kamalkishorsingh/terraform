resource "aws_instance" "instance" {
  ami       = "${var.ami_id}"
  subnet_id = "${var.subnet_id}"
  instance_type = "${var.instance_type}"
#  vpc_security_group_ids = "${var.vpc-id}"  
	key_name = "${var.key_name}"
	private_ip = "${var.pri-ip}"
tags	{
	Name = "${var.name}"
}
}
