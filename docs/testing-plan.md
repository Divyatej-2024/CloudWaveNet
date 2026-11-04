# Testing and evidence plan

Do not mark a test passed until command output or a screenshot is captured. These changes have not been run in Packet Tracer or deployed to AWS.

## Automated CI

GitHub Actions runs terraform fmt -check -recursive, terraform init -backend=false and terraform validate. These check formatting and configuration/provider schemas; they do not create infrastructure.

## Packet Tracer tests

| Test | Procedure | Expected evidence |
|---|---|---|
| Client DHCP | Join each WLAN and inspect IP settings | Address in correct /24 and correct gateway |
| LAN gateway | Ping local router gateway | Successful reply |
| WAN reachability | Ping each router's ISP next hop | Successful reply |
| Routing | Inspect route tables | Branch routes present |
| VPN negotiation | Inspect supported IKE/IPsec SA commands | Established SA |
| VPN traffic | Send traffic between branch LANs | IPsec encapsulation/decapsulation counters increase |
| NAT exemption | Inspect translations during branch traffic | Branch-to-branch traffic is not PAT-translated |
| Internet NAT | Generate permitted Internet-bound traffic | PAT translation appears |

## AWS tests

1. Review terraform plan and confirm only intended resources.
2. Confirm VPC/subnet CIDRs do not overlap connected networks.
3. Confirm private route table has no default Internet route.
4. Confirm security group has no unintended ingress.
5. Confirm VPC Flow Logs are active and records reach CloudWatch.
6. If VPN enabled, verify both tunnel statuses and BGP route exchange.
7. From an authorised test host, verify only intended application ports are reachable.

## Evidence

Save redacted screenshots and CLI output under reports/evidence/. Remove public IPs, account IDs, usernames, tokens and PSKs. Update reports/validation-results.md with date, environment, exact command, result and evidence path.
