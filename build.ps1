param (
    [Parameter(Mandatory = $false)]
    [string]$Configuration
)

if ($Configuration -ne "Debug" -and $Configuration -ne "Release") {
    [Console]::Error.WriteLine("Usage: $PSCommandPath (Debug|Release)")
    exit 1
}

# MSBuild can came from VS2022 Community edition on a local dev computer, or VS2022 Enterprise on GitHub for exemple.
$msbuild = Get-ChildItem `
    -Path "C:\Program Files\Microsoft Visual Studio\2022\*\MSBuild\Current\Bin\MSBuild.exe" `
    -ErrorAction SilentlyContinue |
    Select-Object -First 1

if (-not $msbuild) {
    [Console]::Error.WriteLine("MSBuild introuvable.")
    exit 1
}

# powershell "&" is call operator, not unix background task meta-character
& $msbuild.FullName lib.sln "-p:Configuration=$Configuration"
