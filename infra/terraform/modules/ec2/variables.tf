variable "public_key" {
    description = "SSH public key."
    type        = string
}

variable "instance_size" {
    description = "Size of ec2 resource."
    type = string
}

variable "tag_prefix" {
    description = "Tag prefix for ec2 resource."
    type = string
}