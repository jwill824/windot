# Oh My Posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression

# Posh Git
Import-Module posh-git

# PoSh Fuck
Import-Module PoShFuck

# Aliases
Set-Alias -Name code -Value code-insiders