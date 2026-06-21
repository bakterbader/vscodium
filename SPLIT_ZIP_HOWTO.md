# Split Zip HOWTO

This splits the RasterAndonConfigurator build zip into smaller parts using 7-Zip on Windows.

## Source Zip

```text
D:\home\norbert.farkas\src\vscodium\assets\RasterAndonConfigurator-win32-x64-1.121.04025.zip
```

## Create 500 MB Parts

Run in PowerShell:

```powershell
cd D:\home\norbert.farkas\src\vscodium\assets

& "C:\Program Files\7-Zip\7z.exe" a -tzip -v500m `
  RasterAndonConfigurator-win32-x64-1.121.04025-split.zip `
  RasterAndonConfigurator-win32-x64-1.121.04025.zip
```

Expected output files:

```text
RasterAndonConfigurator-win32-x64-1.121.04025-split.zip.001
RasterAndonConfigurator-win32-x64-1.121.04025-split.zip.002
...
```

## Extract Split Parts

Keep all parts in the same folder. Extract only the first part:

```powershell
cd D:\home\norbert.farkas\src\vscodium\assets

& "C:\Program Files\7-Zip\7z.exe" x RasterAndonConfigurator-win32-x64-1.121.04025-split.zip.001
```

## Different Part Size

Change `-v500m` to another size:

```text
-v100m   100 MB parts
-v250m   250 MB parts
-v1g     1 GB parts
```

Example:

```powershell
& "C:\Program Files\7-Zip\7z.exe" a -tzip -v250m `
  RasterAndonConfigurator-win32-x64-1.121.04025-split.zip `
  RasterAndonConfigurator-win32-x64-1.121.04025.zip
```
