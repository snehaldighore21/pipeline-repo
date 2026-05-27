terraform {
  backend "s3" {
            bucket         = "terraform-s3-tfbucket"
            key            = "dev/terraform.tfstate"
            region         = "ap-southeast-2"
            encrypt        = true
            }
         }
