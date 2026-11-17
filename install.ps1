# yreader installer for Windows (PowerShell 5.1 or later)
#
#   From a clone:      powershell -ExecutionPolicy Bypass -File install.ps1
#   Without a clone:   irm https://raw.githubusercontent.com/L1amaY0796/yreader/main/install.ps1 | iex
#
# Optional environment variables:
#   YREADER_DIR    install folder   (default: %LOCALAPPDATA%\Programs\yreader)
#   YREADER_LANG   zh or en         (skips the language question)
#   YREADER_NO_PATH  set to 1 to leave the PATH untouched
#
# This file is kept ASCII-only on purpose: Windows PowerShell 5.1 misreads
# UTF-8 scripts that have no byte-order mark.

$ErrorActionPreference = 'Stop'
$url = 'https://raw.githubusercontent.com/L1amaY0796/yreader/main/yreader'
$dir = $env:YREADER_DIR
if (-not $dir) { $dir = Join-Path $env:LOCALAPPDATA 'Programs\yreader' }

# --- find Python 3.7+ -------------------------------------------------------
$py = $null
foreach ($cand in 'py -3', 'python', 'python3') {
    $parts = $cand.Split(' ')
    $rest = @($parts | Select-Object -Skip 1)
    try {
        $ver = (& $parts[0] @rest --version 2>&1 | Out-String)
        if ($ver -match 'Python 3\.(\d+)' -and [int]$Matches[1] -ge 7) { $py = $cand; break }
    } catch { }
}
if (-not $py) {
    Write-Host 'yreader needs Python 3.7 or later, which was not found.' -ForegroundColor Red
    Write-Host 'Install it from https://www.python.org/downloads/ (or: winget install Python.Python.3.13)'
    Write-Host 'and run this installer again.'
    return
}

# --- language ---------------------------------------------------------------
$lang = $env:YREADER_LANG
if ($lang -ne 'zh' -and $lang -ne 'en') {
    $def = '2'
    if ((Get-UICulture).Name -like 'zh*') { $def = '1' }
    Write-Host 'Select interface language:'
    Write-Host '  1) Traditional Chinese'
    Write-Host '  2) English'
    $ans = Read-Host "[1/2] (default $def)"
    if (-not $ans) { $ans = $def }
    if ($ans -eq '1' -or $ans -like 'zh*') { $lang = 'zh' } else { $lang = 'en' }
}

# --- install ----------------------------------------------------------------
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$target = Join-Path $dir 'yreader'
$local = $null
if ($PSScriptRoot) { $local = Join-Path $PSScriptRoot 'yreader' }
if ($local -and (Test-Path -LiteralPath $local)) {
    Copy-Item -LiteralPath $local -Destination $target -Force
} else {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $target
}

# yreader.cmd lets you type "yreader book.epub" in PowerShell and cmd alike,
# and is not affected by the PowerShell script execution policy.
$cmd = Join-Path $dir 'yreader.cmd'
Set-Content -LiteralPath $cmd -Encoding ASCII -Value @(
    '@echo off',
    "$py `"%~dp0yreader`" %*"
)

# --- PATH -------------------------------------------------------------------
$onPath = $true
if ($env:YREADER_NO_PATH -ne '1') {
    $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
    if (-not $userPath) { $userPath = '' }
    $onPath = $userPath.Split(';') | Where-Object { $_.TrimEnd('\') -ieq $dir.TrimEnd('\') }
    if (-not $onPath) {
        [Environment]::SetEnvironmentVariable('Path', ($userPath.TrimEnd(';') + ';' + $dir).TrimStart(';'), 'User')
    }
    if (-not ($env:Path.Split(';') | Where-Object { $_.TrimEnd('\') -ieq $dir.TrimEnd('\') })) {
        $env:Path = $env:Path.TrimEnd(';') + ';' + $dir
    }
}

& $cmd --lang $lang
Write-Host "Installed to $dir"
Write-Host 'Usage: yreader book.epub'
Write-Host 'Change the language any time with: yreader --lang zh   (or press L while reading)'
if (-not $onPath) {
    Write-Host 'The folder was added to your PATH; other terminal windows need to be reopened to see it.'
}
