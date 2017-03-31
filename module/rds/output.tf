output "db_id" {
  value = "${aws_db_instance.rds_pos.id}"
}

output "db_address" {
  value = "${aws_db_instance.rds_pos.address}"
}
