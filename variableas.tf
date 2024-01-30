
variable "provider_region" {
  type        = string
  default     = "us-west-2"
  description = "aws region for environment"
}


variable "dev_vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "dev_vpc cidr block"
}

variable "dev_vpc_id" {
  type        = string
  default     = "aws_vpc.dev_vpc.id"
  description = "id of vpc"
}

variable "Public_Subnet_AZ1_cidr_block" {
  type        = string
  default     = "10.0.0.0/24"
  description = "public subnet cidr block"
}

variable "Public_Subnet_AZ2_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "public subnet AZ2"
}

variable "availability_zone_az1" {
  type        = string
  default     = "us-west-2a"
  description = "availability zone az1"
}

variable "availability_zone_az2" {
  type        = string
  default     = "us-west-2b"
  description = "availability zone az2"
}

variable "private_app_subnet_az1_cidr_block" {
  type        = string
  default     = "10.0.2.0/24"
  description = "private app subnet az1 cidr block"
}

variable "private_app_subnet_az2_cidr_block" {
  type        = string
  default     = "10.0.3.0/24"
  description = "private app subnet az2 cidr block"
}

variable "private_data_subnet_az1_cidr_block" {
  type        = string
  default     = "10.0.4.0/24"
  description = "private data subnet az1 cidr block"
}

variable "private_data_subnet_az2_cidr_block" {
  type        = string
  default     = "10.0.5.0/24"
  description = "private data subnet az2 cidr block"
}


