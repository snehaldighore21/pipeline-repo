aws_region   = "ap-southeast-2"
environment  = "dev"
project_name = "cdec"

vpc_cidr     = "10.0.0.0/16"
subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

availability_zones = ["ap-southeast-2a", "ap-southeast-2b"]

cluster_name    = "cdec-dev-eks"
cluster_version = "1.30"

node_instance_type = "t3.medium"
desired_size       = 2
min_size           = 1
max_size           = 3
