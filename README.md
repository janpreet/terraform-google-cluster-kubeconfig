# Terraform-GCP-Module
## Motivation
Use this module to create a GCP managed K8s cluster and generate the kubeconfig.

## Input vairables
#### Below variables are sensitive make sure you're either passing them using a Secret manager or TF Environment variables. These must never be published to version control system like Github- encrypted or not.
- username - Username for cluster
- password - Password for cluster
- project - GCP Project name
- region - GCP Region
- credentials - /path/to/GCP-Key-Json
- kubeconfig - /path/to/output/kubeconfig

## Usage
Example environment variables-
```bash
export TF_VAR_credentials=""
export TF_VAR_project=""
export TF_VAR_region=""
export TF_VAR_kubeconfig=""
export TF_CLI_CONFIG_FILE="/path/to/.terraformrc"
```
Example main.tf
```hcl
# Remote State
terraform {
  required_version = "~>0.12"
  backend "remote" {
    organization = ""
    workspaces {
      name = ""
    }
  }
}

# Random unique username and password
resource "random_id" "username" {
  byte_length = 14
}

resource "random_id" "password" {
  byte_length = 18
}

# Variables
variable "username" {}
variable "password" {}

# Cluster
module "gkecluster" {
    source = "janpreet/cluster-kubeconfig/google"
    username = random_id.username.hex
    password = random_id.password.hex
    project = var.project
    region = var.region
    credentials = var.credentials
    kubeconfig = var.kubeconfig 
}
```