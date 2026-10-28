#!/usr/bin/env bash
set -euo pipefail
# Blaze 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/indexable-inc/blaze/blob/main/README.md
# 更新日期：2026-10-28
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

curl -fsSL https://ix.dev/blaze | sh
command -v blaze >/dev/null 2>&1 || { echo "安装后没找到 blaze，请重开终端或检查 PATH"; exit 1; }
echo "安装完成：在 Rust 项目里运行 blaze build / blaze test / blaze run"

echo ""

echo "安装完成：在 Rust 项目里运行 blaze build / blaze test / blaze run；Windows 请在 WSL2 里使用"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/indexable-inc/blaze/blob/main/README.md"
