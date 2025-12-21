param (
    [Parameter(Mandatory = $false)]
    [string]$Configuration
)

if ($Configuration -ne "Debug" -and $Configuration -ne "Release") {
    [Console]::Error.WriteLine("Usage: $PSCommandPath (Debug|Release)")
    exit 1
}

function Get-MetadataValue {
    param (
        [Parameter(Mandatory)]
        [string]$FilePath,

        [Parameter(Mandatory)]
        [string]$DefineName
    )

    $pattern = "^\s*#define\s+$DefineName\s+""([^""]+)"""
    $match = Select-String -Path $FilePath -Pattern $pattern

    if (-not $match) {
        throw "Can't find $DefineName in $FilePath"
    }

    return $match.Matches[0].Groups[1].Value
}

function Copy-WithStructure {
    param (
        [Parameter(Mandatory)]
        [string[]]$Paths,

        [Parameter(Mandatory)]
        [string]$DestinationRoot
    )

    foreach ($path in $Paths) {
        if (Test-Path $path -PathType Container) {
            # Folders case
            $relative = Resolve-Path $path | ForEach-Object { $_.Path.Substring((Get-Location).Path.Length + 1) }
            Copy-Item $path -Destination (Join-Path $DestinationRoot $relative) -Recurse -Force
        }
        else {
            # Globs or files case
            Get-ChildItem $path -File -ErrorAction SilentlyContinue | ForEach-Object {
                $relative = $_.FullName.Substring((Get-Location).Path.Length + 1)
                $dest = Join-Path $DestinationRoot $relative
                New-Item -ItemType Directory -Path (Split-Path $dest) -Force | Out-Null
                Copy-Item $_.FullName -Destination $dest -Force
            }
        }
    }
}

$metadata_h = "include/metadata.h"

$version = Get-MetadataValue -FilePath $metadata_h -DefineName "LIB_VERSION_STR"
$progname = "build-dep"
$prettyos = "Windows"
$artifact = "$progname-$version-$prettyos-$Configuration"

Remove-Item "artifacts/$artifact" -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force "artifacts/$artifact" | Out-Null


$logs = @(
	"configure-$progname.log"
)
$headers = @(
		"lib/ui/dear_bindings_generated/*.h",
		"lib/ui/imgui/*.h",
		"lib/ui/dear_bindings_generated/backends/*.h",
		"lib/ui/imgui/backends/*.h",
		"lib/ecs/flecs/*.h"
)
$libs = @(
	"lib/ui/x64/$Configuration",
	"lib/ecs/x64/$Configuration",
	"lib/platform/sdl3-devel-vc"
)
Copy-WithStructure -Paths $($libs; $headers; $logs) -DestinationRoot "artifacts/$artifact"
Write-Output "artifact=$artifact"
