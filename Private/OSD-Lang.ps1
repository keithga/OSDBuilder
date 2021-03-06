function OSD-Lang-LanguagePacks {
    [CmdletBinding()]
    PARAM ()
    if ($OSMajorVersion -ne 10) {Return}
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "Install.wim: Language Packs"	-ForegroundColor Green

    foreach ($Update in $LanguagePacks) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            if ($Update -like "*.cab") {
                Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
                Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguagePack.log" | Out-Null
            } elseif ($Update -like "*.appx") {
                Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
                Add-AppxProvisionedPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LicensePath "$((Get-Item $OSDBuilderContent\$Update).Directory.FullName)\License.xml" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LocalExperiencePack.log" | Out-Null
            }
        } else {
            Write-Warning "Not Found: $OSDBuilderContent\$Update"
        }
    }
}
function OSD-Lang-LanguageInterfacePacks {
    [CmdletBinding()]
    PARAM ()
    if ($OSMajorVersion -ne 10) {Return}
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "Install.wim: Language Interface Packs"	-ForegroundColor Green

    foreach ($Update in $LanguageInterfacePacks) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguageInterfacePack.log" | Out-Null
        } else {
            Write-Warning "Not Found: $OSDBuilderContent\$Update"
        }
    }
}
function OSD-Lang-LocalExperiencePacks {
    [CmdletBinding()]
    PARAM ()
    if ($OSMajorVersion -ne 10) {Return}
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "Install.wim: Local Experience Packs"	-ForegroundColor Green

    foreach ($Update in $LocalExperiencePacks) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-AppxProvisionedPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LicensePath "$((Get-Item $OSDBuilderContent\$Update).Directory.FullName)\License.xml" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LocalExperiencePack.log" | Out-Null
        } else {
            Write-Warning "Not Found: $OSDBuilderContent\$Update"
        }
    }
}
function OSD-Lang-LanguageFeatures {
    [CmdletBinding()]
    PARAM ()
    if ($OSMajorVersion -ne 10) {Return}
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "Install.wim: Language Features"	-ForegroundColor Green
    
    foreach ($Update in $LanguageFeatures | Where-Object {$_ -notlike "*Speech*"}) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguageFeatures.log" | Out-Null
        }
    }
    foreach ($Update in $LanguageFeatures | Where-Object {$_ -like "*TextToSpeech*"}) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguageFeatures.log" | Out-Null
        }
    }
    foreach ($Update in $LanguageFeatures | Where-Object {$_ -like "*Speech*" -and $_ -notlike "*TextToSpeech*"}) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguageFeatures.log" | Out-Null
        }
    }
}
function OSD-Lang-LanguageSettings {
    [CmdletBinding()]
    PARAM ()
    if ($OSMajorVersion -ne 10) {Return}
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "Install.wim: Language Settings" -ForegroundColor Green

    #===================================================================================================
    Write-Verbose '19.1.1 Install.wim: Generating Lang.ini'
    #===================================================================================================
    if ($SetAllIntl) {
        #Write-Host '========================================================================================' -ForegroundColor DarkGray
        Write-Host "Install.wim: SetAllIntl" -ForegroundColor Green
        Dism /Image:"$MountDirectory" /Set-AllIntl:"$SetAllIntl" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetAllIntl.log" | Out-Null
    }
    if ($SetInputLocale) {
        #Write-Host '========================================================================================' -ForegroundColor DarkGray
        Write-Host "Install.wim: SetInputLocale" -ForegroundColor Green
        Dism /Image:"$MountDirectory" /Set-InputLocale:"$SetInputLocale" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetInputLocale.log" | Out-Null
    }
    if ($SetSKUIntlDefaults) {
        #Write-Host '========================================================================================' -ForegroundColor DarkGray
        Write-Host "Install.wim: SetSKUIntlDefaults" -ForegroundColor Green
        Dism /Image:"$MountDirectory" /Set-SKUIntlDefaults:"$SetSKUIntlDefaults" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetSKUIntlDefaults.log" | Out-Null
    }
    if ($SetSetupUILang) {
        #Write-Host '========================================================================================' -ForegroundColor DarkGray
        Write-Host "Install.wim: SetSetupUILang" -ForegroundColor Green
        Dism /Image:"$MountDirectory" /Set-SetupUILang:"$SetSetupUILang" /Distribution:"$OS" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetSetupUILang.log" | Out-Null
    }
    if ($SetSysLocale) {
        #Write-Host '========================================================================================' -ForegroundColor DarkGray
        Write-Host "Install.wim: SetSysLocale" -ForegroundColor Green
        Dism /Image:"$MountDirectory" /Set-SysLocale:"$SetSysLocale" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetSysLocale.log" | Out-Null
    }
    if ($SetUILang) {
        #Write-Host '========================================================================================' -ForegroundColor DarkGray
        Write-Host "Install.wim: SetUILang" -ForegroundColor Green
        Dism /Image:"$MountDirectory" /Set-UILang:"$SetUILang" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetUILang.log" | Out-Null
    }
    if ($SetUILangFallback) {
        #Write-Host '========================================================================================' -ForegroundColor DarkGray
        Write-Host "Install.wim: SetUILangFallback" -ForegroundColor Green
        Dism /Image:"$MountDirectory" /Set-UILangFallback:"$SetUILangFallback" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetUILangFallback.log" | Out-Null
    }
    if ($SetUserLocale) {
        #Write-Host '========================================================================================' -ForegroundColor DarkGray
        Write-Host "Install.wim: SetUserLocale" -ForegroundColor Green
        Dism /Image:"$MountDirectory" /Set-UserLocale:"$SetUserLocale" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetUserLocale.log" | Out-Null
    }
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "Install.wim: Generating Updated Lang.ini" -ForegroundColor Green
    Dism /Image:"$MountDirectory" /Gen-LangIni /Distribution:"$OS" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-gen-langini.log" | Out-Null

    Update-WinSELangIni -OSMediaPath "$WorkingPath"
}

