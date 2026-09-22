# Rename downloaded files to proper extensions
# Run this in: C:\Users\Infin\OneDrive\Einstein_Engine_Engine\cold-fold-framework

$baseDir = "C:\Users\Infin\OneDrive\Einstein_Engine_Engine\cold-fold-framework"

# Map of incorrect names to correct names
$renameMap = @{
    "Comprehensive test suite · PY.txt" = "comprehensive_test_suite.py"
    "Integrated pipeline · PY.txt" = "integrated_pipeline.py"
    "Origin math verification · PY.txt" = "origin_math_verification.py"
    "Readme · MD.txt" = "README.md"
    "Runner with benchmarks · PY.txt" = "runner_with_benchmarks.py"
}

Write-Host "╔════════════════════════════════════════════════════════════════╗"
Write-Host "║  RENAMING DOWNLOADED FILES                                     ║"
Write-Host "╚════════════════════════════════════════════════════════════════╝"
Write-Host ""

cd $baseDir

foreach ($oldName in $renameMap.Keys) {
    $newName = $renameMap[$oldName]
    $oldPath = Join-Path $baseDir $oldName
    $newPath = Join-Path $baseDir $newName

    if (Test-Path $oldPath) {
        Rename-Item -Path $oldPath -NewName $newName -Force
        Write-Host "✓ Renamed: '$oldName' → '$newName'"
    } else {
        Write-Host "⚠ File not found: '$oldName'"
    }
}

Write-Host ""
Write-Host "✓ File renaming complete"
Write-Host ""
Write-Host "Next: Run the test pipeline with:"
Write-Host "  `$env:PYTHONIOENCODING = 'utf-8'"
Write-Host "  python codex_self_test_sidestepinstructor.py"