<#
Copies the generated site files from the map's source repository into this one, keeping the
repository root as the site root.

Regenerate them in the source repository first:
    cd <source repository>
    python dev/items/pipeline.py

Then, from this repository's root:
    pwsh -NoProfile -File update.ps1                 # uses the remembered source path
    pwsh -NoProfile -File update.ps1 -Source <path>  # or an explicit one

The source path is remembered in `.git/site-source.txt` (inside .git, so it is never
published) and, on a fresh clone, auto-detected only when exactly one sibling directory
contains `dev/items/pipeline.py`; with several candidates the script stops and asks for
`-Source` instead of guessing between checkouts.
#>
param(
    [string]$Source
)

$ErrorActionPreference = 'Stop'
$memory = Join-Path $PSScriptRoot '.git/site-source.txt'

if (-not $Source -and (Test-Path $memory)) {
    $Source = (Get-Content $memory -Raw).Trim()
    if ($Source) { Write-Output "source: $Source (remembered)" }
}

if (-not $Source) {
    $parent = Split-Path -Parent $PSScriptRoot
    $candidates = @(Get-ChildItem -Path $parent -Directory -ErrorAction SilentlyContinue |
        Where-Object { Test-Path (Join-Path $_.FullName 'dev/items/pipeline.py') })
    if ($candidates.Count -eq 1) {
        $Source = $candidates[0].FullName
        Write-Output "source: $Source (auto-detected)"
    } elseif ($candidates.Count -eq 0) {
        throw "no sibling directory with dev/items/pipeline.py under $parent; pass -Source <path>"
    } else {
        throw ("several candidates under {0}: {1}. Pass -Source <path>." -f `
            $parent, (($candidates | ForEach-Object { $_.Name }) -join ', '))
    }
}

if (-not (Test-Path $Source)) { throw "source repository not found: $Source" }
Set-Content -Path $memory -Value $Source -Encoding utf8

$files = @(
    'docs/index.html',
    'docs/items_grid.html',
    'docs/items_database.csv',
    'docs/items_build.json',
    'docs/.nojekyll'
)

foreach ($rel in $files) {
    $from = Join-Path $Source $rel
    if (-not (Test-Path $from)) { throw "missing in the source repository: $rel" }
    $to = Join-Path $PSScriptRoot ($rel -replace '^docs/', '')
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $to) | Out-Null
    Copy-Item $from $to -Force
    Write-Output "copied $rel"
}

Write-Output ''
git -C $PSScriptRoot status --short
