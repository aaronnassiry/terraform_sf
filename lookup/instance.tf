variable "aws_region" { default = "us-east-2" } 

provider "aws" {
    region = var.aws_region
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

output "image_id" {
    value = "${data.aws_ami.ubuntu.id}"
}
