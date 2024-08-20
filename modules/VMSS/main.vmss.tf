data "azurerm_client_config" "config" {}
data "azurerm_resource_group" "rg" {
  name = "ams-${var.environment}"
}
data "azurerm_kubernetes_cluster" "aks" {
  name = "aks-ams-${var.environment}"
  resource_group_name = "ams-${var.environment}"
  depends_on = [data.azurerm_resource_group.rg]
}
data "azurerm_resources" "vmss" {
  type = "Microsoft.Compute/virtualMachineScaleSets"
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  depends_on = [ data.azurerm_kubernetes_cluster.aks ]
}
resource "null_resource" "PowerShellScriptRunFirstTimeOnly" {
    provisioner "local-exec" {
      interpreter = ["PowerShell", "-Command"]
      
      command = <<-EOT
      Install-Module Az -Force
      Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

      Invoke-Command -ScriptBlock { 
      az login --service-principal --username ${var.client_id} --password ${var.client_secret} --tenant ${var.tenant_id}
      $aks_rg = az aks show --resource-group ${var.resource_group_name} --name  ${var.AKS_name} --query nodeResourceGroup -o tsv
      $vmss = az vmss list -g $aks_rg --query [0].name
      $num = az vmss identity show --name $vmss --resource-group $aks_rg --query 'principalId'
      if ($num){
          $num = az vmss identity show --name $vmss --resource-group $aks_rg --query 'principalId'
          $num
      }
      if(!$num){
      az vmss identity assign -g $aks_rg -n $vmss --role Owner --scope "/subscriptions/${var.subscription_id}/resourceGroups/$aks_rg"
      $num = az vmss identity show --name $vmss --resource-group $aks_rg --query 'principalId'
      az keyvault set-policy --name ${var.kv_name} --object-id $num --secret-permissions all
      }
      }
      EOT  
    }
    depends_on = [data.azurerm_kubernetes_cluster.aks]
}