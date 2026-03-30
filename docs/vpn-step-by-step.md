# VPN Step-by-Step (IPsec Site-to-Site)

## Phase 1 (ISAKMP)
1. Enable ISAKMP policy (aes, pre-share, group 2, lifetime 86400)
2. Set pre-shared key for the peer

## Phase 2 (IPsec)
1. Create transform set (esp-aes, esp-sha-hmac)
2. Define interesting traffic ACL (LAN A <-> LAN B)
3. Create and apply crypto map to WAN interface

## Verification
- show crypto isakmp sa
- show crypto ipsec sa
Expect QM_IDLE and increasing counters
