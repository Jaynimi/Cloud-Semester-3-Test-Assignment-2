locals {
  eks_module_version = "~> 19.0"
  vpc_module_version = "~> 3.0"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = local.vpc_module_version

  name = "bedrock-vpc"
  cidr = var.vpc_cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  tags = {
    Project = "ProjectBedrock"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = local.eks_module_version

  cluster_name    = var.cluster_name
  cluster_version = "1.26"
  subnets         = concat(module.vpc.public_subnets, module.vpc.private_subnets)
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
      name             = "bedrock-ng"
      subnet_ids       = module.vpc.private_subnets
    }
  }

  manage_aws_auth = true
  tags = {
    Project = "ProjectBedrock"
  }
}

# Make EKS cluster data available for kubernetes provider if you want to use provider in terraform
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
