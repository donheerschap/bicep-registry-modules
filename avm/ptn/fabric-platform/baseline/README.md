# Fabric Platform Baseline `[FabricPlatform/Baseline]`

Resource to have WAF-Aligned Baseline for Fabric Platform



## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Data Collection](#Data-Collection)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/locks` | [2020-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-05-01/locks) |
| `Microsoft.Authorization/roleAssignments` | [2022-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2022-04-01/roleAssignments) |
| `Microsoft.Automanage/configurationProfileAssignments` | [2022-05-04](https://learn.microsoft.com/en-us/azure/templates) |
| `Microsoft.Compute/virtualMachines` | [2023-09-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Compute/2023-09-01/virtualMachines) |
| `Microsoft.Compute/virtualMachines/extensions` | [2022-11-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Compute/2022-11-01/virtualMachines/extensions) |
| `Microsoft.DevTestLab/schedules` | [2018-09-15](https://learn.microsoft.com/en-us/azure/templates/Microsoft.DevTestLab/2018-09-15/schedules) |
| `Microsoft.GuestConfiguration/guestConfigurationAssignments` | [2020-06-25](https://learn.microsoft.com/en-us/azure/templates/Microsoft.GuestConfiguration/2020-06-25/guestConfigurationAssignments) |
| `Microsoft.Insights/diagnosticSettings` | [2021-05-01-preview](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Insights/2021-05-01-preview/diagnosticSettings) |
| `Microsoft.KeyVault/vaults` | [2022-07-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.KeyVault/2022-07-01/vaults) |
| `Microsoft.KeyVault/vaults/accessPolicies` | [2022-07-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.KeyVault/2022-07-01/vaults/accessPolicies) |
| `Microsoft.KeyVault/vaults/keys` | [2022-07-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.KeyVault/2022-07-01/vaults/keys) |
| `Microsoft.KeyVault/vaults/secrets` | [2022-07-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.KeyVault/2022-07-01/vaults/secrets) |
| `Microsoft.Maintenance/configurationAssignments` | [2023-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Maintenance/2023-04-01/configurationAssignments) |
| `Microsoft.Network/bastionHosts` | [2022-11-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2022-11-01/bastionHosts) |
| `Microsoft.Network/networkInterfaces` | [2023-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2023-04-01/networkInterfaces) |
| `Microsoft.Network/networkSecurityGroups` | [2023-11-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2023-11-01/networkSecurityGroups) |
| `Microsoft.Network/privateDnsZones` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones) |
| `Microsoft.Network/privateDnsZones/A` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones/A) |
| `Microsoft.Network/privateDnsZones/AAAA` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones/AAAA) |
| `Microsoft.Network/privateDnsZones/CNAME` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones/CNAME) |
| `Microsoft.Network/privateDnsZones/MX` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones/MX) |
| `Microsoft.Network/privateDnsZones/PTR` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones/PTR) |
| `Microsoft.Network/privateDnsZones/SOA` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones/SOA) |
| `Microsoft.Network/privateDnsZones/SRV` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones/SRV) |
| `Microsoft.Network/privateDnsZones/TXT` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones/TXT) |
| `Microsoft.Network/privateDnsZones/virtualNetworkLinks` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZones/virtualNetworkLinks) |
| `Microsoft.Network/privateEndpoints` | [2023-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2023-04-01/privateEndpoints) |
| `Microsoft.Network/privateEndpoints/privateDnsZoneGroups` | [2023-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2023-04-01/privateEndpoints/privateDnsZoneGroups) |
| `Microsoft.Network/publicIPAddresses` | [2023-09-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2023-09-01/publicIPAddresses) |
| `Microsoft.Network/virtualNetworks` | [2024-01-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/virtualNetworks) |
| `Microsoft.Network/virtualNetworks/subnets` | [2024-01-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/virtualNetworks/subnets) |
| `Microsoft.Network/virtualNetworks/virtualNetworkPeerings` | [2024-01-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/virtualNetworks/virtualNetworkPeerings) |
| `Microsoft.OperationalInsights/workspaces` | [2023-09-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.OperationalInsights/2023-09-01/workspaces) |
| `Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems` | [2023-01-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.RecoveryServices/2023-01-01/vaults/backupFabrics/protectionContainers/protectedItems) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br/public:avm/ptn/fabric-platform/baseline:<version>`.

- [Using only defaults](#example-1-using-only-defaults)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module baseline 'br/public:avm/ptn/fabric-platform/baseline:<version>' = {
  name: 'baselineDeployment'
  params: {
    // Required parameters
    name: '<name>'
    // Non-required parameters
    virtualMachineConfiguration: {
      adminPassword: '<adminPassword>'
      adminUsername: 'localAdminUser'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "<name>"
    },
    // Non-required parameters
    "virtualMachineConfiguration": {
      "value": {
        "adminPassword": "<adminPassword>",
        "adminUsername": "localAdminUser"
      }
    }
  }
}
```

