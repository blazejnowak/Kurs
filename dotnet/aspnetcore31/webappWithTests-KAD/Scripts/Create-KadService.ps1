<#
.SYNOPSIS
    Demo script used to create Windows service for Kurs Azure DevOps's demo .NET Core app.
.DESCRIPTION
    Script creates Windows service with .exe path. Script takes 3 parameters:
    - Service Name (serviceName) - used to create and start service
    - Application Path - folder path where application is stored
    - Exe Name - application name with exstension
.EXAMPLE
    PS C:\> .\Create-KadService.ps1 -appPath "C:\tmp\KursAzureDevOps\dotnet\aspnetcore31\webappWithTests-KAD\Application\aspnet-core-dotnet-core\bin\Debug\netcoreapp3.1" -exeName "aspnet-core-dotnet-core.exe" -serviceName "SVC-KAD-Demo"
#>

[CmdletBinding()]
param (
    [Parameter()][string]
    $serviceName = "KAD-Demo-Service",
    [Parameter(Mandatory=$true)][string][ValidateNotNullOrEmpty()]
    $appPath,
    [Parameter(Mandatory=$true)][string][ValidateNotNullOrEmpty()]
    $exeName
)

# Variables
$appExePath = $appPath + "\" + "$exeName"

# Create service
if (Get-Service $serviceName -ErrorAction SilentlyContinue) {
    Write-Host "Service $serviceName exists" -ForegroundColor "Yellow"
} else {
    Write-Host "Creating $serviceName from $appExePath"
    New-Service -Name "$serviceName" -BinaryPathName "$appExePath" -Description "$serviceName" -DisplayName "$serviceName" -StartupType Automatic | Out-Null
}

# Run service
Write-Host "Starting service: $serviceName" -ForegroundColor "Green"
Start-Service "$serviceName" -PassThru
