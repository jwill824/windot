$MyName = "Jeff Williams"
$MyNameWithoutWhitespace = $($MyName -replace " ","")
$MyEmail = "jeffwilliams824@gmail.com"
$MyGitHubUser = "jwill824"
$DevDriveLetter = $null
$RepoRoot = $null

function Initialize-Git() {
    Write-Host 'Initializing Git...'
    winget install --exact --id Git.Git --source winget
    git config --global core.autocrlf true
    git config --global init.defaultBranch main
    git config --global push.autoSetupRemote true
    Write-Host 'Done. Git has been initialized.'
}

function Format-DevDrive() {
    Write-Host 'Initializing development drive...'

    $Volumes = Get-Volume

    $DevDrive = $Volumes | Where-Object { $_.FileSystemLabel -eq 'DEVDRIVE' } | Select-Object -First 1

    if ($DevDrive) {
        $global:DevDriveLetter = $DevDrive.DriveLetter
        Write-Host "Skipped. Development drive $global:DevDriveLetter already exists."
        return
    }

    $PreferredDriveLetters = 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    $global:DevDriveLetter = $PreferredDriveLetters | Where-Object { $Volumes.DriveLetter -notcontains $_ } | Select-Object -First 1

    Format-Volume -DriveLetter $DevDriveLetter -DevDrive

    Write-Host "Done. Development drive $DevDriveLetter has been initialized."
}

function Get-Repository() {
    Write-Host 'Cloning dotfiles repository...'

    $global:RepoRoot = "$($global:DevDriveLetter):\Source\Repos\$MyNameWithoutWhitespace\Dotfiles"

    if (Test-Path -Path $global:RepoRoot) {
        Write-Host "Dotfiles repository already exists at $global:RepoRoot. Fetching latest instead..."
        Push-Location $global:RepoRoot

        git fetch --all

        Write-Host 'Done. Existing dotfiles repository has been updated with the latest sources.'
        return
    }

    git config user.name $MyName
    git config user.email $MyEmail

    git clone https://github.com/$($MyGitHubUser)/windot $global:RepoRoot
    Push-Location $global:RepoRoot

    Write-Host "Done. Dotfiles repository has been cloned to $global:RepoRoot."
}

function Install-WinGetPackages() {
    Write-Host 'Installing WinGet packages...'

    $PackagesFile = Join-Path $global:RepoRoot '\files\Packages\*.json'
    winget import --import-file $PackagesFile --accept-source-agreements --accept-package-agreements

    Write-Host 'Done. WinGet packages installed successfully.'
}

function Install-Fonts() {
    Write-Host 'Installing fonts...'

    $FontFilesPath = Join-Path $global:RepoRoot '\files\Fonts\*.otf'

    $fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
    foreach ($file in Get-ChildItem -Path $FontFilesPath -Recurse) {
        $fileName = $file.Name
        if (!(Test-Path -Path "C:\Windows\Fonts\$fileName")) {
            Get-ChildItem $file | ForEach-Object { $fonts.CopyHere($_.fullname) }
        }
    }

    Write-Host 'Done. Fonts have been installed.'
}

function Install-PoshGit() {
    Write-Host 'Installing PoshGit...'
    PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
    Write-Host 'Done. PoshGit has been installed.'
}

function Install-TheFucker() {
    Write-Host 'Installing TheFuck...'
    Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/mattparkes/PoShFuck/master/Install-TheFucker.ps1' | Invoke-Expression
    Write-Host 'Done. TheFuck has been installed.'
}

function Set-PowerShellProfile() {
    Write-Host 'Setting PowerShell profile...'

    if (!(Test-Path -Path $PROFILE.CurrentUserAllHosts)) {
        New-Item -ItemType File -Path $PROFILE.CurrentUserAllHosts -Force
    }

    $NewProfile = Join-Path $global:RepoRoot '\files\Profiles\PowerShell\Profile.ps1'

    Get-Content $NewProfile | Set-Content $PROFILE.CurrentUserAllHosts

    Write-Host 'Done. PowerShell profile has been set.'
}

function Set-TerminalProfile() {
    Write-Host 'Setting up Terminal profile...'

    $NewProfile = Join-Path $global:RepoRoot '\files\Profiles\Hyper\.hyper.js'
    $HyperDataDir = "C:\Users\$MyNameWithoutWhitespace\AppData\Roaming\Hyper"

    if (!(Test-Path -Path HyperDataDir)) {
        Copy-Item -Path $NewProfile -Destination $HyperDataDir
    }

    Write-Host 'Done. Terminal profile has been set.'
}

function Set-EnvironmentVariables() {
    Write-Host 'Setting system environment variables...'

    [System.Environment]::SetEnvironmentVariable('DEVDRIVE', "$($global:DevDriveLetter):", 'Machine')

    [System.Environment]::SetEnvironmentVariable('REPOS_ROOT', "$($global:DevDriveLetter):\Source\Repos", 'Machine')
    [System.Environment]::SetEnvironmentVariable('REPOS_PERSONAL', "$($global:DevDriveLetter):\Source\Repos\$MyNameWithoutWhitespace", 'Machine')

    Write-Host 'Done. System environment variables have been set.'
}

Write-Host 'Starting installation of my dotfiles...'

Initialize-Git
Format-DevDrive
Get-Repository
Install-WinGetPackages
Install-Fonts
Install-PoshGit
Install-TheFucker
Set-PowerShellProfile
Set-TerminalProfile
Set-EnvironmentVariables

Write-Host 'Complete!! Dotfiles installed successfully.' -ForegroundColor Green
