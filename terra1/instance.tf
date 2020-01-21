terraform {
  backend "s3" {
    bucket="jkterraform"
    key="terra1"
    region="us-east-1"
  }
}

resource "aws_instance" "jkinstance" {
  count = 1
  ami           = "ami-04763b3055de4860b"
  instance_type = "t2.micro"
  key_name      = "kiddcorp"
  tags = {
    Name = "bubba"
 }
  provisioner "remote-exec"{
    inline=["sudo apt-get update",
            "sudo apt-get install -y nginx"]
    connection{
      host = self.public_ip
      type="ssh"
      user="ubuntu"
      private_key=file("/Users/jwkidd3/Downloads/kiddcorp")
    }
 }
 timeouts {
  create = "10m"
  delete = "1h"
 }
}
resource "aws_instance" "jkinstance2" {
  count = 1
  ami           = "ami-0d03add87774b12c5"
  instance_type = "t2.micro"
  key_name     = "kiddcorp"
  provider=aws.jk-us-west-2
  tags = {
    Name = "bubba"
 }
 depends_on = [aws_instance.jkinstance]
}
