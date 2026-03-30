param(
    [string]$Directory = "",
    [int]$Width = 1200,
    [int]$Height = 630
)

Add-Type -AssemblyName System.Drawing

if ($Directory -eq "") {
    $Directory = Read-Host "Please enter directory path"
}

if (-not (Test-Path $Directory)) {
    Write-Host "Error: Directory not found - $Directory" -ForegroundColor Red
    return
}

$supportedExtensions = @('.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.tiff', '.tif')

$deletedCount = 0
$totalCount = 0
$filesToDelete = @()

Write-Host "Scanning directory: $Directory"
Write-Host "Target size: " -NoNewline
Write-Host "$Width x $Height" -ForegroundColor Cyan
Write-Host "------------------------------------------------------------"

$files = Get-ChildItem -Path $Directory -File

foreach ($file in $files) {
    $ext = [System.IO.Path]::GetExtension($file.Name).ToLower()
    
    if ($ext -notin $supportedExtensions) {
        continue
    }
    
    $totalCount++
    
    try {
        $img = [System.Drawing.Image]::FromFile($file.FullName)
        $sizeInfo = "$($img.Width) x $($img.Height)"
        $isMatch = ($img.Width -eq $Width -and $img.Height -eq $Height)
        
        if ($isMatch) {
            Write-Host "[MATCH] $($file.Name) ($sizeInfo)" -ForegroundColor Yellow
            $filesToDelete += $file.FullName
        } else {
            Write-Host "[SKIP] $($file.Name) ($sizeInfo)" -ForegroundColor Gray
        }
        
        $img.Dispose()
        [GC]::Collect()
    } catch {
        Write-Host "[ERROR] $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "------------------------------------------------------------"

if ($filesToDelete.Count -gt 0) {
    Write-Host "Deleting $($filesToDelete.Count) matched file(s)..." -ForegroundColor Cyan
    foreach ($filePath in $filesToDelete) {
        try {
            Remove-Item -Path $filePath -Force
            Write-Host "  Deleted: $filePath" -ForegroundColor Green
            $deletedCount++
        } catch {
            Write-Host "  Failed to delete: $filePath" -ForegroundColor Red
            Write-Host "    Error: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host "------------------------------------------------------------"
Write-Host "Scan completed!" -ForegroundColor Cyan
Write-Host "Total images checked: $totalCount"
Write-Host "Images deleted: $deletedCount" -ForegroundColor $(if ($deletedCount -gt 0) { "Yellow" } else { "Gray" })
Write-Host "Images kept: $($totalCount - $deletedCount)"
