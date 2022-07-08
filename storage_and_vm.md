# Managing Azure Storage Accounts and Virtual Machines with PowerShell

## Azure Storage Accounts
An Azure storage account contains all of your Azure Storage data objects, including blobs, file shares, queues, tables, and disks. The storage account provides a unique namespace for your Azure Storage data that's accessible from anywhere in the world over HTTP or HTTPS. Data in your storage account is durable and highly available, secure, and massively scalable.

To create a storage account use the [New-AzStorageAccount](https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount) command 

e.g.: Create a storage account
```
    #This must be a globaly unique name
    $AccountName = "Store01mdjjejje12"
    $AccountKind = "StorageV2
    $AccountSKU ="Standard_LRS"
    $ResourceGroupName = "Test1"
    $Location = "North Europe"

    $StorageAccount =New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName -Location $Location -Kind $AccountKind -SkuName $AccountSKU

    $StorageAccount 

```

[Back](ReadMe.md)