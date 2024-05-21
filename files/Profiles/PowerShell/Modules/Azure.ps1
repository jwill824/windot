function Install-AzPowerShell() {
    Write-Host 'Installing Azure PowerShell...'

    if (Get-Module -Name Az -ListAvailable) {
        Write-Host 'Azure PowerShell is already installed. Updating to latest...'
        Update-Module -Name Az -Force
        Write-Host 'Done. Azure PowerShell updated to latest.'
        return
    }

    Install-Module -Name Az -Repository PSGallery -Force
    Write-Host 'Done. Azure PowerShell has been installed.'
}