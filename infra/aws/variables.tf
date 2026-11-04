variable "aws_region" {
  description = "AWS region for the lab deployment."
  type        = string
  default     = "eu-west-2"

  validation {
    condition     = can(regex("^[a-z]{2}(-[a-z]+)+-[0-9]+$", var.aws_region))
    error_message = "aws_region must use an AWS region identifier such as eu-west-2."
  }
}

variable "environment" {
  description = "Resource environment tag."
  type        = string
  default     = "lab"

  validation {
    condition     = length(trimspace(var.environment)) > 0 && length(var.environment) <= 32
    error_message = "environment must contain between 1 and 32 non-whitespace characters."
  }
}

variable "project_name" {
  description = "Short resource name prefix; use only letters, numbers and hyphens."
  type        = string
  default     = "cloudwavenet"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]+$", var.project_name))
    error_message = "project_name may contain only letters, numbers and hyphens."
  }
}

variable "vpc_cidr" {
  description = "Non-overlapping VPC IPv4 range."
  type        = string
  default     = "10.40.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0)) && tonumber(split("/", var.vpc_cidr)[1]) >= 16 && tonumber(split("/", var.vpc_cidr)[1]) <= 28
    error_message = "vpc_cidr must be a valid IPv4 CIDR with a prefix between /16 and /28 (AWS VPC limits)."
  }
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR."
  type        = string
  default     = "10.40.1.0/24"

  validation {
    condition     = can(cidrhost(var.public_subnet_cidr, 0)) && tonumber(split("/", var.public_subnet_cidr)[1]) >= 16 && tonumber(split("/", var.public_subnet_cidr)[1]) <= 28
    error_message = "public_subnet_cidr must be a valid IPv4 CIDR with a prefix between /16 and /28 (AWS subnet limits)."
  }
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR."
  type        = string
  default     = "10.40.11.0/24"

  validation {
    condition     = can(cidrhost(var.private_subnet_cidr, 0)) && tonumber(split("/", var.private_subnet_cidr)[1]) >= 16 && tonumber(split("/", var.private_subnet_cidr)[1]) <= 28 && var.private_subnet_cidr != var.public_subnet_cidr
    error_message = "private_subnet_cidr must be a valid IPv4 CIDR with a prefix between /16 and /28, distinct from public_subnet_cidr."
  }
}

variable "customer_gateway_ip" {
  description = "Optional real static public IPv4 address of a compatible VPN customer-gateway device. Null skips VPN resources."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.customer_gateway_ip == null || can(cidrhost("${var.customer_gateway_ip}/32", 0))
    error_message = "customer_gateway_ip must be null or a valid IPv4 address."
  }
}

variable "customer_gateway_bgp_asn" {
  description = "Private BGP ASN configured on the real customer gateway."
  type        = number
  default     = 65010

  validation {
    condition     = var.customer_gateway_bgp_asn >= 1 && var.customer_gateway_bgp_asn <= 4294967294
    error_message = "customer_gateway_bgp_asn must be between 1 and 4294967294."
  }
}
