# VPN configuration and security notes

## Packet Tracer IPsec lab

The original repository used an IKEv1/ISAKMP sample with weak DH group 2 and a literal shared key. The template is sanitised. Substitute a disposable lab key locally; never commit real secrets.

The sample uses AES-256, SHA-256 and DH group 14 where supported by the selected IOS image. Packet Tracer models vary and may not implement these commands. Check the device command reference. This is an educational compatibility template, not a production cryptographic baseline.

Router A peer: 203.0.113.1. Router B peer: 198.51.100.1. Mirror the interesting-traffic ACL in the opposite direction on Router B.

## NAT exemption

Branch-to-branch traffic must not be translated before IPsec policy matching. The router templates deny the remote branch prefix from NAT first, then permit other local traffic for Internet PAT. Verify ACL order and counters on the selected device.

## Real AWS Site-to-Site VPN

1. Provision a real VPN-capable customer gateway with static public IP.
2. Set customer_gateway_ip and the chosen BGP ASN in Terraform variables.
3. Review the plan and create VPN resources.
4. Download the device-specific AWS VPN configuration.
5. Apply it to the real edge device during an approved maintenance window.
6. Verify both tunnels, BGP routes, security controls and application reachability.

Use AWS-generated configuration, not the Packet Tracer IKEv1 sample, in production. AWS VPN generally provides two tunnels for resilience; validate both.
