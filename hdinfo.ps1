#* FileName:  ServerInventory.ps1
#*=============================================================================
#* Script Name: [ServerInventory]
#* Created:     [12/14/07]
#* Author:      Jesse Hamrick
#* Company:     PowerShell Pro!
#* Email:
#* Web:         http://www.powershellpro.com
#* Reqrmnts:
#* Keywords:
#*=============================================================================
#* Purpose:    Server Hardware Inventory
#*
#*
#*=============================================================================

#*=============================================================================
#* REVISION HISTORY
#*=============================================================================
#* Date:        [DATE_MDY]
#* Time:        [TIME]
#* Issue:
#* Solution:
#*
#*=============================================================================

#*=============================================================================
#* FUNCTION LISTING
#*=============================================================================
#* Function:    SysInfo
#* Created:     [12/14/07]
#* Author:       Jesse Hamrick
#* Arguments:
#*=============================================================================
#* Purpose: WMI Function that enumerate win32_ComputerSystem properties
#*
#*
#*=============================================================================

Function SysInfo {

$colItems = Get-WmiObject Win32_ComputerSystem -Namespace “root\CIMV2″ `
-ComputerName $strComputer

foreach($objItem in $colItems) {
Write-Host “Computer Manufacturer: ” $objItem.Manufacturer
Write-Host “Computer Model: ” $objItem.Model
Write-Host “Total Memory: ” $objItem.TotalPhysicalMemory “bytes”
}

}

#*=============================================================================
#* FUNCTION LISTING
#*=============================================================================
#* Function:    BIOSInfo
#* Created:     [12/14/07]
#* Author:       Jesse Hamrick
#* Arguments:
#*=============================================================================
#* Purpose: WMI Function that enumerate win32_BIOS properties
#*
#*
#*=============================================================================

Function BIOSInfo {

$colItems = Get-WmiObject Win32_BIOS -Namespace “root\CIMV2″ -computername $strComputer
foreach($objItem in $colItems) {
Write-Host “BIOS:”$objItem.Description
Write-Host “Version:”$objItem.SMBIOSBIOSVersion”.”`
$objItem.SMBIOSMajorVersion”.”$objItem.SMBIOSMinorVersion
Write-Host “Serial Number:” $objItem.SerialNumber
}

}

#*=============================================================================
#* FUNCTION LISTING
#*=============================================================================
#* Function:    OSInfo
#* Created:     [12/14/07]
#* Author:       Jesse Hamrick
#* Arguments:
#*=============================================================================
#* Purpose: WMI Function that enumerate win32_OperatingSystem properties
#*
#*
#*=============================================================================

Function OSInfo {

$colItems = Get-WmiObject Win32_OperatingSystem -Namespace “root\CIMV2″`
-Computername $strComputer

foreach($objItem in $colItems) {
Write-Host “Operating System:” $objItem.Name
}

}

#*=============================================================================
#* FUNCTION LISTING
#*=============================================================================
#* Function:    CPUInfo
#* Created:     [12/14/07]
#* Author:       Jesse Hamrick
#* Arguments:
#*=============================================================================
#* Purpose: WMI Function that enumerate win32_Processor properties
#*
#*
#*=============================================================================

Function CPUInfo {

$colItems = Get-WmiObject Win32_Processor -Namespace “root\CIMV2″`
-Computername $strComputer

foreach($objItem in $colItems) {
Write-Host “Processor:” $objItem.DeviceID $objItem.Name
}

}

#*=============================================================================
#* FUNCTION LISTING
#*=============================================================================
#* Function:    DiskInfo
#* Created:     [12/14/07]
#* Author:       Jesse Hamrick
#* Arguments:
#*=============================================================================
#* Purpose: WMI Function that enumerate win32_DiskDrive properties
#*
#*
#*=============================================================================

Function DiskInfo {

$colItems = Get-WmiObject Win32_DiskDrive -Namespace “root\CIMV2″`
-ComputerName $strComputer

foreach($objItem in $colItems) {
Write-Host “Disk:” $objItem.DeviceID
Write-Host “Size:” $objItem.Size “bytes”
Write-Host “Drive Type:” $objItem.InterfaceType
Write-Host “Media Type: ” $objItem.MediaType
}

}

#*=============================================================================
#* FUNCTION LISTING
#*=============================================================================
#* Function:    NetworkInfo
#* Created:     [12/14/07]
#* Author:       Jesse Hamrick
#* Arguments:
#*=============================================================================
#* Purpose: WMI Function that enumerate win32_NetworkAdapterConfiguration
#*         properties
#*
#*=============================================================================

Function NetworkInfo {

$colItems = Get-WmiObject Win32_NetworkAdapterConfiguration -Namespace “root\CIMV2″`
-ComputerName $strComputer | where{$_.IPEnabled -eq “True”}

foreach($objItem in $colItems) {
Write-Host “DHCP Enabled:” $objItem.DHCPEnabled
Write-Host “IP Address:” $objItem.IPAddress
Write-Host “Subnet Mask:” $objItem.IPSubnet
Write-Host “Gateway:” $objItem.DefaultIPGateway
Write-Host “MAC Address:” $ojbItem.MACAddress
}

}

#*=============================================================================
#* SCRIPT BODY
#*=============================================================================
#* Connect to computer
$strComputer = “.”

#* Call SysInfo Function
Write-Host “Sytem Information”
SysInfo
Write-Host

#* Call BIOSinfo Function
Write-Host “System BIOS Information”
BIOSInfo
Write-Host

#* Call OSInfo Function
Write-Host “Operating System Information”
OSInfo
Write-Host

#* Call CPUInfo Function
Write-Host “Processor Information”
CPUInfo
Write-Host

#* Call DiskInfo Function
Write-Host “Disk Information”
DiskInfo
Write-Host

#* Call NetworkInfo Function
Write-Host “Network Information”
NetworkInfo
Write-Host

#*=============================================================================
#* END OF SCRIPT: [ServerInventory]
#*=============================================================================