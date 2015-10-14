# Make sure we're in a reasonable execution policy
if(Get-ExecutionPolicy -ne 'Unrestricted')
{
	Start-Process powershell -ArgumentList '-noprofile Set-ExecutionPolicy unrestricted -s cu' -verb RunAs
}

# Check if scoop exists, install if no
if (Get-Command 'scoop' -errorAction SilentlyContinue -eq '')
{
	iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

# We need git to successfully use scoop
scoop install git
scoop bucket add extras
scoop update

# Sudo approximates the *nix command
scoop install sudo

# Basic utils
scoop install 7zip curl hub vim shasum sysinternals

# Programming languages
scoop install rust go python python27 dnvm