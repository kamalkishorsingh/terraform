variable "storage_sz" {
  default     = "10"
  description = "Storage size in GB"
}

variable "storage_ty" {}

variable "engine" {
#  default     = "postgres"
}

variable "version" {
  description = "Engine version"
    default = "9.4.1"
}

variable "instance_cl" {
  default     = "db.t2.micro"
  description = "Instance class"
}

variable "db_name" {}

variable "username" {
	default = "root"
}

variable "passwd" {
	default = "root"
}
#variable "sub_id" {}
variable "db_sub" {}
#variable "vpc_id"
