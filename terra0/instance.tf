provider "aws"{
  region="us-east-1"
}
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = "${aws_default_vpc.default.id}"
  cidr_block = "172.31.128.0/24"

  tags = {
    Name = "Bubba"
  }
}

resource "aws_security_group" "ssh_group"{
  vpc_id = "${aws_default_vpc.default.id}"
  name = "jk_allow_ssh"
  description = "SG for allowing SSH"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SSH-IN"
  }
}
