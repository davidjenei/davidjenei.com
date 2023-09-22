Automation-power-on-off
=======================

Auto shutdown is now available under Virtual Machine/Schedules, but here
is a good old automation playbook

```
  # Input Parameters for
  # - VmName: name of the vm to perform action to
  # - ResourceGroupName: resource group where the vm belongs to
  # - VmAction:action to perform (startup or shutdown)
  Param(
   [string]$VmName,
   [string]$ResourceGroupName,
   [ValidateSet("Startup", "Shutdown")]
   [string]$VmAction
  )
   
  # Authenticate with your Automation Account
  $Conn = Get-AutomationConnection -Name AzureRunAsConnection
  Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID `
  -ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
   
  # Startup VM
  IF ($VmAction -eq "Startup") {
      Start-AzureRmVM -Name $VmName -ResourceGroupName $ResourceGroupName
  }
   
  # Shutdown VM
  IF ($VmAction -eq "Shutdown") {
      Stop-AzureRmVM -Name $VmName -ResourceGroupName $ResourceGroupName -Force
  }
```

Automation-nsg-shh
==================

Just-in-time access requires standard tier Security Center subscription,
but we can save some money with this automation playbook.

```
  Param(
   [string]$nsgName,
   [string]$rgName,
   [ValidateSet("On", "Off")]
   [string]$Action
  )
   
  Enable-AzureRMAlias -Scope Process

  # Authenticate with your Automation Account
  $Conn = Get-AutomationConnection -Name AzureRunAsConnection
  Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID `
  -ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

  IF ($Action -eq "On") {
      Get-AzNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName  | `
      Add-AzNetworkSecurityRuleConfig -Name "ssh" -Protocol Tcp `
    -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * `
    -DestinationPortRange 22 -Access Allow | `
      Set-AzNetworkSecurityGroup
  }
   
  IF ($Action -eq "Off") {
      Get-AzNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName  | `
      Remove-AzNetworkSecurityRuleConfig -Name "ssh" | `
      Set-AzNetworkSecurityGroup
  }
```
