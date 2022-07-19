# Azure Virtual Machines
Azure Virtual Machines (VM) is one of several types of on-demand, scalable computing resources that Azure offers. Typically, you choose a VM when you need more control over the computing environment than the other choices offer. 

An Azure VM gives you the flexibility of virtualization without having to buy and maintain the physical hardware that runs it. However, you still need to maintain the VM by performing tasks, such as configuring, patching, and installing the software that runs on it.

There are always a multitude of design considerations when you build out an application infrastructure in Azure. These aspects of a VM are important to think about before you start:

- The names of your application resources
- The location where the resources are stored
- The size of the VM
- The maximum number of VMs that can be created
- The operating system that the VM runs
- The configuration of the VM after it starts
- The related resources that the VM needs

More information on Azure Virtual Machines can be found [here](https://docs.microsoft.com/en-us/azure/virtual-machines/)

## Creating a Basic Azure Virtual Machine
To create a basic VM you can run the below command. 
```New-AzVM -Name "vm_name"```

### Command Reference
1. [New-AzVM](https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvm)


The above command will create the VM with the default settings, however as an admin you may want to apply additional settings to your VM, the below sections define Azure VM creation in more detail


## Creating Azure Virtual Networks

Azure Virtual Network (VNet) is the fundamental building block for your private network in Azure. VNet enables many types of Azure resources, such as Azure Virtual Machines (VM), to securely communicate with each other, the internet, and on-premises networks. VNet is similar to a traditional network that you'd operate in your own data center, but brings with it additional benefits of Azure's infrastructure such as scale, availability, and isolation. Click [here](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)  for more information.

The below commands will create an Azure Virtual Network:

```
##Update the below variables
    $ResourceGroupName ="your_resource_group"
    $Location="your_location"

    $VirtualNetworkName="virtual_network_name"
    $VirtualNetworkAddressSpace="10.0.0.0/16"
    $SubnetName="Subnet_Name"
    $SubnetAddressSpace="10.0.0.0/24"

# Create a subnet configuration

    $Subnet=New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressSpace

# Create the virtual network

    $VirtualNetwork = New-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName -Location $Location -AddressPrefix $VirtualNetworkAddressSpace -Subnet $Subnet

# Display Virtual Network information

  $VirtualNetwork
``` 

### Command Reference
1. [New-AzVirtualNetworkSubnetConfig](https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetworksubnetconfig)

2. [New-AzVirtualNetwork](https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetwork)

## Creating a Virtual Network Interface

```
##Update the below variables
$ResourceGroupName ="your_resource_group"
$Location="your_location"
$VirtualNetworkName="virtual_network_name"
$SubnetName="Subnet_Name"

# Get the details of our virtual network
$VirtualNetwork=Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

# Get the details of the subnet
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork

# Create the network interface in the virtual network

$NetworkInterfaceName="app-interface"

$NetworkInterface = New-AzNetworkInterface -Name $NetworkInterfaceName `
-ResourceGroupName $ResourceGroupName -Location $Location `
-Subnet $Subnet

# Display the details of the network interface

$NetworkInterface

```

### Command Reference

1. [Get-AzVirtualNetwork](https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork)

2. [Get-AzVirtualNetworkSubnetConfig](https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig)

3. [New-AzNetworkInterface](https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface)


## Creating a public IP Address

```
    ##Update the below variables
    $ResourceGroupName ="your_resource_group"
    $Location="your_location"
    $VirtualNetworkName="virtual_network_name"
    $SubnetName="Subnet_Name"
    $NetworkInterfaceName="your_interface"

# Create the Public IP Address

    $PublicIPAddress = New-AzPublicIpAddress -Name $PublicIPAddressName -ResourceGroupName $ResourceGroupName -Location $Location -Sku "Standard" -AllocationMethod "Static"

# Get the details of our network interface

$NetworkInterface= Get-AzNetworkInterface -Name $NetworkInterfaceName -ResourceGroupName ResourceGroupName

# Get the IP Config details of the network interface
$IpConfig=Get-AzNetworkInterfaceIpConfig -NetworkInterface $NetworkInterface

# Set the Network Interface with the new Public IP Address
$NetworkInterface | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $PublicIPAddress -Name $IpConfig.Name

# Set the Network Interface with the new details
$NetworkInterface | Set-AzNetworkInterface


```

### Command Reference

1. [New-AzPublicIpAddress](https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress)

2. [Get-AzNetworkInterface](https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface)

3. [Get-AzNetworkInterfaceIpConfig](https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig)

4. [Set-AzNetworkInterfaceIpConfig](https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig)

5. [Set-AzNetworkInterface](https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig)

6. [Set-AzVirtualNetworkSubnetConfig](https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetworksubnetconfig)

7. [Set-AzVirtualNetwork](https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetwork)


## Creating Network Security Groups

```
##Update the below variables
    $ResourceGroupName ="your_resource_group"
    $Location="your_location"
    $NetworkSecurityGroupName="your_app-nsg"
    $VirtualNetworkName="your_app-network"
    $SubnetName="your_subnet_name_"
    $SubnetAddressSpace="10.0.0.0/24" 

# Define the Security Rule to create

    $SecurityRule1 = New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Description "Allow-RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

# Create the Network Security Group
    $NetworkSecurityGroup = New-AzNetworkSecurityGroup -Name $NetworkSecurityGroupName -ResourceGroupName $ResourceGroupName -Location $Location -SecurityRules $SecurityRule1

# Assign the network security group to the subnet in the virtual network
    $VirtualNetwork = Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

# Set the subnet with the configuration of the Network Security Group
    Set-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork -NetworkSecurityGroup $NetworkSecurityGroup -AddressPrefix $SubnetAddressSpace

# Update the Virtual Network accordingly

    $VirtualNetwork | Set-AzVirtualNetwork
```

### Command Reference

1. [New-AzNetworkSecurityRuleConfig](https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworksecurityruleconfig)

2. [New-AzNetworkSecurityGroup](https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworksecuritygroup)

3. [Get-AzVirtualNetwork](https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork)

4. [Set-AzVirtualNetworkSubnetConfig](https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetworksubnetconfig)

5. [Set-AzVirtualNetwork](https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetwork)


## Putting it all together
 In the above sections we looked at a number of different scripts for creating a VM, Virtual Networks, Network Interfaces etc. We will now combien the above commands to build a Virtual Machine

 ```
 ## Please update the below variables to reflect your requirements
    $ResourceGroupName ="your_rg"
    $Location="your_location"
    $VirtualNetworkName="network_name"
    $VirtualNetworkAddressSpace="10.0.0.0/16"
    $SubnetName="subnet_name"
    $SubnetAddressSpace="10.0.0.0/24"
    $NetworkInterfaceName="app-interface"
    $PublicIPAddressName="app-ip"
    $SKU = "Standard"
    $AllocationMethod = "Static"
    $NetworkSecurityGroupName = "app-nsg"
    $VirtualNetworkName = "app-network"
    $VmName="appvm"
    $VMSize = "Standard_DS2_v2"
    $UserName="user_namer"
    $Password="user_password"
    $PublisherName = "MicrosoftWindowsServer" 
    $Offer = "WindowsServer" 
    $Skus = "2019-Datacenter" 
    $Version = "latest"

# Create the subnet and the virtual network

    $Subnet=New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressSpace

# Creatwthe Virtual Network

    $VirtualNetwork = New-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName ResourceGroupName -Location $Location -AddressPrefix $VirtualNetworkAddressSpace -Subnet $Subnet

    $Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork

# Create the network interface    

    $NetworkInterface = New-AzNetworkInterface -Name $NetworkInterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -Subnet $Subnet

# Then crete the Public IP address   

    $PublicIPAddress = New-AzPublicIpAddress -Name $PublicIPAddressName -ResourceGroupName ResourceGroupName -Location $Location -Sku $SKU  -AllocationMethod  $AllocationMethod

    $IpConfig=Get-AzNetworkInterfaceIpConfig -NetworkInterface $NetworkInterface

    $NetworkInterface | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $PublicIPAddress -Name $IpConfig.Name

    $NetworkInterface | Set-AzNetworkInterface

# Create the Network Security Group

    $SecurityRule1=New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Description "Allow-RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix * SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

    

    $NetworkSecurityGroup=New-AzNetworkSecurityGroup -Name $NetworkSecurityGroupName  -ResourceGroupName $ResourceGroupName -Location $Location -SecurityRules $SecurityRule1

    $VirtualNetwork = Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

    Set-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork -NetworkSecurityGroup $NetworkSecurityGroup -AddressPrefix $SubnetAddressSpace

    $VirtualNetwork | Set-AzVirtualNetwork

# Create the Azure Virtual Machine
    $PasswordSecure=ConvertTo-SecureString -String $Password -AsPlainText -Force

    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserName,$PasswordSecure

    $NetworkInterface= Get-AzNetworkInterface -Name $NetworkInterfaceName -ResourceGroupName $ResourceGroupName

    $VmConfig=New-AzVMConfig -Name $VmName -VMSize $VMSize

    Set-AzVMOperatingSystem -VM $VmConfig -ComputerName $VmName -Credential $Credential -Windows

    Set-AzVMSourceImage -VM $VmConfig -PublisherName $PublisherName -Offer $Offer -Skus $Skus -Version $Version

    $Vm = Add-AzVMNetworkInterface -VM $VmConfig -Id $NetworkInterface.Id

    Set-AzVMBootDiagnostic -Disable -VM $Vm

    New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $Vm


 ```



## Adding a Data Disk
Depending on your requirements you may require additional storage for your VM, this can be done by adding a Data Disk as per the the below commands:
























[Back](ReadMe.md)