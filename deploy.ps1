# Blaze 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/indexable-inc/blaze/blob/main/README.md
# 更新日期：2026-10-28
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

if (-not (Get-Command wsl -ErrorAction SilentlyContinue)) { throw 'Blaze 没有 Windows 原生安装器：请先安装 WSL2，或在 macOS Apple Silicon / Linux 上使用' }
wsl -e bash -lc "curl -fsSL https://ix.dev/blaze | sh"
wsl -e bash -lc "command -v blaze >/dev/null 2>&1" ; if ($LASTEXITCODE -ne 0) { throw 'WSL 里没有找到 blaze，请重开终端后重试' }
Write-Host '安装完成：在 WSL 的 Rust 项目里运行 blaze build / blaze test / blaze run'

Write-Host ''

Write-Host '安装完成：在 Rust 项目里运行 blaze build / blaze test / blaze run；Windows 请在 WSL2 里使用'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/indexable-inc/blaze/blob/main/README.md'
