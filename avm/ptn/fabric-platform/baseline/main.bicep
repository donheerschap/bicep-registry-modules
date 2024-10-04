metadata name = 'AI Platform Baseline'
metadata description = '''This module provides a secure and scalable environment for deploying AI applications on Azure.
The module encompasses all essential components required for building, managing, and observing AI solutions, including a machine learning workspace, observability tools, and necessary data management services.
By integrating with Microsoft Entra ID for secure identity management and utilizing private endpoints for services like Key Vault and Blob Storage, the module ensures secure communication and data access.'''
metadata owner = 'Azure/module-maintainers'

@description('Required. Alphanumberic suffix to use for resource naming.')
@minLength(3)
param name string

@description('Optional. Location for all Resources.')
param location string = resourceGroup().location

@description('Optional. Resource tags.')
param tags object?

@description('Optional. Enable/Disable usage telemetry for module.')
param enableTelemetry bool = true

@description('Optional. The name of the user assigned identity for the AI Studio hub. If not provided, the hub will use a system assigned identity.')
param managedIdentityName string?

@description('Optional. Configuration for the Log Analytics workspace.')
param logAnalyticsConfiguration logAnalyticsConfigurationType

@description('Optional. Configuration for the key vault.')
param keyVaultConfiguration keyVaultConfigurationType

@description('Optional. Configuration for the storage account.')
param storageAccountConfiguration storageAccountConfigurationType

@description('Optional. Configuration for the container registry.')
param containerRegistryConfiguration containerRegistryConfigurationType

@description('Optional. Configuration for Application Insights.')
param applicationInsightsConfiguration applicationInsightsConfigurationType

@description('Optional. Configuration for the AI Studio workspace.')
param workspaceConfiguration workspaceConfigurationType

@description('Optional. Configuration for the virtual network.')
param virtualNetworkConfiguration virtualNetworkConfigurationType

@description('Optional. Configuration for the Azure Bastion host.')
param bastionConfiguration bastionConfigurationType

@description('Optional. Configuration for the virtual machine.')
param virtualMachineConfiguration virtualMachineConfigurationType

// ============== //
// Variables      //
// ============== //

var createVirtualNetwork = virtualNetworkConfiguration.?enabled != false

var createBastion = createVirtualNetwork && bastionConfiguration.?enabled != false

var createVirtualMachine = createVirtualNetwork && virtualMachineConfiguration.?enabled != false

var createDefaultNsg = virtualNetworkConfiguration.?subnet.networkSecurityGroupResourceId == null

var subnetResourceId = createVirtualNetwork ? virtualNetwork.outputs.subnetResourceIds[0] : null

var mlTargetSubResource = 'amlworkspace'

var mlPrivateDnsZones = {
  'privatelink.api.azureml.ms': mlTargetSubResource
  'privatelink.notebooks.azure.net': mlTargetSubResource
}

var storagePrivateDnsZones = {
  'privatelink.blob.${environment().suffixes.storage}': 'blob'
  'privatelink.file.${environment().suffixes.storage}': 'file'
}

// ============== //
// Resources      //
// ============== //

#disable-next-line no-deployments-resources
resource avmTelemetry 'Microsoft.Resources/deployments@2023-07-01' = if (enableTelemetry) {
  name: '46d3xbcp.ptn.aiplatform-baseline.${replace('-..--..-', '.', '-')}.${substring(uniqueString(deployment().name, location), 0, 4)}'
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
      outputs: {
        telemetry: {
          type: 'String'
          value: 'For more information, see https://aka.ms/avm/TelemetryInfo'
        }
      }
    }
  }
}

module storageAccount_privateDnsZones 'br/public:avm/res/network/private-dns-zone:0.3.1' = [
  for zone in objectKeys(storagePrivateDnsZones): if (createVirtualNetwork) {
    name: '${uniqueString(deployment().name, location, zone)}-storage-private-dns-zones'
    params: {
      name: zone
      virtualNetworkLinks: [
        {
          virtualNetworkResourceId: virtualNetwork.outputs.resourceId
        }
      ]
    }
  }
]

module workspaceHub_privateDnsZones 'br/public:avm/res/network/private-dns-zone:0.3.1' = [
  for zone in objectKeys(mlPrivateDnsZones): if (createVirtualNetwork) {
    name: '${uniqueString(deployment().name, location, zone)}-workspace-private-dns-zones'
    params: {
      name: zone
      virtualNetworkLinks: [
        {
          virtualNetworkResourceId: virtualNetwork.outputs.resourceId
        }
      ]
      roleAssignments: managedIdentityName != null
        ? [
            {
              principalId: userAssignedIdentity.properties.principalId
              roleDefinitionIdOrName: 'Contributor'
              principalType: 'ServicePrincipal'
            }
          ]
        : null
    }
  }
]

