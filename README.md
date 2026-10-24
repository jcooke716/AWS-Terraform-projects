# AWS Network Foundation with Terraform

A Terraform networking lab that lays out public, application, and data subnets across two Availability Zones. Its focus is the network foundation that application and database workloads would later use.

## Problem and approach

Cloud workloads need clearly separated network locations before compute or database resources are added. This project expresses that layout in Terraform so CIDR ranges, Availability Zones, gateways, and routing can be reviewed together.

## Resources defined

- One VPC with DNS hostnames enabled.
- Two public subnets, two private application subnets, and two private data subnets.
- An internet gateway and a public route table with both public subnet associations.
- Two Elastic IPs and two NAT gateway resources.

The default region is `us-west-2`, with subnets in `us-west-2a` and `us-west-2b`. The VPC CIDR defaults to `10.0.0.0/16`, divided into six /24 subnet ranges.

## Files

| File | Purpose |
| --- | --- |
| [main.tf](main.tf) | AWS provider and networking resources. |
| [variableas.tf](variableas.tf) | Region, Availability Zones, VPC input, and subnet CIDR variables. |

## Review and configuration

```bash
terraform init -backend=false
terraform validate
terraform fmt -check
```

Before using the configuration against AWS:

- Resolve `var.dev_vpc_id`: its default is the literal string `aws_vpc.dev_vpc.id`, not an evaluated reference to the VPC resource.
- Use one internet-gateway attachment approach. The configuration currently sets `vpc_id` on the gateway and also declares a separate attachment resource.
- Add private route tables and associations before expecting the private subnets to use the NAT gateways. Those routes are not currently defined.

## Portfolio focus and status

This is an AWS networking implementation exercise, with configuration work remaining before deployment. It contains no EC2, load balancer, RDS, or application resources. Its distinct focus is subnet design, gateway placement, public routing, and Terraform reference relationships.
