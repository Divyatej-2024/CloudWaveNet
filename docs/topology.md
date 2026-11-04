# Packet Tracer topology and addressing

## Scope

This is the simulation network. The simulated ISP Cloud is a Packet Tracer object, not an AWS service.

## Branch LANs

| Segment | Network | Gateway |
|---|---|---|
| Branch A users | 192.168.10.0/24 | 192.168.10.1 |
| Branch B users | 192.168.20.0/24 | 192.168.20.1 |

## WAN point-to-point links

Use RFC 5737 documentation-only ranges in the lab. They are not Internet-routable.

| Link | Network | Router | ISP cloud |
|---|---|---|---|
| Branch A–ISP | 198.51.100.0/30 | Router A: 198.51.100.1 | 198.51.100.2 |
| Branch B–ISP | 203.0.113.0/30 | Router B: 203.0.113.1 | 203.0.113.2 |

Router A default route: 0.0.0.0/0 via 198.51.100.2.
Router B default route: 0.0.0.0/0 via 203.0.113.2.

The simulated ISP needs routes for 192.168.10.0/24 via 198.51.100.1 and 192.168.20.0/24 via 203.0.113.1. Confirm how the selected Packet Tracer Cloud/router implements routes.

## Logical layout

```text
Branch A clients -- Switch A -- Router A ----                                               Simulated ISP
Branch B clients -- Switch B -- Router B ----/       |
                                                      | separate real-world design
                                                AWS Site-to-Site VPN
                                                      |
                                                AWS Virtual Private Gateway
                                                      |
                                                    AWS VPC
```

The AWS link is an architectural target, not a Packet Tracer-supported direct connection. A real customer-gateway appliance with a public IP and supported IPsec/BGP is required.

## VLAN expansion

Current router templates retain one untagged LAN per branch. Department VLANs are a planned extension. Add router subinterfaces, switch trunks and access-port assignments together; do not enable tagging on one side only.
