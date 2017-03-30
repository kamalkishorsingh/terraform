## specify the region##
##

provider "aws" {
	access_key = "${var.aws_access_key}"
  	secret_key = "${var.aws_secret_key}"
	region = "${var.aws_region}"
}
## Access key ###

output "key-name" {
	value	= "${module.key-pair.key-name}"
}
##applying child module###

module "child" {
  source = "./module/child"

  memory = "1G"
}

output "child_memory" {
  value = "${module.child.mem}"
}
##applying vpc module ###


module "vpc" {
  source = "./module/vpc"
}

module "key-pair" {
	source = "./module/key-pair"
}

module "subnet" {
	source = "./module/subnet"
	cidr = "192.168.1.0/24"
	az = "us-west-2a"
	vpc-id = "${module.vpc.id}"	
}

module "gw" {
	source = "./module/gw"
	vpc_id = "${module.vpc.id}"
}

module "route" {
	source = "./module/rt"
	vpc_id = "${module.vpc.id}"
	gateway_id  = "${module.gw.id}" 
}

module "sg" {
	source = "./module/sg"
	vpc_id = "${module.vpc.id}"
}

module "server" {
	source = "./module/ec2"
	subnet_id = "${module.subnet.id}"
	name	= "chef-server"
#	vpc-id = "${module.vpc.id}"
	pri-ip	= "192.168.1.211"
	key_name = "${module.key-pair.key-name}"
}



module "wks" {
        source = "./module/ec2"
        subnet_id = "${module.subnet.id}"
        name    = "chef-wks"
#	vpc-id = "${module.vpc.id}"
	key_name = "${module.key-pair.key-name}"
	pri-ip	= "192.168.1.106"
}
module "server_eip" {
	source = "./module/eip"
	instance_id = "${module.server.id}"
	vpc_id = "${module.vpc.id}"
}
module "wks_eip" {
	source = "./module/eip"
	instance_id = "${module.wks.id}"
	vpc_id = "${module.vpc.id}"
}
module "server_ass" {
	source  = "./module/eip_ass"
#	vpc_id = "${module.vpc.id}"
	pub_ip = "${module.server_eip.ip}"
	instance_id = "${module.server.id}"
}
module "wks_ass" {
	source = "./module/eip_ass"
#	vpc_id = "${module.vpc.id}"
	pub_ip = "${module.wks_eip.ip}"
	instance_id = "${module.wks.id}"
}

