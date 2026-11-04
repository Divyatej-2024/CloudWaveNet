data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "cloudwavenet-vpc" }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "cloudwavenet-igw" }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "cloudwavenet-public"
    Tier = "public"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "cloudwavenet-private"
    Tier = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = { Name = "cloudwavenet-public-rt" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "cloudwavenet-private-rt" }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "baseline" {
  name        = "cloudwavenet-baseline"
  description = "No unsolicited inbound traffic; add narrowly scoped rules per workload."
  vpc_id      = aws_vpc.main.id
  egress {
    description = "Default outbound access; tighten for deployed workloads."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "cloudwavenet-baseline" }
}

resource "aws_cloudwatch_log_group" "vpc_flow" {
  name              = "/cloudwavenet/vpc-flow-logs"
  retention_in_days = 30
}

data "aws_iam_policy_document" "flow_logs_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "flow_logs" {
  name               = "cloudwavenet-flow-logs"
  assume_role_policy = data.aws_iam_policy_document.flow_logs_assume_role.json
}

data "aws_iam_policy_document" "flow_logs" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "flow_logs" {
  name   = "cloudwavenet-flow-logs"
  role   = aws_iam_role.flow_logs.id
  policy = data.aws_iam_policy_document.flow_logs.json
}

resource "aws_flow_log" "vpc" {
  vpc_id               = aws_vpc.main.id
  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.vpc_flow.arn
  iam_role_arn         = aws_iam_role.flow_logs.arn
}

# Optional real AWS VPN. Packet Tracer is not a supported customer-gateway endpoint.
resource "aws_vpn_gateway" "main" {
  count  = var.customer_gateway_ip == null ? 0 : 1
  vpc_id = aws_vpc.main.id
  tags   = { Name = "cloudwavenet-vgw" }
}

resource "aws_customer_gateway" "branch" {
  count      = var.customer_gateway_ip == null ? 0 : 1
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"
  tags       = { Name = "cloudwavenet-customer-gateway" }
}

resource "aws_vpn_connection" "branch" {
  count               = var.customer_gateway_ip == null ? 0 : 1
  customer_gateway_id = aws_customer_gateway.branch[0].id
  vpn_gateway_id      = aws_vpn_gateway.main[0].id
  type                = "ipsec.1"
  static_routes_only  = false
  tags                = { Name = "cloudwavenet-site-to-site-vpn" }
}
