variable "AWS_REGION"{
  default="us-east-1"
}

variable "AMIS"{
  type=map(string)
  default = {
   us-east-1="ami-062f7200baf2fa504"
  }
}
