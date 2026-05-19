variable "instance_size" {
    description = "Size of ec2 resource."
    type = string
}

variable "tag_prefix" {
    description = "Tag prefix for ec2 resource."
    type = string
}

variable "ec2_key_name" {
    description = "EC2 Key name"
    type = string
}

variable "dagster_security_group_id" {
    description = "security group for openMetadata server"
    type = string
}