</details>
<p>

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-name) | string | Alphanumberic suffix to use for resource naming. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`bastionConfiguration`](#parameter-bastionconfiguration) | object | Configuration for the Azure Bastion host. |
| [`enableTelemetry`](#parameter-enabletelemetry) | bool | Enable/Disable usage telemetry for module. |
| [`keyVaultConfiguration`](#parameter-keyvaultconfiguration) | object | Configuration for the key vault. |
| [`location`](#parameter-location) | string | Location for all Resources. |
| [`logAnalyticsConfiguration`](#parameter-loganalyticsconfiguration) | object | Configuration for the Log Analytics workspace. |
| [`managedIdentityName`](#parameter-managedidentityname) | string | The name of the user assigned identity for the AI Studio hub. If not provided, the hub will use a system assigned identity. |
| [`tags`](#parameter-tags) | object | Resource tags. |
| [`virtualMachineConfiguration`](#parameter-virtualmachineconfiguration) | secureObject | Configuration for the virtual machine. |
| [`virtualNetworkConfiguration`](#parameter-virtualnetworkconfiguration) | object | Configuration for the virtual network. |

### Parameter: `name`

Alphanumberic suffix to use for resource naming.

- Required: Yes
- Type: string

### Parameter: `bastionConfiguration`

Configuration for the Azure Bastion host.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`disableCopyPaste`](#parameter-bastionconfigurationdisablecopypaste) | bool | Choose to disable or enable Copy Paste. |
| [`enabled`](#parameter-bastionconfigurationenabled) | bool | Whether to create a Bastion host in the virtual network. Defaults to 'true'. |
| [`enableFileCopy`](#parameter-bastionconfigurationenablefilecopy) | bool | Choose to disable or enable File Copy. |
| [`enableIpConnect`](#parameter-bastionconfigurationenableipconnect) | bool | Choose to disable or enable IP Connect. |
| [`enableKerberos`](#parameter-bastionconfigurationenablekerberos) | bool | Choose to disable or enable Kerberos authentication. |
| [`enableShareableLink`](#parameter-bastionconfigurationenableshareablelink) | bool | Choose to disable or enable Shareable Link. |
| [`name`](#parameter-bastionconfigurationname) | string | The name of the Bastion host to create. |
| [`networkSecurityGroupResourceId`](#parameter-bastionconfigurationnetworksecuritygroupresourceid) | string | The resource ID of an existing network security group to associate with the Azure Bastion subnet. |
| [`scaleUnits`](#parameter-bastionconfigurationscaleunits) | int | The scale units for the Bastion Host resource. |
| [`sku`](#parameter-bastionconfigurationsku) | string | The SKU of the Bastion host to create. |
| [`subnetAddressPrefix`](#parameter-bastionconfigurationsubnetaddressprefix) | string | The address prefix of the Azure Bastion subnet. |

### Parameter: `bastionConfiguration.disableCopyPaste`

Choose to disable or enable Copy Paste.

- Required: No
- Type: bool

### Parameter: `bastionConfiguration.enabled`

Whether to create a Bastion host in the virtual network. Defaults to 'true'.

- Required: No
- Type: bool

### Parameter: `bastionConfiguration.enableFileCopy`

Choose to disable or enable File Copy.

- Required: No
- Type: bool

### Parameter: `bastionConfiguration.enableIpConnect`

Choose to disable or enable IP Connect.

- Required: No
- Type: bool

### Parameter: `bastionConfiguration.enableKerberos`

Choose to disable or enable Kerberos authentication.

- Required: No
- Type: bool

### Parameter: `bastionConfiguration.enableShareableLink`

Choose to disable or enable Shareable Link.

- Required: No
- Type: bool

### Parameter: `bastionConfiguration.name`

The name of the Bastion host to create.

- Required: No
- Type: string

### Parameter: `bastionConfiguration.networkSecurityGroupResourceId`

The resource ID of an existing network security group to associate with the Azure Bastion subnet.

- Required: No
- Type: string

### Parameter: `bastionConfiguration.scaleUnits`

The scale units for the Bastion Host resource.

- Required: No
- Type: int

### Parameter: `bastionConfiguration.sku`

The SKU of the Bastion host to create.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Basic'
    'Standard'
  ]
  ```

### Parameter: `bastionConfiguration.subnetAddressPrefix`

The address prefix of the Azure Bastion subnet.

- Required: No
- Type: string

### Parameter: `enableTelemetry`

Enable/Disable usage telemetry for module.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `keyVaultConfiguration`

Configuration for the key vault.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`enablePurgeProtection`](#parameter-keyvaultconfigurationenablepurgeprotection) | bool | Provide 'true' to enable Key Vault's purge protection feature. Defaults to 'true'. |
| [`name`](#parameter-keyvaultconfigurationname) | string | The name of the key vault. |

### Parameter: `keyVaultConfiguration.enablePurgeProtection`

Provide 'true' to enable Key Vault's purge protection feature. Defaults to 'true'.

- Required: No
- Type: bool

### Parameter: `keyVaultConfiguration.name`

The name of the key vault.

- Required: No
- Type: string

### Parameter: `location`

Location for all Resources.

- Required: No
- Type: string
- Default: `[resourceGroup().location]`

### Parameter: `logAnalyticsConfiguration`

Configuration for the Log Analytics workspace.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-loganalyticsconfigurationname) | string | The name of the Log Analytics workspace. |

### Parameter: `logAnalyticsConfiguration.name`

The name of the Log Analytics workspace.

- Required: No
- Type: string

### Parameter: `managedIdentityName`

The name of the user assigned identity for the AI Studio hub. If not provided, the hub will use a system assigned identity.

- Required: No
- Type: string

### Parameter: `tags`

Resource tags.

- Required: No
- Type: object

### Parameter: `virtualMachineConfiguration`

Configuration for the virtual machine.

- Required: No
- Type: secureObject

### Parameter: `virtualNetworkConfiguration`

Configuration for the virtual network.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`addressPrefix`](#parameter-virtualnetworkconfigurationaddressprefix) | string | The address prefix of the virtual network to create. |
| [`enabled`](#parameter-virtualnetworkconfigurationenabled) | bool | Whether to create an associated virtual network. Defaults to 'true'. |
| [`name`](#parameter-virtualnetworkconfigurationname) | string | The name of the virtual network to create. |
| [`subnet`](#parameter-virtualnetworkconfigurationsubnet) | object | Configuration for the virual network subnet. |

### Parameter: `virtualNetworkConfiguration.addressPrefix`

The address prefix of the virtual network to create.

- Required: No
- Type: string

### Parameter: `virtualNetworkConfiguration.enabled`

Whether to create an associated virtual network. Defaults to 'true'.

- Required: No
- Type: bool

### Parameter: `virtualNetworkConfiguration.name`

The name of the virtual network to create.

- Required: No
- Type: string

### Parameter: `virtualNetworkConfiguration.subnet`

Configuration for the virual network subnet.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`addressPrefix`](#parameter-virtualnetworkconfigurationsubnetaddressprefix) | string | The address prefix of the subnet to create. |
| [`name`](#parameter-virtualnetworkconfigurationsubnetname) | string | The name of the subnet to create. |
| [`networkSecurityGroupResourceId`](#parameter-virtualnetworkconfigurationsubnetnetworksecuritygroupresourceid) | string | The resource ID of an existing network security group to associate with the subnet. |

### Parameter: `virtualNetworkConfiguration.subnet.addressPrefix`

The address prefix of the subnet to create.

- Required: No
- Type: string

### Parameter: `virtualNetworkConfiguration.subnet.name`

The name of the subnet to create.

- Required: No
- Type: string

### Parameter: `virtualNetworkConfiguration.subnet.networkSecurityGroupResourceId`

The resource ID of an existing network security group to associate with the subnet.

- Required: No
- Type: string

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `bastionName` | string | The name of the Azure Bastion host. |
| `bastionResourceId` | string | The resource ID of the Azure Bastion host. |
| `keyVaultName` | string | The name of the key vault. |
| `keyVaultResourceId` | string | The resource ID of the key vault. |
| `keyVaultUri` | string | The URI of the key vault. |
| `location` | string | The location the module was deployed to. |
| `logAnalyticsWorkspaceName` | string | The name of the log analytics workspace. |
| `logAnalyticsWorkspaceResourceId` | string | The resource ID of the log analytics workspace. |
| `resourceGroupName` | string | The name of the resource group the module was deployed to. |
| `virtualMachineName` | string | The name of the virtual machine. |
| `virtualMachineResourceId` | string | The resource ID of the virtual machine. |
| `virtualNetworkName` | string | The name of the virtual network. |
| `virtualNetworkResourceId` | string | The resource ID of the virtual network. |
| `virtualNetworkSubnetName` | string | The name of the subnet in the virtual network. |
| `virtualNetworkSubnetResourceId` | string | The resource ID of the subnet in the virtual network. |

## Cross-referenced modules

This section gives you an overview of all local-referenced module files (i.e., other modules that are referenced in this module) and all remote-referenced files (i.e., Bicep modules that are referenced from a Bicep Registry or Template Specs).

| Reference | Type |
| :-- | :-- |
| `br/public:avm/res/compute/virtual-machine:0.5.3` | Remote reference |
| `br/public:avm/res/key-vault/vault:0.6.2` | Remote reference |
| `br/public:avm/res/network/bastion-host:0.2.2` | Remote reference |
| `br/public:avm/res/network/network-security-group:0.3.1` | Remote reference |
| `br/public:avm/res/network/private-dns-zone:0.3.1` | Remote reference |
| `br/public:avm/res/network/virtual-network:0.4.0` | Remote reference |

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the [repository](https://aka.ms/avm/telemetry). There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
