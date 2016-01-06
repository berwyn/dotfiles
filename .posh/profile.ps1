[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Load PsGet modules
import-module PsGet
import-module posh-git

if((Get-PackageProvider | grep Choco) -eq '')
{
    Get-PackageSource -Name chocolatey -SkipValidate
}

# Shim cmder values onto the path
$env:PATH += ";$env:CMDER_ROOT\bin";
$env:PATH += ";$env:GOPATH\bin";
$env:PATH += ";$env:SCOOP\shims";

function reload
{
    . $PROFILE
}

function is-admin 
{
    return (
        new-object Security.Principal.WindowsPrincipal(
            [Security.Principal.WindowsIdentity]::GetCurrent()
        )
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function git-prompt
{
    $status = get-gitstatus
    $statusColor = [ConsoleColor]::Cyan
    
    if(!$status)
    {
        return
    }

    Write-Host " (" -n -f $statusColor
    Write-Host $status.Branch -n -f $statusColor
    Write-Host " " -n
    
    if((!$status.HasUntracked) -and
        ($status.AheadBy -eq 0) -and
        ($status.BehindBy -eq 0) -and
        (!$status.HasWorking) -and
        (!$status.HasIndex))
    {
        Write-Host ([char]0x2713) -n -f $statusColor
    }
    else
    {
        $needsSpace = $false
        if($status.AheadBy -ne 0)
        { 
            $needsSpace = $true
            Write-Host "+" -n -f $statusColor
            Write-Host $status.AheadBy -n -f $statusColor
        }
        
        if($needsSpace)
        {
            Write-Host " " -n
            $needsSpace = $false
        }
        
        if($status.BehindBy -ne 0)
        {
            $needSpace = $true
            Write-Host "-" -n -f $statusColor
            Write-Host $status.BehindBy -n -f $statusColor
        }
        
        if($needsSpace)
        {
            Write-Host " " -n
        }
        
        if($status.HasUntracked)
        {
            Write-Host "?" -n -f $statusColor
        }
        
        if($status.HasWorking -or $status.HasIndex)
        {
            Write-Host "!" -n -f $statusColor
        }
    }
    
    Write-Host ")" -n -f $statusColor
}

function prompt
{
    $isAdmin = is-admin
    $activeColor = [ConsoleColor]::Yellow
    $passiveColor = [ConsoleColor]::DarkGray
    
    # If we're in the registry, note that
    if($pwd.Provider.Name -ne 'FileSystem')
    {
        Write-Host '<' -n -f $passiveColor
        Write-Host $pwd.Provider.Name -n -f Gray
        Write-Host '> ' -n -f $passiveColor
    }

    Write-Host ($pwd.Path -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2') -n -f $activeColor
    
    # Add git info to prompt
    git-prompt
    
    if($isAdmin)
    {
       Write-Host " #" -n -f $passiveColor
    }
    else
    {
        Write-Host " $" -n -f $passiveColor
    }
    
    return " "
}

# Git aliases
function wow { git status }
set-alias very "git"
set-alias many "git"
set-alias such "git"
set-alias much "git"
set-alias so "git"

function Invoke-BatchFile 
{
    param([string] $Path, [string] $Parameters)
 
    $tempFile = [IO.Path]::GetTempFileName()
 
    ## Store the output of cmd.exe.  We also ask cmd.exe to output
    ## the environment table after the batch file completes
    cmd.exe /c " `"$Path`" $Parameters && set > `"$tempFile`" "
 
    ## Go through the environment variables in the temp file.
    ## For each of them, set the variable in our local environment.
    Get-Content $tempFile | Foreach-Object {
        if ($_ -match "^(.*?)=(.*)$")
        {
           Set-Content "env:\$($matches[1])" $matches[2]  
        }
    }
 
    Remove-Item $tempFile
}
 
function Enable-VSPrompt($ver = 14, $arch = "x64")
{
    $path = "C:\Program Files (x86)\Microsoft Visual Studio $ver.0\VC\vcvarsall.bat"
    Invoke-BatchFile $path $arch
}

clear-host
