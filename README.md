# Terraform-IaC-Project

This is a terraform infrasturcture automation project for Azure Cloud. 
Each of the modules connect to different resources we create in Azure. The ones that are planned are as follows: 

Azure Kubernetes Service 

Application Insights 

Aplication Gateway 

Storage account (blob and fileshares) 

Cosmos db (nosql) 

Linux Function app 

Key vault 

Redis cache 

Service bus 

 

The environments configured to be created are as follows: 

DEV 

QA 

QA1 

UAT 

PERF 

PROD 

 

We are using a build and release pipeline for the initial configuration/deployment. For the requirements that involve individually targeting a resource and change the configuration without affecting other resources, we will use individual separate CD pipelines. 

 

CI pipelines consist of taking inputs from the user about the environment they would like to create, replace the variables in terraform.tfvars, and copy all TF files into the artifact. 

CD pipelines involves task for terraform tool installation, terraform init, terraform plan and terraform apply. 

For individual resources, process is same but there is additional arguments section filled in the format “-target=module.module_name_in main.resource_name” in order to only plan and deploy that particular module/resource. 

 
