resource "aws_key_pair" "ec2_server_key" {
    key_name   = "ec2-server-key"
    public_key = var.public_key
}

# EC2 for Dagster server
module "dagster_server" {
    source = "./modules/dagster"

    ec2_key_name = aws_key_pair.ec2_server_key.key_name
    instance_size = "t3.micro"
    tag_prefix = "dagster"
}

# EC2 for OpenMetadata server
module "openMetadata_server" {
    source = "./modules/openMetadata"

    ec2_key_name = aws_key_pair.ec2_server_key.key_name

    dagster_security_group_id = module.dagster_server.security_group_id
    instance_size = "t3.micro"
    tag_prefix = "openMetadata"
}