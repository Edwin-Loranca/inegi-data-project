# EC2 for Dagster server
module "dagster_server" {
    source = "./modules/ec2"

    public_key = var.public_key
    instance_size = "t3.micro"
    tag_prefix = "dagster"
}