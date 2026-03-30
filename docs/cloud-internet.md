# Cloud Internet Configuration

## Cloud Object
- Use Cloud in Custom mode
- Enable Serial + Ethernet + DSL interfaces (as needed)

## IP Plan
- A<->Cloud: 100.1.1.0/30
- Cloud<->B: 100.1.1.4/30

## Cloud Routing
Add static routes in the Cloud to direct LAN traffic:
- 192.168.10.0/24 via 100.1.1.1
- 192.168.20.0/24 via 100.1.1.5

## Router Default Routes
- Router A: default route to 100.1.1.2
- Router B: default route to 100.1.1.6
