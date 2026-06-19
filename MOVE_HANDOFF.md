# Move Handoff

## Goal

Move the deployed RasterAndonConfigurator project from:

```text
D:\kb\home.norbert.farkas\cdx
```

to:

```text
D:\kb\home\norbert.farkas
```

## Current Blocker

The move failed because files in the old folder were locked by running processes:

```text
RasterAndonConfigurator.exe
codex
OpenConsole
```

Close all RasterAndonConfigurator windows and terminals launched from that app before moving the folder.

## Expected Layout Before Move

```text
D:\kb\home.norbert.farkas\cdx
├─ home
├─ RasterAndonConfigurator
├─ run.ps1
├─ set_and_test.ps1
├─ test.ps1
└─ unset.ps1
```

## Expected Layout After Move

```text
D:\kb\home\norbert.farkas
├─ home
├─ RasterAndonConfigurator
├─ run.ps1
├─ set_and_test.ps1
├─ test.ps1
└─ unset.ps1
```

## Important Script Behavior

`run.ps1` is script-relative and should continue working after the move:

```powershell
$scriptDir = Split-Path -Parent $PSCommandPath
$env:CODEX_HOME = Join-Path $scriptDir 'home'

if (-not (Test-Path -LiteralPath $env:CODEX_HOME)) {
    New-Item -ItemType Directory -Path $env:CODEX_HOME | Out-Null
}

$exePath = Join-Path $scriptDir 'RasterAndonConfigurator\RasterAndonConfigurator.exe'
& $exePath
```

After the move, `CODEX_HOME` should resolve to:

```text
D:\kb\home\norbert.farkas\home
```

## Manual Move Command

Run this from a separate PowerShell window that is not inside the old folder:

```powershell
$source = "D:\kb\home.norbert.farkas\cdx"
$destination = "D:\kb\home\norbert.farkas"

New-Item -ItemType Directory -Path (Split-Path -Parent $destination) -Force | Out-Null
Move-Item -LiteralPath $source -Destination $destination
```

## Post-Move Test

```powershell
cd D:\kb\home\norbert.farkas
.\run.ps1
```

Inside the app terminal:

```powershell
$env:CODEX_HOME
```

Expected output:

```text
D:\kb\home\norbert.farkas\home
```
