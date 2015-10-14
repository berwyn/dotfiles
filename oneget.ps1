# Make sure we have NuGet and Choco package sources
Register-PackageSource -Name nuget chocolatey

# Browsers
Install-Package -Name google-chrome-x64 Firefox -ProviderName chocolatey

# TODO: VS is a clusterfuck - maybe better option?
# Text editors
Install-Package -Name VisualStudioCode Atom -ProviderName chocolatey

# Chat apps
Install-Package -Name skype telegram slack -ProviderName chocolatey

# TODO: Choco doesn't currently track JDK 8 - talk to maintainers :(
# Android SDK
Install-Package -Name AndroidStudio android-sdk -ProviderName chocolatey

# Dev tools
Install-Package -Name GitHub SourceTree -ProviderName chocolatey

# Etc
Install-Package -Name dropbox -ProviderName chocolatey