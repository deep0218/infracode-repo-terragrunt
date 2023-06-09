locals {
    terraform_config = read_terragrunt_config(find_in_parent_folders("terraform_config.hcl"))
    tag = local.terraform_config.locals.tag
    environment = "staging"
    #Environment configuration
    environment_specific_config = read_terragrunt_config(find_in_parent_folders("environment_specific.hcl"))
    environment = local.environment_specific_config.locals.environment
    token = local.environment_specific_config.locals.civotoken
}

terraform {
    source = "git::git@github.com:cloud-native-skunkworks/cnskunkworks-terraform.git//civo?=ref=$(local.tag)"
}

inputs = {
    civotoken = local.token
    cluster_name = "clustername"
}