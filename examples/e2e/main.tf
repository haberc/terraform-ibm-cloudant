#####################################################
# Cloudant - End to End example
# Copyright 2021 IBM
#####################################################

provider "ibm" {
}

locals {
  parameters = {
    legacyCredentials = (var.legacy_credentials != null ? var.legacy_credentials : null)
  }
}

data "ibm_resource_group" "cloudant" {
  name = var.resource_group
}

module "cloudant-instance" {
  //Uncomment the following line to point the source to registry level
  //source = "terraform-ibm-modules/cloudant/ibm//modules/instance"

  source                 = "../../modules/instance"
  provision              = var.provision
  provision_resource_key = var.provision_resource_key

  instance_name     = var.instance_name
  resource_group_id = data.ibm_resource_group.cloudant.id
  plan              = var.plan
  region            = var.region
  service_endpoints = var.service_endpoints
  parameters        = local.parameters
  tags              = var.tags
  create_timeout    = var.create_timeout
  update_timeout    = var.update_timeout
  delete_timeout    = var.delete_timeout
  resource_key_name = var.resource_key_name
  role              = var.role
  resource_key_tags = var.resource_key_tags

  ###################
  # Service Policy
  ###################
  service_policy_provision = var.service_policy_provision
  service_name             = var.service_name
  description              = var.description
  roles                    = var.roles
}