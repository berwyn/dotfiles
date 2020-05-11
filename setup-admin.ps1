#Requires -Version 7

#region Windows
function Install-WslKernelUpdate {
    $tempDir = [System.IO.Path]::GetTempPath()
    $target = "${tempDir}\wsl_update.msi"
    $url = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"

    Start-BitsTransfer -Source $url -Destination $target -Description "Downloading WSL kernel update"

    msiexec /I $target /quiet
}

function Set-WindowsRegistryKeys {
    ### Explorer, Taskbar, System Tray
    # Borrowed from https://github.com/addyosmani/dotfiles-windows/blob/master/windows.ps1

    if (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")) 
    {
        New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Type Folder | Out-Null
    }

    # Explorer: Show hidden files by default (1: Show Files, 2: Hide Files)
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1

    # Explorer: show file extensions by default (0: Show Extensions, 1: Hide Extensions)
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0

    # Explorer: show path in title bar
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" "FullPath" 1

    # Explorer: Avoid creating Thumbs.db files on network volumes
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "DisableThumbnailsOnNetworkFolders" 1
}

function Install-WSL {
    Enable-WindowsOptionalFeature -Online -NoRestart -All -FeatureName Microsoft-Windows-Subsystem-Linux
    Enable-WindowsOptionalFeature -Online -NoRestart -All -FeatureName VirtualMachinePlatform
}
#endregion

$isDotSourced = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''
if ($isDotSourced) { return }

Set-WindowsRegistryKeys
Install-WSL
Install-WslKernelUpdate