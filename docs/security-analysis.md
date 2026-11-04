# Security analysis

## Findings from repository review

1. The original AP files and IPsec template contained literal example passphrases. These are now placeholders. Rotate them if used outside a disposable lab.
2. The old VPN sample used DH group 2. The updated educational template uses stronger parameters where supported; production should use current vendor/AWS-generated IKEv2 settings.
3. Original NAT ACLs did not explicitly exempt remote-branch traffic from PAT. Updated router templates deny the remote LAN before permitting Internet PAT.
4. Existing testing documents were templates, not execution evidence.
5. Original project had no deployable AWS infrastructure-as-code. Terraform now supplies a reviewable baseline.

## Controls

- Separate branch LANs and AWS VPC CIDRs.
- Explicit routing and VPN traffic selectors.
- No default inbound security-group rules.
- Private subnet without a default Internet route.
- VPC Flow Logs with bounded retention.
- Terraform validation in CI.
- Secrets supplied outside source control.

## Residual risks

- Security groups do not replace host firewalls, IAM, patching or application authentication.
- Flow Logs are metadata, not full packet capture.
- Single-AZ subnet design is for a low-cost lab, not high availability.
- CloudWatch ingestion/storage and VPN resources may incur charges.
- Packet Tracer cannot establish a live AWS VPN.
- No live AWS deployment or Packet Tracer simulation was executed by this change.

Use a dedicated AWS sandbox, MFA, least-privilege IAM, reviewed plans and budgets. Never commit .tfstate, plan files, credentials, real PSKs or populated terraform.tfvars.
