    # [System.Environment]::SetEnvironmentVariable('PACKAGES_ROOT', "$($global:DevDriveLetter):\Packages", 'Machine')
    # [System.Environment]::SetEnvironmentVariable('NPM_CONFIG_CACHE', "$($global:DevDriveLetter):\Packages\.npm", 'Machine')
    # [System.Environment]::SetEnvironmentVariable('NUGET_PACKAGES', "$($global:DevDriveLetter):\Packages\.nuget", 'Machine')
    # [System.Environment]::SetEnvironmentVariable('PIP_CACHE_DIR', "$($global:DevDriveLetter):\Packages\.pip", 'Machine')
    # [System.Environment]::SetEnvironmentVariable('MAVEN_OPTS', "-Dmaven.repo.local=$($global:DevDriveLetter):\Packages\.maven $env:MAVEN_OPTS", 'Machine')

    # $MsftJavaHome = Join-Path $env:ProgramFiles 'Microsoft'
    # $Java11 = Get-ChildItem -Path $MsftJavaHome -Filter 'jdk-11*' -Name
    # $Java17 = Get-ChildItem -Path $MsftJavaHome -Filter 'jdk-17*' -Name
    # $Java21 = Get-ChildItem -Path $MsftJavaHome -Filter 'jdk-21*' -Name
    # [System.Environment]::SetEnvironmentVariable('JDK_11_HOME', "$MsftJavaHome\$Java11\", 'Machine')
    # [System.Environment]::SetEnvironmentVariable('JDK_17_HOME', "$MsftJavaHome\$Java17\", 'Machine')
    # [System.Environment]::SetEnvironmentVariable('JDK_21_HOME', "$MsftJavaHome\$Java21\", 'Machine')
    # [System.Environment]::SetEnvironmentVariable('JAVA_HOME', '%JDK_21_HOME%', 'Machine')
    # [System.Environment]::SetEnvironmentVariable('PATH', "$env:PATH;%JAVA_HOME%", 'Machine')