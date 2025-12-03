🌐 CloudWaveNET
Secure Wireless Branch-to-Branch Communication via Cloud Internet (Packet Tracer Project)

CloudWaveNET is a fully simulated enterprise networking project built in Cisco Packet Tracer.
It demonstrates how two branch offices communicate through a cloud-based Internet, supported by wireless access, routing, NAT, and IPsec VPN encryption.

This project is designed as a portfolio-ready, industry-level networking scenario for cybersecurity and networking students.

📌 Project Features

✔ Wireless LAN for both branches
✔ Cloud Internet simulation
✔ Static routing or OSPF (optional)
✔ NAT overload for internet access
✔ Secure IPsec Site-to-Site VPN tunnel
✔ DHCP for wireless clients
✔ Network topology diagrams
✔ Professional documentation & configs included

🏗️ Project Architecture
   Branch A ─────────┐
                     │
   Wireless AP  ─── Router A     Cloud (Internet)     Router B ─── Wireless AP
                     │
   Branch B ─────────┘

Key Technologies

Wireless LAN (WPA2/WPA3)

Router-to-Cloud WAN simulation

IPsec VPN (ISAKMP + IPsec Phase 1 & 2)

DHCP

NAT

VLANs (optional)

Static routing / OSPF

📁 Repository Structure
cloudwavenet/
│
├── README.md
├── diagrams/
├── docs/
├── simulation/
├── config/
├── src/
└── reports/


Full folder explanations are inside the repo.

🧩 Network Topology Overview
Branch A
Device	Purpose
Router A	Manages LAN/WLAN, VPN peer
Switch A	LAN distribution
Wireless AP A	WiFi access for clients
Laptops / PCs	Wireless and wired hosts
Branch B

Same layout as Branch A.

Cloud

Simulates ISP/Internet using:

Cloud > "Custom" mode

Serial, Ethernet, and DSL connections

Static routes pointing to WAN subnets

🔧 IP Addressing Plan
WAN (Cloud Internet Simulation)
Link	Network	Router A	Cloud	Router B
A ↔ Cloud	100.1.1.0/30	100.1.1.1	100.1.1.2	—
B ↔ Cloud	100.1.1.4/30	—	100.1.1.6	100.1.1.5
LAN Networks
Branch	Network	Gateway
A	192.168.10.0/24	192.168.10.1
B	192.168.20.0/24	192.168.20.1
📶 Wireless Configuration
Company A Wireless

SSID: CompanyA-Secure

Security: WPA2-PSK

Key: StrongPassword123!

Company B Wireless

SSID: CompanyB-Secure

Security: WPA2-PSK

Key: StrongPassword123!

🔒 IPsec VPN Configuration (Summary)
Phase 1 (ISAKMP)
crypto isakmp policy 10
 encryption aes
 authentication pre-share
 group 2
 lifetime 86400

Pre-Shared Key
crypto isakmp key MyComplexKey123 address 100.1.1.5

Phase 2 (IPsec Transform Set)
crypto ipsec transform-set TRANS1 esp-aes esp-sha-hmac

Crypto Map
crypto map VPN-MAP 10 ipsec-isakmp
 set peer 100.1.1.5
 set transform-set TRANS1
 match address VPN-TRAFFIC

🧪 Testing Checklist
1. Verify WLAN

Laptop → Connect to SSID

Ping gateway: ping 192.168.x.1

2. Verify Cloud Routing

Router A ping Router B WAN:

ping 100.1.1.5

3. Verify VPN Tunnel
show crypto isakmp sa
show crypto ipsec sa


Should show:

QM_IDLE (Phase 2 up)

Increasing packet counters

4. Branch-to-Branch Test

Laptop in Branch A → ping Laptop in Branch B
Should succeed through encrypted tunnel.

🗂️ Packet Tracer Files Included

Located in:
simulation/

CloudWaveNET-v1.pkt – Base LAN + Cloud

CloudWaveNET-v2-Wireless.pkt – WLAN added

CloudWaveNET-v3-VPN.pkt – VPN configured

CloudWaveNET-final.pkt – Final project

📘 Documentation

Inside /docs/:

Topology design

Wireless configuration steps

Cloud Internet config

Router configs

Full VPN step-by-step

Security analysis

Testing proof

Conclusion

🧑‍🎓 Who Is This Project For?

Networking students

Cybersecurity students

CCNA learners

Anyone building a strong GitHub portfolio

🏁 Conclusion

CloudWaveNET demonstrates how real companies connect securely over the Internet using cloud infrastructure, Wi-Fi, routing, and encryption.
This project is designed to showcase professional-level network design and cybersecurity fundamentals.
