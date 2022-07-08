#This script can be used to create resources groups in Azure


#Disable the caching of logged in user
Disable-AzContextAutosave


#Prompt user login
Connect-AzAccount

# Prompt user for the location and name
$rg_name  = Read-Host -Prompt 'Please enter the name of the resource group to be created'
$rg_location  = Read-Host -Prompt 'Please enter a location for your resource group'

if($rg_name -and $rg_location){
    New-AzResourceGroup -Name $rg_name -Location $rg_location
    Write-Host -ForegroundColor Green " $rg_name was created in $rg_location"
    
}
else{
    Write-Host -ForegroundColor Red " $rg_name could not be created"
}

