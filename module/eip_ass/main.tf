resource "aws_eip_association" "eip_ass" {
#  vpc_id   = "${var.vpc_id}"
  public_ip = "${var.pub_ip}"
  instance_id = "${var.instance_id}"	
}
