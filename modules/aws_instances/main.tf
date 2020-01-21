
resource "aws_instance" "instance"{
   count = var.total_instances
   ami = var.ami[var.region]
   key_name = "kiddcorp"
   instance_type = "t2.micro"
   security_groups = ["default"]
   availability_zone=data.aws_availability_zones.available.names[count.index]
   provisioner "remote-exec"{
     inline = var.cmds
     connection{
       type = "ssh"
       user = "ubuntu"
       private_key = file("/Users/jwkidd3/Downloads/kiddcorp")
       host=self.public_ip
     }
   }
}

