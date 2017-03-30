provider "aws" {
        access_key = "${var.aws_access_key}"
        secret_key = "${var.aws_secret_key}"
        region = "${var.aws_region}"
}
module "vpc" {
  source = "./module/vpc"
}

module "key-pair" {
        source = "./module/key-pair"
}


##### eip generation#####
module "pub1_eip" {
        source = "./module/eip"
        instance_id = "${module.server.id}"
        vpc_id = "${module.vpc.id}"
}
module "pub2_eip" {
        source = "./module/eip"
        instance_id = "${module.wks.id}"
        vpc_id = "${module.vpc.id}"
}
#### private subnet ####
module "pvt1_subnet" {
        source = "./module/pvt_subnet"
        cidr = "192.168.11.0/24"
        az = "us-west-2a"
        vpc-id = "${module.vpc.id}"
}	
module "pvt2_subnet" {
        source = "./module/pvt_subnet"
        cidr = "192.168.12.0/24"
        az = "us-west-2a"
        vpc-id = "${module.vpc.id}"
}
#### public subnet ####
module "subnet_pub1" {
        source = "./module/subnet"
        cidr = "192.168.13.0/24"
        az = "us-west-2a"
        vpc-id = "${module.vpc.id}"
#	eip_ip = "${module.eip.ip}"
}
module "subnet_pub2" {
        source = "./module/subnet"
        cidr = "192.168.14.0/24"
        az = "us-west-2a"
        vpc-id = "${module.vpc.id}"
#	eip_ip = ""
}
##### association of eip ####

module "server_ass" {
        source  = "./module/eip_ass"
#       vpc_id = "${module.vpc.id}"
        pub_ip = "${module.pub1_eip.ip}"
        instance_id = "${module.server.id}"
}

module "wks_ass" {
        source = "./module/eip_ass"
#       vpc_id = "${module.vpc.id}"
        pub_ip = "${module.pub2_eip.ip}"
        instance_id = "${module.wks.id}"
}



#######ec2 #######
module "server" {
        source = "./module/ec2"
        subnet_id = "${module.subnet_pub1.id}"
        name    = "chef-server"
#       vpc-id = "${module.vpc.id}"
#        pri-ip  = "192.168.1.211"
        key_name = "${module.key-pair.key-name}"
}


module "wks" {
        source = "./module/ec2"
        subnet_id = "${module.subnet_pub2.id}"
        name    = "chef-wks"
#       vpc-id = "${module.vpc.id}"
        key_name = "${module.key-pair.key-name}"
#        pri-ip  = "192.168.1.106"
}
### adding route table ###
module "route_pub1" {
        source = "./module/rt"
        vpc_id = "${module.vpc.id}"
        gateway_id  = "${module.gw_01.id}"
}

module "route_pub2" {
        source = "./module/rt"
        vpc_id = "${module.vpc.id}"
        gateway_id  = "${module.gw_02.id}"
#        subnet_id   = "${module.subnet_pub2.id}"
}
#module "route_pvt1" {
#        source = "./module/rt"
#        vpc_id = "${module.vpc.id}"
#        gateway_id  = "${module.subnet_pub1.id}"
#        subnet_id   = "${module.pvt1_subnet.id}"
#}
#module "route_pvt2" {
#        source = "./module/rt"
#        vpc_id = "${module.vpc.id}"
#        gateway_id  = "${module.subnet_pub2.id}"
#        subnet_id   = "${module.pvt2_subnet.id}"
#}

###gw####
module "gw_01" {
        source = "./module/gw"
        vpc_id = "${module.vpc.id}"
}
module "gw_02" {
        source = "./module/gw"
        vpc_id = "${module.vpc.id}"
}
##### route ass ####
module "rt_ass_pub1" {
	source = "./module/rt_ass"
	subnet_id   = "${module.subnet_pub1.id}"
	rt_id	= "${module.route_pub1.id}"
}
module "rt_ass_pub2" {
        source = "./module/rt_ass"
        subnet_id   = "${module.subnet_pub2.id}"
        rt_id    = "${module.route_pub2.id}"
}
# module "rt_ass_pvt1" {
#        source = "./module/rt_ass"
#        subnet_id   = "${module.pvt1_subnet.id}"
#        rt_id    = "${module.route_pvt1.id}"
#} 
#module "rt_ass_pvt2" {
#        source = "./module/rt_ass"
#        subnet_id   = "${module.pvt2_subnet.id}"
#        rt_id    = "${module.route_pvt2.id}"
#}   

