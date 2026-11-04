# Wireless configuration

Branch A SSID: CompanyA-Secure. Branch B SSID: CompanyB-Secure.

Use WPA2-PSK or WPA3 where supported, and set a different unique locally generated passphrase on each AP. Do not commit real credentials. AP templates contain placeholders only.

Router A provides DHCP for 192.168.10.0/24. Router B provides DHCP for 192.168.20.0/24.

Client checks: join the correct SSID, verify DHCP address and gateway, then ping the local gateway. Test inter-branch services only after the VPN is established.