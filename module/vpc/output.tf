#defining output
output "cidr-range" {
	value = "${var.cidr}" 
}
output "id" {
	value = "${aws_vpc.vpc.id}"
}
