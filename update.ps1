<#
Copies the generated site files from the Choice Battle White repository into this one,
keeping the repository root as the site root.

Regenerate them in the other repository first:
    cd ..\Choice Battle White
    python dev/items/pipeline.py

Then, from this repository's root:
    pwsh -NoProfile -File update.ps1
    pwsh -NoProfile -File update.ps1 -Source 'D:\outro\caminho\Choice Battle White'
#>
param(
    [string]$Source = (Join-Path (Split-Path -Parent $PSScriptRoot) 'Choice Battle White')
)

$ErrorActionPreference = 'Stop'
if (-not (Test-Path $Source)) { throw "source repository not found: $Source" }

$files = @(
    'docs/index.html',
    'docs/items_grid.html',
    'docs/items_database.csv',
    'docs/items_build.json',
    'docs/.nojekyll',
    'docs/artifacts/loading-screen-preview.jpg',
    'docs/artifacts/loading-screen-preview.png'
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
