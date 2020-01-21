resource "aws_instance" "bubba1"{
  ami = var.AMIS[var.AWS_REGION]
  instance_type="t2.micro"
  key_name="kiddcorp"
  tags = {
   Name="bubba"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.bubba1.private_ip} >> private_ips.txt"
  }  
}
