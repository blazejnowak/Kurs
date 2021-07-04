<#
.SYNOPSIS
    Demo script used to stop or remove Windows service for Kurs Azure DevOps's demo .NET Core app before copying new application version
.DESCRIPTION
    Script stops or removes Windows service. Script takes 1 parameters:
    - Service Name (serviceName) - used to stop service
    - Switch Remove - used to remove service
.EXAMPLE
    PS C:\> .\Stop-KadService.ps1 -serviceName "SVC-KAD-Demo"
    PS C:\> .\Stop-KadService.ps1 -serviceName "SVC-KAD-Demo" -remove
#>

[CmdletBinding()]
param (
    [Parameter()][string]
    $serviceName = "KAD-Demo-Service",
    [Parameter()][switch]
    $remove
)

if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    Write-Host "Stopping service: $serviceName" -ForegroundColor "Yellow"
    Stop-Service -name $serviceName -PassThru
    if ($remove) {
        Write-Host "Removing service: $serviceName" -ForegroundColor Red
        & "sc delete $serviceName"
    }
} else {
    Write-Host "Service $serviceName does not exist"
}