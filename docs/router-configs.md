# Router configuration reference

The /config snippets are starting points, not guaranteed copy/paste commands. Update interface names and confirm support for the exact Packet Tracer router model/IOS image.

Branch A: LAN 192.168.10.1/24; WAN 198.51.100.1/30; DHCP 192.168.10.0/24; NAT-BRANCH-A; default route via 198.51.100.2.

Branch B: LAN 192.168.20.1/24; WAN 203.0.113.1/30; DHCP 192.168.20.0/24; NAT-BRANCH-B; default route via 203.0.113.2.

IPsec is described in /config/ipsec-template.txt and /docs/vpn.md. The real AWS VPN must use AWS-generated device configuration for a supported customer gateway.