module defaultNetworkSecurityGroup 'br/public:avm/res/network/network-security-group:0.3.1' = if (createDefaultNsg) {
  name: '${uniqueString(deployment().name, location)}-nsg'
  params: {
    name: 'nsg-${name}'
    location: location
    securityRules: [
      {
        name: 'DenySshRdpOutbound'
        properties: {
          priority: 200
          access: 'Deny'
          protocol: '*'
          direction: 'Outbound'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRanges: [
            '3389'
            '22'
          ]
        }
      }
    ]
    tags: tags
  }
}

module virtualNetwork 'br/public:avm/res/network/virtual-network:0.4.0' = if (createVirtualNetwork) {
  name: '${uniqueString(deployment().name, location)}-virtual-network'
  params: {
    name: virtualNetworkConfiguration.?name ?? 'vnet-${name}'
    location: location
    enableTelemetry: enableTelemetry
    addressPrefixes: [
      virtualNetworkConfiguration.?addressPrefix ?? '10.0.0.0/16'
    ]
    subnets: union(
      // The default subnet **must** be the first in the subnets array
      [
        {
          addressPrefix: virtualNetworkConfiguration.?subnet.addressPrefix ?? '10.0.0.0/24'
          name: virtualNetworkConfiguration.?subnet.name ?? 'default'
          networkSecurityGroupResourceId: createDefaultNsg
            ? defaultNetworkSecurityGroup.outputs.resourceId
            : virtualNetworkConfiguration.?subnet.networkSecurityGroupResourceId
        }
      ],
      createBastion
        ? [
            {
              addressPrefix: bastionConfiguration.?subnetAddressPrefix ?? '10.0.1.0/26'
              name: 'AzureBastionSubnet'
              networkSecurityGroupResourceId: bastionConfiguration.?networkSecurityGroupResourceId
            }
          ]
        : []
    )
    tags: tags
  }
}

module bastion 'br/public:avm/res/network/bastion-host:0.2.2' = if (createBastion) {
  name: '${uniqueString(deployment().name, location)}-bastion-host'
  params: {
    name: bastionConfiguration.?name ?? 'bas-${name}'
    location: location
    skuName: bastionConfiguration.?sku ?? 'Standard'
    enableTelemetry: enableTelemetry
    virtualNetworkResourceId: virtualNetwork.outputs.resourceId
    disableCopyPaste: bastionConfiguration.?disableCopyPaste
    enableFileCopy: bastionConfiguration.?enableFileCopy
    enableIpConnect: bastionConfiguration.?enableIpConnect
    enableKerberos: bastionConfiguration.?enableKerberos
    enableShareableLink: bastionConfiguration.?enableShareableLink
    scaleUnits: bastionConfiguration.?scaleUnits
    tags: tags
  }
}

