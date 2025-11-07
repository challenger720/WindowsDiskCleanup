Start-Transcript -Path "C:\Temp\UpgradeCleanupDetails.txt" -Append

# Clean up system files (like Windows.old)
Try {
    Write-Host "Running DISM cleanup..."
    Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase /Quiet
    Write-Host "DISM cleanup completed."
} Catch {
    Write-Warning "DISM cleanup failed: $_"
}

# Remove Windows.old if it still exists
$windowsOld = "C:\Windows.old"
If (Test-Path $windowsOld) {
    Try {
        Remove-Item -Path $windowsOld -Recurse -Force -ErrorAction Stop
        Write-Host "Windows.old folder deleted."
    } Catch {
        Write-Warning "Failed to delete Windows.old: $_"
    }
} else {
    Write-Host "Windows.old folder not found."
}

# Optional: Clean up SoftwareDistribution\Download (leftover updates)
Try {
    Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction Stop
    Write-Host "SoftwareDistribution Download folder cleaned."
} Catch {
    Write-Warning "Failed to clean SoftwareDistribution: $_"
}

# Delete specific upgrade ISO
$isoPath = "C:\Temp\Win11_24H2_English_x64.iso"
If (Test-Path $isoPath) {
    Try {
        Remove-Item -Path $isoPath -Force -ErrorAction Stop
        Write-Host "ISO file deleted: $isoPath"
    } Catch {
        Write-Warning "Failed to delete ISO: $_"
    }
} else {
    Write-Host "ISO file not found: $isoPath"
}
$before = (Get-PSDrive C).Free / 1GB

# ...your cleanup code...

$after = (Get-PSDrive C).Free / 1GB
$freed = $after - $before

Write-Host ("Free space before cleanup: {0:N2} GB" -f $before)
Write-Host ("Free space after cleanup:  {0:N2} GB" -f $after)
Write-Host ("Space freed:                {0:N2} GB" -f $freed)

Stop-Transcript
