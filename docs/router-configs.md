# Router Configs (Reference)

This is a reference layout. Update interface names based on your device model.

## Router A (Core)
- LAN: 192.168.10.1/24
- WAN: 100.1.1.1/30
- NAT overload for LAN to WAN
- DHCP for 192.168.10.0/24
- IPsec peer: 100.1.1.5

## Router B (Core)
- LAN: 192.168.20.1/24
- WAN: 100.1.1.5/30
- NAT overload for LAN to WAN
- DHCP for 192.168.20.0/24
- IPsec peer: 100.1.1.1

See /config for detailed snippets.
