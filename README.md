# Blaze 一键安装指南

> 第三方部署指南 · 非 Blaze 官方仓库。官方项目：[indexable-inc/blaze](https://github.com/indexable-inc/blaze)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://github.com/indexable-inc/blaze/blob/main/README.md)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用换项目结构，让百度搭子把 blaze 装好，cargo 命令前面加一个词就能快起来。

⚠️ 官方安装器支持 macOS Apple Silicon 与 Linux（含 WSL2）。Windows 原生没有安装器，只能在 WSL2 里用。blaze 自带 Rust 工具链，首次会下载约 125–160 MB；它用内存换速度，小项目也要几 GB。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/blaze-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会运行官方安装脚本；Windows 会先确认 WSL2，再在 WSL 里安装 blaze，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## Blaze 是什么？

Blaze 是开源的1.6k stars，Apache-2.0，把 Rust 重编译压到毫秒级的构建工具（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/indexable-inc/blaze?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

在 cargo 旁边保持项目常驻编译状态：改完代码只编译改动的函数并写回 cargo 已经构建好的程序里，不再整包重新链接；支持 live edits，让运行中的程序直接换上新代码。

- 命令兼容：blaze build / test / run / fmt / clippy，和 cargo 用法一致
- 增量重编译：官方基准里比 cargo build 快 10–24 倍
- Live edits：保存后约 20 ms 把新代码送进运行中的程序
- 自带工具链：不依赖项目里 pin 的 Rust 版本
- 旁路运行：和 cargo 并存，随时可切回 cargo 验证
- 开源可审计：Apache-2.0，构建产物可验证

（来源：[官方仓库](https://github.com/indexable-inc/blaze)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 1.6k stars | 发布几天就冲上趋势榜的 Rust 构建工具 |
| 提速明显 | 官方基准里比 cargo build 快 10–24 倍 |
| 零改造 | cargo 命令前加 blaze 即可 |
| Live edits | 保存后约 20 ms 更新运行中的程序 |
| 自带工具链 | 不用改项目 pin 的 Rust 版本 |
| Apache-2.0 | 可审计、可商用 |

| 需要注意 | 说明 |
|---|---|
| Windows 无安装器 | 原生只能用 WSL2 或手动运行 |
| 吃内存 | 用内存换速度，小项目也要几 GB |
| 项目很年轻 | 边界场景可能与 cargo 不一致 |
| 首次下载大 | 自带工具链约 125–160 MB |
| 不能替代 CI | 最终验证仍应交给 cargo 与 CI |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fsSL https://ix.dev/blaze | sh
command -v blaze >/dev/null 2>&1 || { echo "安装后没找到 blaze，请重开终端或检查 PATH"; exit 1; }
echo "安装完成：在 Rust 项目里运行 blaze build / blaze test / blaze run"
```

安装包来源：[https://github.com/indexable-inc/blaze#install](https://github.com/indexable-inc/blaze#install)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认官方安装脚本、支持平台与 Windows 限制 | 已核对 2026-10-28 |
| Release v0.20261027.0 的资产清单与校验文件已核对 | 已核对 2026-10-28 |
| 未实测安装与构建（会下载完整 Rust 工具链） | 说明 2026-10-28 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-28 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

Blaze 不含 MCP；本仓库的 MCP 只提供安装步骤、平台限制与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\blaze-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 怎么用

在任意 Rust 项目里，把熟悉的 cargo 命令换成 blaze：

```bash
blaze run
blaze test
blaze build
blaze fmt
blaze clippy
```

第一次构建会完整编译一遍，之后改函数再构建就是毫秒级。想试最新版可以装 canary：

```sh
curl -fsSL https://ix.dev/blaze | sh -s -- --channel canary
```

## 其它安装方式

| 方式 | 命令 |
|---|---|
| crates.io | `cargo install blaze` |
| Nix | 见仓库 docs/install.md |
| Windows | 只能在 WSL2 里用，或按文档手动运行 |

## 什么时候别用

- 需要 CI 作为最终判据：继续用 cargo，blaze 只做本地加速
- 内存紧张：blaze 会常驻项目编译状态，小项目也要几 GB
- 依赖 nightly 特性的项目：blaze 自带工具链，行为可能与项目 pin 的版本不同

> ⚠️ 项目很年轻，官方建议保留 cargo check 或 CI 作为最终验证；出现与 cargo 不一致时先切回 cargo 复现。

## 常见坑

- 安装后找不到 blaze：重开终端，或检查 ~/.local/bin 是否在 PATH
- Windows 跑不了：没有原生安装器，改用 WSL2，或按 docs/platforms.md 手动运行
- WSL 里没装成功：确认 WSL 能联网，再执行 curl -fsSL https://ix.dev/blaze | sh
- 首次构建很慢：第一次要完整编译并下载工具链，之后才是毫秒级
- 内存被吃满：blaze 会常驻编译状态，关掉不用的项目或换更大内存
- 结果与 cargo 不一致：先用 cargo 复现，再带最小例子提 Issue
- CI 与本地表现不同：CI 继续用 cargo，blaze 只作为本地加速

## 免责声明

本仓库为第三方指南，与 Blaze 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://github.com/indexable-inc/blaze/blob/main/README.md)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
