# Topology Design

## Overview
Two branches (A and B) connect to a simulated Internet cloud. Each branch has:
- Router
- Switch
- Wireless AP
- Wired and wireless clients

## Logical View
Branch A LAN: 192.168.10.0/24, gateway 192.168.10.1
Branch B LAN: 192.168.20.0/24, gateway 192.168.20.1

WAN links:
- Router A <-> Cloud: 100.1.1.0/30
  - Router A: 100.1.1.1
  - Cloud: 100.1.1.2
- Cloud <-> Router B: 100.1.1.4/30
  - Cloud: 100.1.1.6
  - Router B: 100.1.1.5

## Physical Devices
- Router A, Switch A, Wireless AP A
- Router B, Switch B, Wireless AP B
- Cloud (Custom mode) with serial/ethernet/DSL ports

## Notes
- Static routing recommended for Packet Tracer simplicity.
- OSPF can be used if desired (not required).
