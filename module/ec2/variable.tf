variable "ami_id" {
	default = "ami-5e63d13e"
}

variable "subnet_id" {}

variable "instance_type" {
	default = "t2.micro"
}
variable "name" {}

#variable "vpc-id" {}
variable "key_name" {}
variable "pri-ip" {}

variable "sg_ids" {
	type = "list"
}
