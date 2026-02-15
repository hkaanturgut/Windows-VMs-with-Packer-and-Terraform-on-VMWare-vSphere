
# Build and Deploy Windows VMs on vSphere with Packer & Terraform

This project provides a complete, automated workflow to build Windows Server VM templates using Packer and deploy them on VMware vSphere using Terraform. It includes ready-to-use GitHub Actions workflows for CI/CD automation.

## Video Demo

[![Watch the video](https://img.youtube.com/vi/3eEXcE1Ndb0/maxresdefault.jpg)](https://www.youtube.com/watch?v=3eEXcE1Ndb0))

For more content, visit my YouTube channel: [https://www.youtube.com/@hkaanturgut)

---

## Table of Contents
1. [Project Structure](#project-structure)
2. [Prerequisites](#prerequisites)
3. [Packer: Build Windows Template](#packer-build-windows-template)
4. [Terraform: Deploy Windows VM](#terraform-deploy-windows-vm)
5. [GitHub Actions Automation](#github-actions-automation)
6. [Customization](#customization)
7. [Troubleshooting](#troubleshooting)

---

## 1. Project Structure

```
.
├── packer-vsphere/windows/         # Packer templates, scripts, and answer files
│   ├── windows2022.pkr.hcl         # Main Packer HCL template
│   ├── windows2022.auto.pkrvars.hcl# Packer variables for Windows 2022
│   ├── autounattend.xml            # Windows unattended setup file
│   └── scripts/                    # Windows setup scripts
├── windows_vms.tf                  # Terraform VM resource definition
├── data.tf                         # Terraform data sources for vSphere
├── provider.tf                     # Terraform provider config
├── variables.tf                    # Terraform input variables
├── .github/workflows/              # GitHub Actions workflows
│   ├── packer-build-windows.yml    # Packer build workflow
│   └── terraform-windows.yml       # Terraform deploy workflow
└── README.md                       # This documentation
```

---

## 2. Prerequisites

- Access to a VMware vSphere environment (vCenter, Datastore, Cluster, Network)
- [Packer](https://www.packer.io/downloads) v1.6.x or later (for local builds)
- [Terraform](https://www.terraform.io/downloads.html) v1.6.x or later (for local deploys)
- GitHub repository secrets set for:
	- `VSPHERE_USER`, `VSPHERE_PASSWORD`, `VSPHERE_SERVER`
	- `WINDOWS_ADMIN_USERNAME`, `WINDOWS_ADMIN_PASSWORD`
	- `TF_API_TOKEN` (for Terraform Cloud, if used)

---

## 3. Packer: Build Windows Template

### 3.1. Configure Variables
Edit `packer-vsphere/windows/windows2022.auto.pkrvars.hcl` to match your vSphere environment (datacenter, cluster, network, datastore, ISO path, etc).

### 3.2. Build Locally (Optional)
```sh
packer init packer-vsphere/windows/windows2022.pkr.hcl
packer build -force -var-file=packer-vsphere/windows/windows2022.auto.pkrvars.hcl \
	-var "vsphere-user=YOUR_USER" \
	-var "vsphere-password=YOUR_PASS" \
	-var "vsphere-server=YOUR_SERVER" \
	-var "winadmin-password=YOUR_WINADMIN_PASS" \
	packer-vsphere/windows/windows2022.pkr.hcl
```

### 3.3. Build with GitHub Actions
1. Go to the **Actions** tab in your GitHub repo.
2. Run the **Build and Deploy Packer Image** workflow.
3. Select `windows-2022` as the OS type.
4. Monitor the build logs for progress and errors.

---

## 4. Terraform: Deploy Windows VM

### 4.1. Configure Variables
Edit `variables.tf` and `windows_vms.tf` as needed for your vSphere environment and VM specs.

### 4.2. Deploy Locally (Optional)
```sh
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

### 4.3. Deploy with GitHub Actions
1. Go to the **Actions** tab in your GitHub repo.
2. Run the **Terraform vSphere Deploy (Windows)** workflow.
3. Set `run_apply` to `true` if you want to apply changes automatically.
4. Review the plan and outputs in the workflow logs.

---

## 5. GitHub Actions Automation

- **.github/workflows/packer-build-windows.yml**: Builds the Windows template using Packer on a self-hosted Windows runner.
- **.github/workflows/terraform-windows.yml**: Provisions the VM using Terraform on a self-hosted Windows runner.

### Required Repository Secrets
Set these in your GitHub repository settings:
| Secret Name              | Description                       |
|--------------------------|-----------------------------------|
| VSPHERE_USER             | vSphere username                  |
| VSPHERE_PASSWORD         | vSphere password                  |
| VSPHERE_SERVER           | vCenter server address            |
| WINDOWS_ADMIN_USERNAME   | Windows admin username            |
| WINDOWS_ADMIN_PASSWORD   | Windows admin password            |
| TF_API_TOKEN             | Terraform Cloud API token (if used)|

---

## 6. Customization

- **Packer**: Edit `windows2022.pkr.hcl`, `autounattend.xml`, and scripts in `packer-vsphere/windows/scripts/` to customize the Windows image.
- **Terraform**: Edit `windows_vms.tf`, `variables.tf`, and `data.tf` to change VM specs, networking, and resource mapping.

---

## 7. Troubleshooting

- Ensure all required secrets are set in GitHub.
- Check that your self-hosted Windows runner is online and has Packer/Terraform installed.
- Review workflow logs for detailed error messages.
- Validate your vSphere credentials and network access.
- For local runs, ensure you have the correct versions of Packer and Terraform.

---

## License

See [LICENSE](LICENSE).
