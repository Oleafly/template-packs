# GitHub 连接与同步说明

## 1. 当前连接状态

当前仓库已经配置 GitHub 远端：

- 远端名：`origin`
- 远端地址：`https://github.com/Jackknifer/jluthesis-template.git`
- 默认分支：`main`

这说明仓库已经和 GitHub 建立了基础连接，不需要重新初始化 Git。

## 2. 推荐同步方式

推荐优先使用仓库内置脚本：

```powershell
powershell -ExecutionPolicy Bypass -File "scripts/sync_project_to_github.ps1" -Message "你的提交说明"
```

脚本会尽量按保守流程处理：

1. 检查当前仓库是否处于 merge / rebase 中。
2. 默认只提交你已经显式 `git add` 过的改动。
3. 如果存在未暂存或未跟踪文件，则停止并提示你先确认范围。
4. 只有显式传入 `-StageAll` 时，才会执行全量暂存。
5. 拉取远端最新信息。
6. 如果只是远端领先，则尝试快进拉取。
7. 如果只是本地领先，则直接推送。
8. 如果本地和远端已经分叉，则停止并提示人工处理。

## 3. 推荐的日常命令

### 查看状态

```powershell
git status
```

### 提交并同步

```powershell
git add README.md docs/GITHUB_SYNC.md
powershell -ExecutionPolicy Bypass -File "scripts/sync_project_to_github.ps1" -Message "docs: 更新 README 与同步说明"
```

### 明确要把当前所有改动一起提交

```powershell
powershell -ExecutionPolicy Bypass -File "scripts/sync_project_to_github.ps1" -StageAll -Message "chore: 打包当前全部改动"
```

### 只看状态，不执行同步

```powershell
powershell -ExecutionPolicy Bypass -File "scripts/sync_project_to_github.ps1" -StatusOnly
```

## 4. 冲突处理原则

如果脚本提示“本地与远端已经分叉”，不要直接强推。推荐按下面顺序处理：

1. `git status`
2. `git fetch origin`
3. `git pull --rebase origin main` 或手动 merge
4. 解决冲突并验证
5. `git push origin main`

如果脚本提示存在“未暂存或未跟踪文件”，推荐按下面顺序处理：

1. `git status`
2. `git add <你确认要提交的文件>`
3. 运行同步脚本并传入 `-Message`
4. 如果你确认所有改动都应该一起提交，再改用 `-StageAll`

对于这个仓库，最容易冲突的文件通常是：

- `README.md`
- `jluthesis.cls`
- `main.tex`

## 5. safe.directory 问题

如果 Git 提示类似 `detected dubious ownership`，说明当前执行 Git 的账户和仓库所有者不同。可以在本机执行：

```powershell
git config --global --add safe.directory "D:/synthesis documents/毕业论文/MyThesis"
```

这是 Git 的安全检查，不代表仓库损坏。

## 6. 是否要换到新的 GitHub 仓库

如果你后续打算把这个项目推到你自己的新仓库，而不是当前远端，可以执行：

```powershell
git remote set-url origin https://github.com/<your-name>/<your-repo>.git
```

执行前请先确认目标仓库地址，避免误推送到错误仓库。
