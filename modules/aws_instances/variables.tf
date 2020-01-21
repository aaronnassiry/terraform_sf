data "aws_availability_zones" "available"{}


variable "ami"{
  type=map(string)
  default = {
  us-east-1="ami-04763b3055de4860b",
  us-west-2="ami-0994c095691a46fb5" }
}

variable "region"{
  default="us-east-1"
}

variable "total_instances" {
  default=1
}

variable "cmds"{
  default = ["touch sample.dat"]
}

