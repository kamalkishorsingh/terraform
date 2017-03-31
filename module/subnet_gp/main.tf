resource "aws_db_subnet_group" "sub_grp" {
  name        = "rds_sub_grp"
  subnet_ids  = "${var.sub_id}"
}
