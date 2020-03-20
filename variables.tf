variable "ami-id" {
  description = "AMI ID "
  type = string
  default = "ami-0fc20dd1da406780b"
}

variable "availability-zone" {
  description = "Avaiability Zone to start the Instance"
  type = string
  default = "us-east-2a"
}

variable "instance-type" {
  description = "Instance Type"
  type = string
  default = "t2.medium"
}

variable "vpc-id" {
  description = "VPC ID"
  type = string
  default = "vpc-8ff626e7"
}

variable "subnet-id" {
  description = "Subnet ID"
  type = string
  default = "subnet-4431e82c"
}

variable "security-groups" {
  description = "Security groups ID"
  type = list
  default = ["sg-6b0dfe00",]
}

variable "key-name" {
  description = "Key Pair Name"
  type = string
  default = "ghost-keypair"
}

