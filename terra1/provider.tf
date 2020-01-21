provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias="jk-us-west-2"
  region="us-east-2"
}
