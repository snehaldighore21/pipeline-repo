terraform {
  backend "s3" {
            bucket         = "terraform-s3-tfbucket"
            key            = "dev/terraform.tfstate"
            region         = "ap-southeast-2"
            encrypt        = true
<<<<<<< HEAD
            }
         }
=======
         }
     }
>>>>>>> f283c03eb3f87ee03cfd9cee4264b1e5c96c617d
