## Java - These functions allow for JDK version management
function Reset-JavaHome() {
    $env:JAVA_HOME = $env:JDK_21_HOME
    Write-Output "The JAVA_HOME environment variable is now set to $env:JAVA_HOME."
  }
  
function Set-JavaHome([int] $Version) {
    $CurrentJdk = $env:JAVA_HOME

    if (-NOT $Version) {
        Reset-JavaHome
        return
    }

    switch ($Version) {
        11 {
        if (-NOT (Test-Path -Path $env:JDK_11_HOME)) {
            Write-Output "No JDK configured for version $PSItem... Aborted."
            break
        }

        $CurrentJdk = $env:JDK_11_HOME
        break
        }
        17 {
        if (-NOT (Test-Path -Path $env:JDK_17_HOME)) {
            Write-Output "No JDK configured for version $PSItem... Aborted."
            break
        }

        $CurrentJdk = $env:JDK_17_HOME
        break
        }
        21 {
        if (-NOT (Test-Path -Path $env:JDK_21_HOME)) {
            Write-Output "No JDK configured for version $PSItem... Aborted."
            break
        }

        $CurrentJdk = $env:JDK_21_HOME
        break
        }
        Default { Write-Output "No JDK configured for version $PSItem... Aborted." }
    }

    if ($env:JAVA_HOME -NE $CurrentJdk) {
        $env:JAVA_HOME = $CurrentJdk
        Write-Output "The JAVA_HOME environment variable is now set to $env:JAVA_HOME."
    }
}

# Aliases
Set-Alias -Name sjh -Value Set-JavaHome
Set-Alias -Name rsjh -Value Reset-JavaHome
