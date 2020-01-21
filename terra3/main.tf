terraform {
  backend "s3" {
    bucket="jkterraform"
    key="terra4"
    region="us-east-1"
  }
}
provider "aws"{
  region = "us-east-1"  
}
provider "aws"{
  alias = "us-west-2"
  region = "us-west-2"
}
data "aws_region" "r"{
}
data "aws_region" "s"{
  provider = aws.us-west-2
}
data "aws_availability_zones" "east_zones"{}
data "aws_availability_zones" "west_zones"{
  provider = aws.us-west-2
}
variable "env-name" {
  default = "pre-prod"
}
variable "multi-region"{
  default = true
}

variable "ami"{
  type=map(string)
  default = {
  us-east-1="ami-04763b3055de4860b",
  us-west-2="ami-0994c095691a46fb5" }
}

resource "aws_instance" "east_vm"{
    tags= {
      Name = local.default_front_name
    }
    count = var.multi-region ? 2:0
    availability_zone=data.aws_availability_zones.east_zones.names[count.index]
    ami=var.ami["us-east-1"]
    instance_type="t2.micro"
    key_name="kiddcorp"
    lifecycle{
      create_before_destroy=true
    }
}

locals{
  default_front_name=join("-",list(var.env-name,"frontend"))
  default_back_name=join("-",list(var.env-name,"backend"))
}
output "out"{
  value = data.aws_availability_zones.east_zones
}
output "out2"{
  value=data.aws_availability_zones.west_zones
}
output "out3"{
  value=data.aws_region.s.name
}
output "out4"{
  value=local.default_front_name
}
output "out5" {
  value = var.ami["us-east-1"]
}
output "out6"{
  value=aws_instance.east_vm.*.public_ip
}