function Update-WinSELangIni {
    [CmdletBinding()]
    PARAM (
        [string]$OSMediaPath
    )
    Write-Host "Install.wim: Updating WinSE.wim with updated Lang.ini" -ForegroundColor Green
    $MountWinSELangIni = Join-Path $OSDBuilderContent\Mount "winselangini$((Get-Date).ToString('hhmmss'))"
    if (!(Test-Path "$MountWinSELangIni")) {New-Item "$MountWinSELangIni" -ItemType Directory -Force | Out-Null}

    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Mount-WinSELangIni.log"
    Mount-WindowsImage -ImagePath "$OSMediaPath\WinPE\winse.wim" -Index 1 -Path "$MountWinSELangIni" -LogPath "$CurrentLog" | Out-Null

    Copy-Item -Path "$OS\Sources\lang.ini" -Destination "$MountWinSELangIni\Sources" -Force | Out-Null

    Start-Sleep -Seconds 10
    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dismount-WinSELangIni.log"
    try {
        Dismount-WindowsImage -Path "$MountWinSELangIni" -Save -LogPath "$CurrentLog" -ErrorAction SilentlyContinue | Out-Null
    }
    catch {
        Write-Warning "Could not dismount WinSE.wim ... Waiting 30 seconds ..."
        Start-Sleep -Seconds 30
        Dismount-WindowsImage -Path "$MountWinSELangIni" -Save -LogPath "$CurrentLog" | Out-Null
    }
    if (Test-Path "$MountWinSELangIni") {Remove-Item -Path "$MountWinSELangIni" -Force -Recurse | Out-Null}

    Write-Host "Install.wim: Updating Boot.wim Index 2 with updated Lang.ini" -ForegroundColor Green
    $MountBootLangIni = Join-Path $OSDBuilderContent\Mount "bootlangini$((Get-Date).ToString('hhmmss'))"
    if (!(Test-Path "$MountBootLangIni")) {New-Item "$MountBootLangIni" -ItemType Directory -Force | Out-Null}

    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Mount-BootLangIni.log"
    Mount-WindowsImage -ImagePath "$OS\Sources\boot.wim" -Index 2 -Path "$MountBootLangIni" -LogPath "$CurrentLog" | Out-Null

    Copy-Item -Path "$OS\Sources\lang.ini" -Destination "$MountBootLangIni\Sources" -Force | Out-Null

    Start-Sleep -Seconds 10
    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dismount-BootLangIni.log"
    try {
        Dismount-WindowsImage -Path "$MountBootLangIni" -Save -LogPath "$CurrentLog" -ErrorAction SilentlyContinue | Out-Null
    }
    catch {
        Write-Warning "Could not dismount Boot.wim ... Waiting 30 seconds ..."
        Start-Sleep -Seconds 30
        Dismount-WindowsImage -Path "$MountBootLangIni" -Save -LogPath "$CurrentLog" | Out-Null
    }
    if (Test-Path "$MountBootLangIni") {Remove-Item -Path "$MountBootLangIni" -Force -Recurse | Out-Null}
}

function Copy-OSDLanguageSources {
    [CmdletBinding()]
    PARAM ()
    if ($OSMajorVersion -ne 10) {Return}
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "Install.wim: Language Sources"	-ForegroundColor Green
    
    foreach ($LanguageSource in $LanguageCopySources) {
        $CurrentLanguageSource = Get-OSMedia -Revision OK | Where-Object {$_.OSMFamily -eq $LanguageSource} | Select-Object -Property FullName
        Write-Host "Copying Language Resources from $($CurrentLanguageSource.FullName)" -ForegroundColor DarkGray
        robocopy "$($CurrentLanguageSource.FullName)\OS" "$OS" *.* /e /xf *.wim /ndl /xc /xn /xo /xf /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguageSources.log" | Out-Null
    }
}