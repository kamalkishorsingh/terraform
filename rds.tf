## specify the region##
##

provider "aws" {
        access_key = "${var.aws_access_key}"
        secret_key = "${var.aws_secret_key}"
        region = "${var.aws_region}"
}

##applying vpc module ###

module "vpc" {
  source = "./module/vpc"
}
#### security_group####

module "sg" {
	source = "./module/sg"
	vpc_id = "${module.vpc.id}"
}


module "key-pair" {
        source = "./module/key-pair"
}
#### subnet #####

module "subnet_rds01" {
        source = "./module/subnet"
        cidr = "192.168.20.0/24"
        az = "us-west-2a"
        vpc-id = "${module.vpc.id}"
	name = "rds-01"
}
module "subnet_rds02" {
        source = "./module/subnet"
        cidr = "192.168.21.0/24"
        az = "us-west-2b"
        vpc-id = "${module.vpc.id}"
	name = "rds-02"
}


###### subnet_gp#####
module "sub_gp" {
	source = "./module/subnet_gp"
	sub_id = ["${list(module.subnet_rds01.id, module.subnet_rds02.id)}"]
}


##### rds####
module "rds" {
	source = "./module/rds"
	storage_sz = "10"
	storage_ty = "standard"
	engine = "postgres"
	instance_cl = "db.t2.micro" 
	db_name = "myrds" 
	username = "root"
	db_sub	= "${module.sub_gp.name}"
}			
