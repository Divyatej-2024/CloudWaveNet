# CloudWaveNET

**Hybrid enterprise networking and cloud security lab**

CloudWaveNET demonstrates secure connectivity between two simulated branch offices and an AWS VPC. Packet Tracer models branch routing and a simulated ISP; Terraform provisions the cloud-side network and observability foundation.

> **Scope:** These are configuration templates and infrastructure definitions. A working Packet Tracer topology, live AWS deployment, VPN tunnel, and test pass must not be claimed until the artefact is supplied and tests are run. Packet Tracer's simulated Cloud object is not an AWS VPN endpoint.

## Architecture

- Branch A LAN: 192.168.10.0/24 (gateway 192.168.10.1)
- Branch B LAN: 192.168.20.0/24 (gateway 192.168.20.1)
- Packet Tracer WAN: RFC 5737 documentation ranges (see docs/topology.md)
- AWS: VPC, public/private subnets, Internet Gateway, route tables, restrictive security-group baseline and CloudWatch VPC Flow Logs
- Optional real VPN: Terraform can create AWS Site-to-Site VPN resources when given the real static public IP and BGP ASN of a compatible customer-gateway device. Packet Tracer itself cannot fulfil this role.

## Repository layout

- config/: Packet Tracer router, switch, AP and VPN templates
- docs/: architecture, address plan, security and testing guidance
- infra/aws/: Terraform AWS network and optional VPN resources
- reports/: test evidence and issue tracking
- simulation/: location for user-created .pkt files
- .github/workflows/: Terraform validation CI

## Packet Tracer quick start

1. Build the topology in docs/topology.md.
2. Apply matching branch router/switch templates, adjusting interface names for the selected device.
3. Configure APs with unique lab passphrases. Do not commit real credentials.
4. Configure IPsec only if the selected simulated router supports the commands.
5. Run docs/testing-plan.md and save actual evidence under reports/evidence/.

The Packet Tracer WAN ranges are documentation-only and must not be used as real public addresses.

## AWS Terraform quick start

Requirements: Terraform >= 1.5 and AWS credentials configured through a supported profile, environment variables or role.

```bash
cd infra/aws
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -check
terraform validate
terraform plan
```

Review the plan before applying. The default deployment creates a VPC foundation and VPC Flow Logs. It intentionally excludes NAT Gateway, compute instances and billable VPN resources by default.

To include AWS Site-to-Site VPN, set customer_gateway_ip to the real static public IP of a compatible on-premises VPN device. Review the plan; AWS VPN charges apply. Download the vendor-specific configuration from AWS after creation. Never use a Packet Tracer Cloud object as the real customer gateway.

```bash
terraform output
terraform destroy
```

Destroy only disposable lab resources after checking the active workspace.

## Security principles

- No committed passwords, PSKs, tokens or AWS credentials.
- Private subnet has no default Internet route.
- Security group has no inbound rules by default.
- Branch-to-branch traffic must be excluded from Internet NAT.
- Use IKEv2 and current vendor-recommended settings on real equipment; use AWS-generated configuration for the selected device.
- Use MFA and least-privilege IAM.
- Flow Logs contain network metadata; apply retention and access controls.

## Validation

GitHub Actions checks Terraform formatting and validation. This does not deploy AWS or prove connectivity. End-to-end tests require the actual Packet Tracer file, compatible edge equipment, AWS account and recorded evidence.

See docs/testing-plan.md, docs/hybrid-cloud-architecture.md and docs/security-analysis.md.

## Roadmap

1. Complete and capture Packet Tracer branch connectivity.
2. Validate Terraform in CI and deploy AWS baseline in a controlled account.
3. Integrate a compatible VPN appliance with AWS Site-to-Site VPN.
4. Add centralised alerting, drift checks and infrastructure security scanning.

## Licence

No licence is currently declared. Choose terms before inviting reuse.
