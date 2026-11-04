variable "aws_region" {
  description = "AWS region for the lab deployment."
  type        = string
  default     = "eu-west-2"
}

variable "environment" {
  description = "Resource environment tag."
  type        = string
  default     = "lab"
}

variable "project_name" {
  description = "Short resource name prefix."
  type        = string
  default     = "cloudwavenet"
}

variable "vpc_cidr" {
  description = "Non-overlapping VPC IPv4 range."
  type        = string
  default     = "10.40.0.0/16"
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR."
  }
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR."
  type        = string
  default     = "10.40.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR."
  type        = string
  default     = "10.40.11.0/24"
}

variable "customer_gateway_ip" {
  description = "Optional real static public IP of a compatible VPN customer gateway. Null skips VPN resources."
  type        = string
  default     = null
  nullable    = true
}

variable "customer_gateway_bgp_asn" {
  description = "Private BGP ASN configured on the real customer gateway."
  type        = number
  default     = 65010
}
