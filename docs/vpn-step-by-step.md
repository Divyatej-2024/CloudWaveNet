# VPN step-by-step

For the Packet Tracer educational lab, see /docs/vpn.md. Device support varies; use only commands supported by the selected IOS image.

1. Confirm WAN peer reachability.
2. Configure matching IKE policy and a unique local lab-only pre-shared key on both peers.
3. Configure matching IPsec transform settings.
4. Define mirrored interesting-traffic ACLs for both branch LANs.
5. Exclude branch-to-branch traffic from NAT.
6. Apply crypto map to the correct WAN interface.
7. Generate branch traffic and inspect supported IKE/IPsec SA counters.

For AWS, enable optional VPN resources only with a real static customer-gateway IP. Download and apply the AWS vendor-specific configuration. Packet Tracer's Cloud object is not an AWS VPN endpoint.