module virtualMachine 'br/public:avm/res/compute/virtual-machine:0.5.3' = if (createVirtualMachine) {
  name: '${uniqueString(deployment().name, location)}-virtual-machine'
  params: {
    name: virtualMachineConfiguration.?name ?? 'vm-${name}'
    computerName: virtualMachineConfiguration.?name ?? take('vm-${name}', 15)
    location: location
    enableTelemetry: enableTelemetry
    adminUsername: virtualMachineConfiguration.?adminUsername ?? ''
    adminPassword: virtualMachineConfiguration.?adminPassword
    nicConfigurations: [
      {
        name: virtualMachineConfiguration.?nicConfigurationConfiguration.name ?? 'nic-vm-${name}'
        location: location
        networkSecurityGroupResourceId: virtualMachineConfiguration.?nicConfigurationConfiguration.networkSecurityGroupResourceId
        ipConfigurations: [
          {
            name: virtualMachineConfiguration.?nicConfigurationConfiguration.ipConfigName ?? 'nic-vm-${name}-ipconfig'
            privateIPAllocationMethod: virtualMachineConfiguration.?nicConfigurationConfiguration.privateIPAllocationMethod ?? 'Dynamic'
            subnetResourceId: virtualNetwork.outputs.subnetResourceIds[0]
          }
        ]
      }
    ]
    imageReference: virtualMachineConfiguration.?imageReference ?? {
      publisher: 'microsoft-dsvm'
      offer: 'dsvm-win-2022'
      sku: 'winserver-2022'
      version: 'latest'
    }
    osDisk: virtualMachineConfiguration.?osDisk ?? {
      createOption: 'FromImage'
      managedDisk: {
        storageAccountType: 'Premium_ZRS'
      }
      diskSizeGB: 128
      caching: 'ReadWrite'
    }
    patchMode: virtualMachineConfiguration.?patchMode
    osType: 'Windows'
    encryptionAtHost: virtualMachineConfiguration.?encryptionAtHost ?? true
    vmSize: virtualMachineConfiguration.?size ?? 'Standard_D2s_v3'
    zone: virtualMachineConfiguration.?zone ?? 0
    extensionAadJoinConfig: virtualMachineConfiguration.?enableAadLoginExtension == true
      ? {
          enabled: true
          typeHandlerVersion: '1.0'
        }
      : null
    extensionMonitoringAgentConfig: virtualMachineConfiguration.?enableAzureMonitorAgent == true
      ? {
          enabled: true
        }
      : null
    maintenanceConfigurationResourceId: virtualMachineConfiguration.?maintenanceConfigurationResourceId
    tags: tags
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = if (managedIdentityName != null) {
  name: managedIdentityName ?? 'null'
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsConfiguration.?name ?? 'log-${name}'
  location: location
  tags: tags
}

resource resourceGroup_roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (managedIdentityName != null) {
  name: guid(resourceGroup().id, name)
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      'acdd72a7-3385-48ef-bd42-f606fba81ae7' // Reader
    )
    principalId: userAssignedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

module keyVault 'br/public:avm/res/key-vault/vault:0.6.2' = {
  name: '${uniqueString(deployment().name, location)}-key-vault'
  params: {
    name: keyVaultConfiguration.?name ?? 'kv-${name}'
    location: location
    enableTelemetry: enableTelemetry
    enableRbacAuthorization: true
    enableVaultForDeployment: false
    enableVaultForDiskEncryption: false
    enableVaultForTemplateDeployment: false
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
    publicNetworkAccess: 'Disabled'
    enablePurgeProtection: keyVaultConfiguration.?enablePurgeProtection ?? true
    roleAssignments: managedIdentityName != null
      ? [
          {
            principalId: userAssignedIdentity.properties.principalId
            roleDefinitionIdOrName: 'Contributor'
            principalType: 'ServicePrincipal'
          }
          {
            principalId: userAssignedIdentity.properties.principalId
            roleDefinitionIdOrName: 'Key Vault Administrator'
            principalType: 'ServicePrincipal'
          }
        ]
      : null
    diagnosticSettings: [
      {
        workspaceResourceId: logAnalyticsWorkspace.id
        logCategoriesAndGroups: [
          {
            category: 'AuditEvent'
            enabled: true
          }
        ]
      }
    ]
    tags: tags
  }
}

// ============ //
// Outputs      //
// ============ //

@description('The name of the resource group the module was deployed to.')
output resourceGroupName string = resourceGroup().name

@description('The location the module was deployed to.')
output location string = location

// ================ //
// Definitions      //
// ================ //

type logAnalyticsConfigurationType = {
  @description('Optional. The name of the Log Analytics workspace.')
  name: string?
}?

type keyVaultConfigurationType = {
  @description('Optional. The name of the key vault.')
  name: string?

  @description('Optional. Provide \'true\' to enable Key Vault\'s purge protection feature. Defaults to \'true\'.')
  enablePurgeProtection: bool?
}?

@secure()
type virtualMachineConfigurationType = {
  @description('Optional. Whether to create a virtual machine in the associated virtual network. Defaults to \'true\'.')
  enabled: bool?

  @description('Optional. The name of the virtual machine.')
  @maxLength(15)
  name: string?

  @description('Optional. The availability zone of the virtual machine. If set to 0, no availability zone is used (default).')
  zone: 0 | 1 | 2 | 3?

  @description('Required. The virtual machine size. Defaults to \'Standard_D2s_v3\'.')
  size: string?

  @description('Conditional. The username for the administrator account on the virtual machine. Required if a virtual machine is created as part of the module.')
  adminUsername: string?

  @description('Conditional. The password for the administrator account on the virtual machine. Required if a virtual machine is created as part of the module.')
  adminPassword: string?

  @description('Optional. Configuration for the virtual machine network interface.')
  nicConfigurationConfiguration: nicConfigurationConfigurationType

  @description('Optional. OS image reference. In case of marketplace images, it\'s the combination of the publisher, offer, sku, version attributes. In case of custom images it\'s the resource ID of the custom image.')
  imageReference: object?

  @description('Optional. Specifies the OS disk.')
  osDisk: osDiskType

  @description('Optional. This property can be used by user in the request to enable or disable the Host Encryption for the virtual machine. This will enable the encryption for all the disks including Resource/Temp disk at host itself. For security reasons, it is recommended to set encryptionAtHost to \'true\'.')
  encryptionAtHost: bool?

  @description('Optional. VM guest patching orchestration mode. Refer to \'https://learn.microsoft.com/en-us/azure/virtual-machines/automatic-vm-guest-patching\'.')
  patchMode: 'AutomaticByPlatform' | 'AutomaticByOS' | 'Manual'?

  @description('Optional. Whether to enable the Microsoft.Azure.ActiveDirectory AADLoginForWindows extension, allowing users to log in to the virtual machine using Microsoft Entra. Defaults to \'false\'.')
  enableAadLoginExtension: bool?

  @description('Optional. Whether to enable the Microsoft.Azure.Monitor AzureMonitorWindowsAgent extension. Defaults to \'false\'.')
  enableAzureMonitorAgent: bool?

  @description('Optional. The resource Id of a maintenance configuration for the virtual machine.')
  maintenanceConfigurationResourceId: string?
}?
