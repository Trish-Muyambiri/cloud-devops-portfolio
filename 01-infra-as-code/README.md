# Infrastructure as Code — Terraform Portfolio

This folder contains reusable Terraform modules for AWS infrastructure, along with example configurations to demonstrate usage. Each module is built with clarity, reusability, and real-world use in mind.

---

## Module: VPC

### Description  
A minimal VPC module that allows you to provision a Virtual Private Cloud with configurable CIDR blocks and tags. Designed for use across environments (dev, staging, prod).

### Module Path  
`modules/vpc/`

### Inputs

| Variable     | Type   | Description                | Example           |
|--------------|--------|----------------------------|-------------------|
| `cidr_block` | string | CIDR block for the VPC     | `"10.0.0.0/16"`   |
| `name`       | string | Name tag for the VPC       | `"dev-vpc"`       |

### Outputs

| Output   | Description             |
|----------|-------------------------|
| `vpc_id` | The ID of the created VPC |

---

## Example: Basic VPC Deployment

The `examples/vpc-basic/` folder demonstrates how to use the VPC module with simple input values.

### How to Use

```bash
cd examples/vpc-basic

# Initialize Terraform
terraform init

# Preview what will be created
terraform plan

# Apply the configuration
terraform apply
```

> ⚠️ Make sure your AWS credentials are configured (`~/.aws/credentials` or environment variables).

---

## Structure

```
01-infra-as-code/
├── modules/
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── examples/
    └── vpc-basic/
        └── main.tf
```

---

## Coming Next

- Subnet module  
- EC2 module  
- Full networking setup (VPC + Subnets + IGW + Routes)  
- CI/CD integration with GitHub Actions

---

## Author

Patricia Muyambiri  
Cloud & DevOps Portfolio | 2025

