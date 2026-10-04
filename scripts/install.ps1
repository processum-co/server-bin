# ==============================================================================
# Processum Server — Instalador Automatizado para Windows
# ==============================================================================

[CmdletBinding()]
param(
    [string]$TargetDir = ".\bin"
)

$ErrorActionPreference = "Stop"

$repo = "processum-co/server-bin"
$binaryName = "processum-server-windows-x64.exe"

if (!(Test-Path -Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

Write-Host "Consultando ultima version publicada en $repo..."
try {
    $releaseUrl = "https://api.github.com/repos/$repo/releases/latest"
    $response = Invoke-RestMethod -Uri $releaseUrl -Headers @{"User-Agent"="Processum-Installer"}
    $latestTag = $response.tag_name
} catch {
    Write-Warning "No se pudo obtener informacion de releases desde GitHub API: $_"
    $latestTag = $null
}

if ($latestTag) {
    $downloadUrl = "https://github.com/$repo/releases/download/$latestTag/$binaryName"
    $outputPath = Join-Path $TargetDir $binaryName
    Write-Host "Descargando $binaryName desde $downloadUrl..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath
    Write-Host "Instalacion completada con exito en: $outputPath"
} else {
    Write-Host "Para ejecucion local, coloque el ejecutable $binaryName directamente en la carpeta $TargetDir"
}
