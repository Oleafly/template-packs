# Changelog

本文件用于记录这个仓库的可追踪变更，建议后续每次提交都同步更新。

遵循的记录原则：

- 先写用户能感知到的变化。
- 再写维护层面的改动。
- 尽量使用 Added / Changed / Fixed 这类稳定分类。

## [Unreleased]

### Changed

- 优化 `CONTRIBUTING.md`，使其更适合公开协作，并弱化本地维护脚本细节。

## [0.1.1] - 2026-04-24

### Changed

- 精简 `README.md` 中的写作指南与进阶定制内容，合并为“写作与定制速查”。
- 调整本地参考文献样式，使期刊名以斜体显示，同时保留数字顺序制引用与参考文献列表编号。

## [0.1.0] - 2026-04-11

### Added

- 新增 `PROJECT_MANAGEMENT.md`，统一项目目标、任务分层、里程碑和维护流程。
- 新增 `docs/GITHUB_SYNC.md`，说明 GitHub 远端连接、同步命令和冲突处理方式。
- 新增 `scripts/sync_project_to_github.ps1`，用于保守地执行提交、拉取和推送。
- 新增 GitHub Issue / PR 模板，方便直接在 GitHub 上管理问题与变更。
- 新增 `CONTRIBUTING.md`，集中说明贡献方式、同步流程、公开仓库注意事项和版本发布步骤。

### Changed

- `README.md` 改为聚焦模板介绍、编译方式、写作指南和常见问题，并将维护流程移出主文档。
- `jluthesis.cls` 新增统一的 `\makecommitment` 命令，并让一级标题在正文中自动另起一页。
- `jluthesis.cls` 开始实际使用 `jluthesis.cfg` 中的摘要、关键词和承诺书配置，减少实现与文档漂移。
- `scripts/sync_project_to_github.ps1` 调整为默认只提交已暂存内容，只有显式传入 `-StageAll` 才会全量暂存。
- `README.md`、`docs/GITHUB_SYNC.md`、`PROJECT_MANAGEMENT.md` 同步更新为新的承诺书、章节分页和同步脚本用法。

### Fixed

- 清理 `README.md` 中遗留的合并冲突标记，恢复仓库到可继续同步的状态。
- `.gitignore` 补充 `*.xdv` 与 `tmp/`，避免 XeLaTeX 与本地检查产物污染工作区。
- 清理仓库根目录中的临时文件 `diff.txt` 与 `push_out.txt`。

## 历史记录

### 2026-03-23

- 更新 README 说明文档。

### 2026-03-18

- 更新参考文献说明与项目结构。
- 调整本地参考文献样式与格式逻辑。

### 2026-03-14

- 更新正文行距设置。

### 2026-03-01

- 调整封面横线长度参数。
