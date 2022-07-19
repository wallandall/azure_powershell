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

## Creating a container and uploading a BLOB
````
    $AccountName = "account_name"
    $ResourceGroupName = "ResourceGroupName"
    #1 Create the container
    $ContainerName = "your_name"
    $StorageAccount = Get-AzStorageAccount -Name $AccountName -ResourceGroupName $ResourceGroupName
    New-AzStorageContainer -Name $ContainerName -Context $StorageAccount.Context -Permission Blob

    #2 Upload file
    $BlobObject =@{
        FileLocation="File_location"
        ObjectName="File_Name"
    }
    Set-AzStorageBlobContent -Context $StorageAccount.Context -Container $$ContainerName -File $BlobObject['FileLocation'] -Blob $BlobObject['ObjectName']
````
## Checking if a Storage Account exisits.
The below script checks if a storage account exisit before creating it as well as performs checks before creating a container. The script will additionaly handle errors if the storage account already exists or the container . Lastly the script will upload a blob to the defined container.

```
    $AccountName = "your_account_name"
    $AccountKind = "type of storage account eg StorageV2"
    $AccountSKU = "Standard_LRS"
    $ResourceGroupName = "resource_group"
    $Location = "your_location

  
# First we are checking for the existence of the storage account
# Always a good idea to initialize the variables that are going to be used

    $StorageAccount=$null
    if(Get-AzStorageAccount -Name $AccountName -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue)
    {
        'Storage Account already exists'
        $StorageAccount=Get-AzStorageAccount -Name $AccountName -ResourceGroupName $ResourceGroupName
    }
    else {

        'Creating the storage account'
        $StorageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName `
    -Location $Location -Kind $AccountKind -SkuName $AccountSKU

    }

    # Check for the existence of a container in the storage account
    $ContainerName="container_name"
    $Container=$null

    if(Get-AzStorageContainer -Name $ContainerName -Context $StorageAccount.Context -ErrorAction SilentlyContinue)
    {
        'Container already exists'
        $Container=Get-AzStorageContainer -Name $ContainerName -Context $StorageAccount.Context
    }
    else {
        'Creating the container'
        $Container=New-AzStorageContainer -Name $ContainerName -Context $StorageAccount.Context `
    -Permission Blob

    }

    # Upload Blob

    $BlobObject=@{
        FileLocation="sample.txt"
        ObjectName ="sample.txt"
    }


```
### Command Refference:

1. [Get-AzStorageAccount](https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount)

2. [New-AzStorageAccount](https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount)

3. [New-AzStorageContainer](https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer)

4. [Get-AzStorageContainer](https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer)

5. [Set-AzStorageBlobContent](https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent)

6. [Set-AzStorageBlobCont](https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent)

## Creating File Shares
Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol or Network File System (NFS) protocol. Azure Files file shares can be mounted concurrently by cloud or on-premises deployments. SMB Azure file shares are accessible from Windows, Linux, and macOS clients. NFS Azure Files shares are accessible from Linux or macOS clients. Additionally, SMB Azure file shares can be cached on Windows Servers with Azure File Sync for fast access near where the data is being used. [Read More](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-introduction)

[Back](ReadMe.md)