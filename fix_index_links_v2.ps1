$ErrorActionPreference = "Stop"

Write-Host "== Updating references from INDEX.md to index.md (literal replace, UTF-8) ==" -ForegroundColor Cyan

$replacements = @{
    "Book05_OperatorsAtlas/INDEX.md" = "Book05_OperatorsAtlas/index.md"
    "Book09_PhoenixArchive/INDEX.md" = "Book09_PhoenixArchive/index.md"
}

$files = @(
    "docs/codex/plates/index.md",
    "docs/index.md",
    "mkdocs.yml"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText((Resolve-Path $file), [System.Text.Encoding]::UTF8)
        $original = $content
        foreach ($key in $replacements.Keys) {
            $content = $content.Replace($key, $replacements[$key])
        }
        if ($content -ne $original) {
            $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
            [System.IO.File]::WriteAllText((Resolve-Path $file), $content, $utf8NoBom)
            Write-Host "Updated: $file" -ForegroundColor Green
        } else {
            Write-Host "Still no match found in: $file" -ForegroundColor Red
        }
    } else {
        Write-Host "WARNING: file not found: $file" -ForegroundColor Red
    }
}

git add docs/codex/plates/index.md docs/index.md mkdocs.yml
Write-Host "Done. Review with git status / git diff --cached"