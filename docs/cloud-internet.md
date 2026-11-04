# Packet Tracer simulated ISP

This describes the Packet Tracer Cloud/ISP lab only. It is not an AWS configuration.

WAN links:
- Branch A–ISP: 198.51.100.0/30 (Router A .1, ISP .2)
- Branch B–ISP: 203.0.113.0/30 (Router B .1, ISP .2)

Router default routes:
- Router A: 0.0.0.0/0 via 198.51.100.2
- Router B: 0.0.0.0/0 via 203.0.113.2

ISP routes:
- 192.168.10.0/24 via 198.51.100.1
- 192.168.20.0/24 via 203.0.113.1

Confirm the selected Packet Tracer Cloud/router supports route configuration. These are documentation-only address blocks, not real public WAN addresses.