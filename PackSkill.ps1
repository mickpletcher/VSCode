<#
.SYNOPSIS
Packages one or more Claude skill folders into skill.zip archives.

.DESCRIPTION
Reads each skill folder's skill.md, discovers local file references, stages the
referenced files, and creates skill.zip in that folder.

Default behavior packages all folders under Root recursively that contain
skill.md.

.PARAMETER SkillDir
Path to a single skill folder to package.

.PARAMETER Root
Repository root used when scanning for all skill folders.

.PARAMETER All
When set, package all folders under Root recursively that contain skill.md.

.PARAMETER WhatIf
Preview mode. Shows what would be packaged without writing zip files.

.PARAMETER SelfTest
Runs lightweight path handling tests and exits.

.EXAMPLE
pwsh -NoProfile -File .\PackSkill.ps1 -All
Packages all skill folders under the current location recursively.

.EXAMPLE
pwsh -NoProfile -File .\PackSkill.ps1 -SkillDir .\Facebook Post
Packages one skill folder.

.EXAMPLE
pwsh -NoProfile -File .\PackSkill.ps1 -All -WhatIf
Shows packaging actions without creating archives.

.EXAMPLE
pwsh -NoProfile -File .\PackSkill.ps1 -SelfTest
Runs self tests for helper path logic.
#>
param(
    [string]$SkillDir,
    [string]$Root = (Get-Location).Path,
    [switch]$All,
    [switch]$WhatIf,
    [switch]$SelfTest
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Returns a path relative to BasePath when possible; otherwise returns only the leaf name.
function Get-RelativePath {
    param(
        [string]$BasePath,
        [string]$TargetPath
    )

    $base = (Resolve-Path -LiteralPath $BasePath).Path
    $target = (Resolve-Path -LiteralPath $TargetPath).Path

    if ($target.StartsWith($base, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $target.Substring($base.Length).TrimStart([char]'\', [char]'/')
    }

    return Split-Path -Path $target -Leaf
}

# Parses Markdown and HTML references in skill.md and returns existing local files only.
function Get-ReferencedLocalFiles {
    param(
        [string]$SkillMarkdownPath,
        [string]$SkillFolder
    )

    $content = Get-Content -LiteralPath $SkillMarkdownPath -Raw
    $results = New-Object System.Collections.Generic.List[string]

    $patterns = @(
        '!\[.*?\]\((.*?)\)',
        '\[.*?\]\((.*?)\)',
        'src=[''\"]([^''\"\)]+)[''\"]',
        'href=[''\"]([^''\"\)]+)[''\"]'
    )

    foreach ($pattern in $patterns) {
        $regexHits = [regex]::Matches($content, $pattern)
        foreach ($match in $regexHits) {
            $ref = $match.Groups[1].Value.Trim()
            if ([string]::IsNullOrWhiteSpace($ref)) { continue }
            if ($ref -match '^https?://') { continue }
            if ($ref.StartsWith('#')) { continue }

            $fullPath = Join-Path $SkillFolder $ref
            if (Test-Path -LiteralPath $fullPath) {
                $resolved = (Resolve-Path -LiteralPath $fullPath).Path
                if (-not $results.Contains($resolved)) {
                    [void]$results.Add($resolved)
                }
            }
        }
    }

    return $results
}

# Runs simple checks for path helper behavior against known files in the repository.
function Invoke-SelfTest {
    param(
        [string]$RepoRoot
    )

    $skillFolder = Join-Path $RepoRoot 'PiHole'
    $skillFile = Join-Path $skillFolder 'skill.md'
    $rootScript = Join-Path $RepoRoot 'PackSkill.ps1'

    if (-not (Test-Path -LiteralPath $skillFile)) {
        throw "Self test failed because test input file was not found: $skillFile"
    }

    if (-not (Test-Path -LiteralPath $rootScript)) {
        throw "Self test failed because root script was not found: $rootScript"
    }

    $inside = Get-RelativePath -BasePath $skillFolder -TargetPath $skillFile
    if ($inside -ne 'skill.md') {
        throw "Self test failed for in-folder relative path. Expected skill.md but got: $inside"
    }

    $outside = Get-RelativePath -BasePath $skillFolder -TargetPath $rootScript
    if ($outside -ne 'PackSkill.ps1') {
        throw "Self test failed for out-of-folder fallback. Expected PackSkill.ps1 but got: $outside"
    }

    Write-Host 'Self test passed.'
}

# Stages skill.md plus local referenced files, then creates skill.zip in the skill folder.
function Compress-SkillFolder {
    param(
        [string]$FolderPath,
        [switch]$PreviewOnly
    )

    $skillMdPath = Join-Path $FolderPath 'skill.md'
    if (-not (Test-Path -LiteralPath $skillMdPath)) {
        Write-Warning "Skipping $FolderPath because skill.md is missing."
        return
    }

    $outputPath = Join-Path $FolderPath 'skill.zip'
    $filesToZip = New-Object System.Collections.Generic.List[string]
    [void]$filesToZip.Add((Resolve-Path -LiteralPath $skillMdPath).Path)

    $referenced = Get-ReferencedLocalFiles -SkillMarkdownPath $skillMdPath -SkillFolder $FolderPath
    foreach ($item in $referenced) {
        if (-not $filesToZip.Contains($item)) {
            [void]$filesToZip.Add($item)
        }
    }

    if ($PreviewOnly) {
        Write-Host "Would package $FolderPath -> $outputPath"
        return
    }

    # Ensure stale archive is removed before creating a new one.
    if (Test-Path -LiteralPath $outputPath) {
        Remove-Item -LiteralPath $outputPath -Force
        Write-Host "Removed existing archive at $outputPath"
    }

    $folderFull = (Resolve-Path -LiteralPath $FolderPath).Path
    $staging = Join-Path $env:TEMP ("skillpack-" + [guid]::NewGuid().ToString())
    New-Item -ItemType Directory -Path $staging | Out-Null

    foreach ($file in $filesToZip) {
        $entryName = Get-RelativePath -BasePath $folderFull -TargetPath $file
        $dest = Join-Path $staging $entryName
        $destDir = Split-Path -Path $dest -Parent
        if (-not (Test-Path -LiteralPath $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }
        Copy-Item -LiteralPath $file -Destination $dest -Force
    }

    Compress-Archive -Path (Join-Path $staging '*') -DestinationPath $outputPath -Force
    Remove-Item -LiteralPath $staging -Recurse -Force

    Write-Host "Packaged skill to $outputPath"
}

$rootPath = (Resolve-Path -LiteralPath $Root).Path

if ($SelfTest) {
    Invoke-SelfTest -RepoRoot $rootPath
    exit 0
}

# Default behavior is to package all skills unless a specific folder is supplied.
if (-not $All -and -not $SkillDir) {
    $All = $true
}

if ($All) {
    $skillFiles = Get-ChildItem -LiteralPath $rootPath -Recurse -File | Where-Object {
        $_.Name -ieq 'skill.md'
    }

    $folders = $skillFiles | ForEach-Object {
        $_.Directory
    } | Sort-Object -Property FullName -Unique

    if ($folders.Count -eq 0) {
        Write-Warning "No skill folders found under $rootPath"
        exit 0
    }

    foreach ($folder in $folders) {
        Compress-SkillFolder -FolderPath $folder.FullName -PreviewOnly:$WhatIf
    }

    exit 0
}

if (-not $SkillDir) {
    $SkillDir = $PWD.Path
}

$resolvedSkillDir = (Resolve-Path -LiteralPath $SkillDir).Path
Compress-SkillFolder -FolderPath $resolvedSkillDir -PreviewOnly:$WhatIf
