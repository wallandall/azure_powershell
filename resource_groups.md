# Azure Resource Groups

A resource group is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group. You decide how you want to allocate resources to resource groups based on what makes the most sense for your organization. 

To create a new Resource Group with Azure PowerShell you can use the [New-AzResourceGroup](https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup) command

e.g: 
```
    $rg_name = "test-gp"
    $rg_location = "North Europe"
    New -AzResourceGroup -Name $rg_name -Location $rg_location
```



To get all resource groups run [Get-AzResourceGroup](https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup) command

e.g: Get all resource groups and print the Name, Location and ID

```
$AllResourceGroups = Get-AzResourceGroup
$Counter = 0
foreach($Group in $AllResourceGroups){
    $Counter++
    Write-Host -ForegroundColor Green "Group: $Counter "
    Write-Host -ForegroundColor Blue 'Name     :'  $Group.ResourceGroupName
    Write-Host -ForegroundColor Blue 'Location :'  $Group.Location
    Write-Host -ForegroundColor Blue 'ID       : '  $Group.ResourceId
    Write-Host 

}
```

To remove a resource group with Azure Powershel use the [Remove-AzResourceGroup](https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup) command.

e.g:  Delete a resource group and return the state
```
   
    $rg_name = "test-rg"
    $ResourceGroup= Remove-AzResourceGroup $rg_name -Force
    'Provisioning State' + $ResourceGroup.ProvisioningState
```

e.g.: Delete all resource groups

```
$AllResourceGroups = Get-AzResourceGroup
foreach($Group in $AllResourceGroups){
     Write-Host -ForegroundColor Red 'Removing Resource Group ' $Group.ResourceGroupName
    Remove-AzResourceGroup -Name $Group.ResourceGroupName -Force
}
```

[back](ReadMe.md)