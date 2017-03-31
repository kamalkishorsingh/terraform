resource "aws_db_instance" "rds_pos" {
  allocated_storage    = "${var.storage_sz}"
  storage_type         = "${var.storage_ty}"
  engine               = "${var.engine}"
  engine_version       = "${var.version}"
  instance_class       = "${var.instance_cl}"
  name                 = "${var.db_name}"
  username             = "${var.username}"
  password             = "${var.passwd}"
  db_subnet_group_name = "${var.db_sub}"
#	subnets = "${var.sub_id}"
}
