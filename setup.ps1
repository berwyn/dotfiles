#Requires -Version 7

$scriptDirectory = Split-Path -Parent $PSCommandPath

#region Visual Studio
function Test-VisualStudioInstalled {
    $tempDir = [System.IO.Path]::GetTempPath()
    $vswhereTarget = "${tempDir}\vswhere.exe"
    $url = "https://github.com/microsoft/vswhere/releases/download/2.8.4/vswhere.exe"

    (New-Object System.Net.WebClient).DownloadFile($url, $vswhereTarget)

    $path = "${vswhereTarget} -version '[16.5,17.0)' -property installationPath" | Invoke-Expression
    return $null -ne $path
}

function Install-VisualStudio([string] $edition = "community") {
    $tempDirectory = [System.IO.Path]::GetTempPath()
    $name = "vs_${edition}.exe"
    $url = "https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=$edition"
    $targetFile = "${tempDirectory}\${name}"

    (New-Object System.Net.WebClient).DownloadFile($url, $targetFile)

    $scriptDirectory = Split-Path -Parent $PSCommandPath
    "${targetFile} --lang en-US --config ${scriptDirectory}\.vsconfig" | Invoke-Expression
}
#endregion

#region Scoop
function Install-Scoop {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh') 
    scoop bucket add extras
}

function Install-ScoopPackages {
    scoop install `
        llvm `
        sudo `
        git-with-openssh
}

function Set-LibclangPath {
    $path = "${env:USERPROFILE}\scoop\apps\llvm\current\bin"
    [System.Environment]::SetEnvironmentVariable("LIBCLANG_PATH", $path) # Set permanently
    $env:LIBCLANG_PATH = $path # Set in current session
}

function Update-Scoop {
    scoop update && scoop update *
}
#endregion

#region Rust
function Install-Rustup {
    $tempDirectory = [System.IO.Path]::GetTempPath()
    $url = "https://win.rustup.rs/x86_64"
    $target = "${tempDirectory}\rustup-init.exe"

    Start-BitsTransfer -Source $url -Destination $target -Description "Downloading Rustup Installer"

    & $target --profile "default" --default-toolchain stable -y
}

function Update-Rust {
    rustup update
}

function Install-CargoPackages {
    cargo install `
        starship `
        fd-find `
        bat `
        broot `
        kondo kondo-ui `
        hx `
}
#endregion

#region Fonts
function Install-CascadiaFonts {
    $objShell = New-Object -ComObject Shell.Application
    $objFolder = $objShell.Namespace(0x14)

    $tempFolder = [System.IO.Path]::GetTempPath()
    $tempFonts = Join-Path $tempFolder "fonts"
    if (-not (Test-Path $tempFonts)) {
        New-Item -ItemType Directory -Path $tempFonts
    }
   
    $fonts = @(
        @{ file = "Cascadia.ttf"; name = "Cascadia Code Regular" }
        @{ file = "CascadiaMono.ttf"; name = "Cascadia Mono Regular" }
        @{ file = "CascadiaMonoPL.ttf"; name = "Cascadia Mono PL Regular" }
        @{ file = "CascadiaPL.ttf"; name = "Cascadia Code PL Regular" }
    )

    foreach($font in $fonts) {
        if ((Test-Path "C:\Windows\Fonts\${font.name}") -eq $false)
        {
            $url = "https://github.com/microsoft/cascadia-code/releases/download/v1911.21/${font.file}"
            $target = Join-Path $tempFonts ${font.name}
            
            (New-Object System.Net.WebClient).DownloadFile($url, $target)

            $objFolder.CopyHere($target, 0x10)
        }
    }
}

$isDotSourced = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''
if ($isDotSourced) { return }

#region Installation
$vsInstalled = Test-VisualStudioInstalled
if (!$vsInstalled) {
    Install-VisualStudio
}

$scoopInstalled = Get-Command "scoop" -ErrorAction SilentlyContinue 
if (!$scoopInstalled) {
    Install-Scoop && Install-ScoopPackages && Set-LibclangPath
}

$rustInstalled = Get-Command "rustup" -ErrorAction SilentlyContinue
if (!$rustInstalled) {
    Install-Rustup
}

Update-Scoop
Update-Rust && Install-CargoPackages
#endregion

#region Configure Windows
Install-CascadiaFonts

$wslInstalled = Get-Command "wsl" -ErrorAction SilentlyContinue
if (!$wslInstalled) {
    Start-Process -Verb RunAs pwsh.exe -Wait './setup-admin.ps1'
    wsl --set-default-version 2
}
#endregion

Copy-Item -Path "${scriptDirectory}\.profile.ps1" -Destination $PROFILE
Copy-Item -Path "${scriptDirectory}\windows-terminal.jsonc" -Destination "${env:LocalAppData}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"