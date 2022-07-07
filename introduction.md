# What is PowerShell?
PowerShell is a cross-platform task automation solution made up of a command-line shell, a scripting language, and a configuration management framework. PowerShell runs on Windows, Linux, and macOS. Official PowerShell documentation can be found [here](https://docs.microsoft.com/en-us/powershell/scripting/overview)

Powershell can be used to manage and automate various systems such as M365, SharePoint, Exchange, Windows, SQL etc, however in this repository we will be focusing specifacly on Azure.

# Azure CLI vs Azure PowerShell
If your familiar with Azure, you have possibly used a command line tool such as ***Azure Cli or Azure PowerShell***. The benefit of using a scripting language is that you can standardise on processes, simplify repetative tasks and automate the management of your environment. There are a number of resources available comparing Azure Cli with Azure PowerShell so I will not go into dsetail here but this [article](https://docs.microsoft.com/en-us/azure/developer/azure-cli/choose-the-right-azure-command-line-tool) covers some of the basic differences between the two.

# Install Azure PowerShell
PowerShell can be installed on Windows, Linux and macOs but is installed on Windows by default. 
To check if PowerShell is installed on your system type the following command : ```$PSVersionTable```

The output should be similar to the below image:

![PowerShell Version](/img/psVersionTable.png)

If PowerShell is not installed, you can use this [link](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.2) to install it on your respective system

To installe the Azure PowerShell Module run the below steps:
1. Check that you have the ltest version of PowerShell by running : 
   1. ```$PSVersionTable.PSVersion```
2. Run the script for the execution policy, this policy helps prevent the execution of malicious scripts: 
   1. ```Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser ```
3. Install the Azure PowerShell Module: 
   1. ```Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force```
4. To check all installed modules, run :
   1. ```Get-InstalledModule```

Detailed information on Installing Azure PowerShell can be found [here](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps)

# cmdlets (PowerShell Commands)
Commands in PowerShell are know as cmdlets and use a ***Verb-Noun*** pair, for example  ```Get-Command```. Where the verb defines the action that the cmdlet will perform, ***Get***, and the Noun identifies the resource that the action will be performed on , ***Command***. 

Cmdlets are group int modules called PowerShell Modules. Only the default Modules are installed with PowerShell, however additional modules can be installed and loaded as required. For example, you cannot use PowerShell to communicate with Azure untill the Azure Module has been installed and loadded into your script.

To list all installed modules run: ```Get-InstalledModule```

Cmdlets can be run from your Terminal Window as mentioned above or saved to a file with a ***.ps1*** file extension. the benefit of storing your comandlets in a file, is that you can run your scripts multiple times wihout having to re-create them.

# Variables 
Variables are placeholders for data and in PowerShell you can define variables by using the *** $ *** sign and variable name, for example ```$region="Frankfurt"``` 

You can store any type of object in a variable, including integers, strings, arrays, and hash tables. And, objects that represent processes, services, event logs, and computers.

PowerShell variables are loosely typed, which means that they aren't limited to a particular type of object. A single variable can even contain a collection, or array, of different types of objects at the same time.

```
$a = 12                         # System.Int32
$a = "Word"                     # System.String
$a = 12, "Word"                 # array of System.Int32, System.String
$a = Get-ChildItem C:\Windows   # FileInfo and DirectoryInfo types
```

Variable names begin with a dollar ($) sign and can include alphanumeric characters and special characters. The variable name length is limited only by available memory.

The best practice is that variable names include only alphanumeric characters and the underscore (_) character. Variable names that include spaces and other special characters, are difficult to use and should be avoided.

# Arrays,  Hashtables and Objects

Arrays, Hashtables and Objects are supported by PowerShell to define a collection of values.
 Arrays can be defined by assigning multiple values to a variable for example: ``` $regions = "Germany","France", "Netherlands", "Ireland" ``` 

Array values can be accessed, edited or deleted by selecting the respective position from 0-n in the array. For example to select ***France*** in the above array, position ****1*** :
```$regions[1]```

to change the value of the data stored in the regions array:

```$regions[1]=Northern Europe"```


More Information on arrays can be found [here](https://docs.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-09)

PowerShell hash tables are data structures that store one or more key-value pairs. Hash tables are efficient for finding and retrieving data. You use hash tables to store lists of information or to create calculated properties.

For example a hashtabled called Servers lists server names for Development, Testing and Production.

Hashtables are defined using the ***@*** sign, foillowed by ***{}***. Inside the ***{}*** ***Key Value Pairs*** are defined. Has tables have various methods that can be used to perform actions on the hashtable, eg Add(), Remove() etc

```
$Servers=@{
    Development='Dev1'
    Testing='Test1' 
    Production='Prod1'
}
```

To access the value of an item in the Hastable we can reference the key for example: ```$Servers['Testing']``` or ```$Servers.Testing``` will output ***Test1***

More information on Hashtables can be found [here](https://docs.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-10)

Everything in PowerShell is done in the context of an ___Object___ .  Objects are a collection of data representing an item and have data types like the object type, methods, and properties.
Objects differ from hash tables in that the object represents an entity. Hash table items only represent each Key Value Pair. While the hash table is technically an object, it is limited in functionality and unsuitable for representing anything of structure.


Creating a custom PowerShell object makes the data more usable and displays the data more clearly. Custom objects are better for creating structured data. Custom object are defined using the ```[PSCustomObject]@{}``` keyword for example:

```
$ServeObject = [PSCustomObject]@{
    "Name"       = Test1"
    "ServiceTag" = "51ABC84"
    "Vendor"     = "Dell"
    "Model"      = "PowerEdge"
}
```

# Statements

PowerShell uses statements to build logic into your PowerShell Scripts.

More Information of PowerShell Statements can be found [here](https://docs.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-08)




[Back](ReadMe.MD)
