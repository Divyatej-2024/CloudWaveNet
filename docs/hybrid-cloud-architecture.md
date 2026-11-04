# Hybrid cloud architecture

## Two implementation planes

### Packet Tracer learning lab

Packet Tracer demonstrates branch LANs, DHCP, routing, wireless access, NAT and (where supported by the selected simulated router) site-to-site IPsec. It uses documentation-only WAN addresses and a simulated ISP.

### AWS deployment

Terraform provisions an AWS VPC with:
- one public subnet and Internet Gateway route;
- one private subnet without a default Internet route;
- a security group with no unsolicited inbound access;
- VPC Flow Logs delivered to CloudWatch with 30-day retention;
- optional Virtual Private Gateway, Customer Gateway and Site-to-Site VPN.

VPN resources are opt-in: they require a real customer gateway's static public IP and incur charges. Dynamic routing uses BGP. Use AWS-generated configuration for the chosen vendor/software.

## Addressing

Default AWS VPC: 10.40.0.0/16. Public subnet: 10.40.1.0/24. Private subnet: 10.40.11.0/24. These do not overlap the Packet Tracer branch LANs. Check all connected corporate networks before real deployment.

## Traffic flow

- Internet-facing workloads, if later added, belong in the public subnet with narrowly scoped ingress.
- Private workloads have no default Internet route in this baseline.
- Branch-to-cloud traffic traverses AWS VPN only after a compatible customer gateway is configured and route propagation/advertisement is verified.
- VPC Flow Logs provide interface metadata; they are not packet capture and do not decrypt VPN traffic.

## Important limitation

Do not describe Packet Tracer's simulated Cloud as a functioning AWS VPN. A compatible physical or virtual VPN appliance with a real public endpoint is required for a genuine tunnel.
