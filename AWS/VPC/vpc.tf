module "vpc" {
  source       = "farrukh90/vpc/aws"
  version      = "8.0.0"
  region       = var.vpc_config["region"]
  vpc_cidr     = var.vpc_config["vpc_cidr"]
  public_cidr1 = var.vpc_config["public_cidr1"]
  public_cidr2 = var.vpc_config["public_cidr2"]
  public_cidr3 = var.vpc_config["public_cidr3"]
  tags         = var.tags
}
