variable "vpc_id" {}
variable "cidr" {
	default = "0.0.0.0/0"
}
variable "sg_name" {
	default = "sg_rds"
}
