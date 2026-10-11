#import "@preview/ergo:0.2.0": *
#import "../../notebook.typ" as nb

#show: nb.notebook.with(
  title: "Git 与 GitHub 常用指令",
  author: "Your Name",
  short-title: [Chapter 5 · Git and GitHub],
  colors: ergo-colors.bootstrap,
  styles: ergo-styles.sidebar1,
)

#let chapter-content = [
#counter(heading).update(4)
#nb.chapter(
  [Git 与 GitHub 常用指令],
  subtitle: [从本地仓库初始化、首次发布，到分支、PR、同步、冲突、撤销与日常维护。],
  key: "ch-git-github",
)

#bookmark[适用范围 / Scope][Git 2.28+ · GitHub · CLI workflow]

#nb.note[先记住这一条][
  若要暂存仓库中的*全部变化*，包括新增、修改和删除，使用 `git add -A`。
  执行前先看 `git status`，执行后再看 `git diff --cached`，确认没有密钥、缓存或无关文件。
]

== 核心模型 / Mental Model

#table(
  columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr),
  inset: 5pt,
  stroke: 0.4pt + luma(80%),
  [工作区], [`git add`], [暂存区], [`git commit`], [本地仓库], [`git push`], [GitHub],
)

- *工作区 / working tree*：正在编辑的文件。
- *暂存区 / index*：下一次提交准备包含的快照。
- *本地仓库*：本机 `.git/` 中的提交、分支和标签。
- *远端仓库*：通常命名为 `origin` 的 GitHub 仓库。

#nb.remark[Git 与 GitHub][
  Git 是本地版本控制系统；GitHub 是托管 Git 仓库并提供 Pull Request、Issue、Actions
  等协作能力的平台。即使离线，也可以进行 `add`、`commit`、`branch` 和 `log`。
]

== 一次性准备 / One-time Setup

=== 检查版本与身份

```sh
git --version

# 全局身份：影响当前用户以后创建的仓库
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# 推荐的默认分支名
git config --global init.defaultBranch main

# 检查配置及其来源
git config --list --show-origin
```

只想为当前仓库设置身份时，去掉 `--global`：

```sh
git config user.name "Your Name"
git config user.email "you@example.com"
```

=== GitHub 认证

#table(
  columns: (0.75fr, 2.7fr),
  inset: 5pt,
  stroke: 0.4pt + luma(80%),
  table.header([*方式*], [*说明*]),
  [GitHub CLI], [`gh auth login`；可在浏览器中完成登录，最方便。],
  [HTTPS], [远端形如 `https://github.com/OWNER/REPO.git`；使用令牌或凭据管理器，不使用账户密码。],
  [SSH], [远端形如 `git@github.com:OWNER/REPO.git`；先把公钥添加到 GitHub。],
)

```sh
# GitHub CLI
gh auth login
gh auth status

# SSH 连通性测试
ssh -T git@github.com
```

#nb.note[安全边界][
  不要把 Personal Access Token、密码、私钥、`.env` 或云服务凭据写进仓库。
  如果密钥已经提交，第一步是立即撤销或轮换密钥，仅删除文件并不能清除历史。
]

=== 编写 .gitignore

在第一次 `git add` 前创建 `.gitignore`。Typst 笔记可以从下面开始：

```gitignore
.DS_Store
tmp/
```

若希望 GitHub 保存编译产物，不要忽略 `*.pdf`；若只保存源码，则加入：

```gitignore
*.pdf
```

检查某文件为什么被忽略：

```sh
git check-ignore -v path/to/file
```

== 从本地目录建立 GitHub 仓库 / First Publication

=== 情形 A：GitHub 远端为空

```sh
cd /path/to/project

# Git 2.28+
git init -b main

git status
git add -A
git diff --cached --stat
git commit -m "Initial commit"

git remote add origin https://github.com/OWNER/REPO.git
git remote -v
git push -u origin main
```

`-u` 会记录 `main` 的上游分支。此后在该分支通常只需 `git pull` 和 `git push`。

=== 情形 B：GitHub 远端已有 README 或提交

最稳妥的方法是先克隆，再把本地文件复制进克隆目录：

```sh
git clone https://github.com/OWNER/REPO.git
cd REPO

# 把本地文件复制到这里，然后检查、提交、推送
git status
git add -- path/to/file another/path
git commit -m "Import local project"
git push
```

如果已经在本地执行了 `git init`，可在提交本地快照后合并两段历史：

```sh
git remote add origin https://github.com/OWNER/REPO.git
git fetch origin
git merge origin/main --allow-unrelated-histories
# 解决可能的冲突，再 git push -u origin main
```

#correction[不要用 `git push --force` 来绕过首次同步冲突。] 先确认远端历史并正常合并。

== 暂存：add 的精确区别 / Staging

#table(
  columns: (1.35fr, 2.7fr),
  inset: 5pt,
  stroke: 0.4pt + luma(80%),
  table.header([*命令*], [*作用*]),
  [`git add -A`], [整个仓库：新增、修改和删除都进入暂存区。],
  [`git add -u`], [只暂存已跟踪文件的修改和删除，不加入新文件。],
  [`git add -- path`], [只暂存明确列出的路径；最适合控制提交范围。],
  [`git add -p`], [逐块选择修改，适合把混合改动拆成多个提交。],
  [`git restore --staged -- path`], [取消暂存，但保留工作区修改。],
)

推荐的全量暂存检查流程：

```sh
git status
git diff --stat

git add -A

git status
git diff --cached
```

#nb.problem[为什么自动化工具应优先显式路径？][
  `git add -A` 可能把其他任务产生的文件、密钥或尚未审核的删除一起暂存。怎样降低风险？
][
  先检查 `status` 与差异，再使用 `git add -- file1 dir2/` 明确范围；只有确认整个工作树
  都属于同一次提交时才全量暂存。
]

== 日常循环 / Daily Workflow

#nb.algo[安全的日常顺序][
  1. `git status`：确认分支和工作树状态。
  2. `git pull --rebase`：在干净工作树上同步远端。
  3. 编辑并测试。
  4. `git diff`：检查未暂存修改。
  5. `git add -- ...` 或经确认后 `git add -A`。
  6. `git diff --cached`：审核将要提交的快照。
  7. `git commit -m "..."`。
  8. `git push`。
]

```sh
git status
git pull --rebase

# edit and test
git diff
git add -- chapters/05-git-github/chapter.typ main.typ README.md
git diff --cached
git commit -m "Add Git and GitHub command guide"
git push
```

写提交信息时，用简短祈使句说明结果，例如 `Add chapter build script`、
`Fix Chinese font fallback`。一次提交尽量只表达一个逻辑变化。

== 查看状态、差异与历史 / Inspection

```sh
git status --short --branch

# 工作区 vs 暂存区
git diff

# 暂存区 vs HEAD
git diff --cached

# 某个提交的内容
git show COMMIT

# 清晰的分支图
git log --oneline --graph --decorate --all

# 最近 5 次提交及文件统计
git log -5 --stat

# 某行最后由谁修改
git blame path/to/file

# HEAD 和上游各自领先多少提交
git rev-list --left-right --count HEAD...@{upstream}
```

常用提交引用：`HEAD` 是当前提交，`HEAD~1` 是前一个提交，短 SHA 如 `a1b2c3d` 可用于
`show`、`diff`、`revert` 等命令。

== 远端同步 / Remotes and Sync

#table(
  columns: (0.85fr, 2.8fr),
  inset: 5pt,
  stroke: 0.4pt + luma(80%),
  table.header([*命令*], [*含义*]),
  [`fetch`], [下载远端引用，不改当前工作区。],
  [`pull`], [先 fetch，再把上游分支整合到当前分支。],
  [`push`], [把本地提交和引用发送到远端。],
)

```sh
git remote -v
git remote get-url origin
git remote set-url origin NEW_URL

git fetch origin
git fetch --prune origin
git branch -vv

# 只接受快进，历史分叉时停止
git pull --ff-only

# 把尚未推送的本地提交重放到远端最新提交之后
git pull --rebase

git push
git push -u origin BRANCH
```

#nb.note(breakable: false)[选择 pull 策略][
  `--ff-only` 最保守，分叉就停止；`--rebase` 适合整理尚未公开的本地提交；
  `--no-rebase` 会创建或进行普通合并。团队应约定一种策略。
]

== 分支与 Pull Request / Branches and PRs

不要把未审核功能直接堆在 `main`。一个常见流程是：

```sh
git switch main
git pull --ff-only

git switch -c docs/git-guide

# edit, test, inspect, stage and commit
git add -- chapters/05-git-github/chapter.typ main.typ README.md
git commit -m "Add Git and GitHub guide"
git push -u origin docs/git-guide

# GitHub CLI：默认先建草稿 PR
gh pr create --draft --base main --head docs/git-guide
gh pr view --web
gh pr checks
```

PR 合并后清理本地与远端分支：

```sh
git switch main
git pull --ff-only
git branch -d docs/git-guide
git push origin --delete docs/git-guide
```

其他分支命令：

```sh
git branch
git branch --all
git switch BRANCH
git switch -
git branch -m OLD NEW
git branch --merged
```

`git branch -d` 只删除已经合并的分支；`-D` 会强制删除，使用前应确认提交已有其他引用。

== 冲突处理 / Conflicts

合并或 rebase 冲突时，Git 会在文件中标出 `<<<<<<<`、`=======`、`>>>>>>>`。

```sh
git status

# 编辑冲突文件，保留正确内容并删除冲突标记
git add -- path/to/resolved-file

# merge 冲突
git commit

# rebase 冲突
git rebase --continue
```

如果暂时不想解决，可以安全返回操作前状态：

```sh
git merge --abort
git rebase --abort
```

#nb.remark[冲突不是错误][
  冲突表示 Git 无法自动判断两边哪份修改正确。先理解双方意图，再编辑最终版本；
  不要机械地全部选择 ours 或 theirs。
]

== 临时保存 / Stash

```sh
# 包含未跟踪文件
git stash push -u -m "WIP: git chapter"

git stash list
git stash show -p stash@{0}

# 应用并保留 stash
git stash apply stash@{0}

# 应用成功后删除 stash
git stash pop

git stash drop stash@{0}
```

Stash 适合短期切换任务，不应代替有意义的提交和分支。

== 撤销与恢复 / Undo and Recovery

#table(
  columns: (1.7fr, 2.4fr),
  inset: 5pt,
  stroke: 0.4pt + luma(80%),
  table.header([*目标*], [*命令*]),
  [取消暂存，保留修改], [`git restore --staged -- path`],
  [丢弃未暂存修改], [`git restore -- path`],
  [修改最近一次未推送提交], [`git commit --amend`],
  [撤销公开提交], [`git revert COMMIT`],
  [撤回最近提交但保留暂存内容], [`git reset --soft HEAD~1`],
  [查找丢失的本地位置], [`git reflog`],
)

#correction[危险：] `git restore -- path` 会丢弃该路径尚未提交的修改；
`git reset --hard` 与 `git clean -fd` 可能批量删除无法轻易恢复的工作。执行破坏性命令前，
先用 `git status`、`git diff`、`git clean -nd` 预览，并确认有备份。

公开历史通常使用 `git revert COMMIT`，因为它创建一个新的反向提交；不要随意重写已经
被他人拉取的分支。误操作后先运行 `git reflog`，很多本地提交仍可找回。

== 标签与版本 / Tags and Releases

```sh
git tag
git tag -a v1.0.0 -m "Release v1.0.0"
git show v1.0.0
git push origin v1.0.0

# 推送所有本地标签
git push origin --tags

# 可选：使用 GitHub CLI 创建 Release
gh release create v1.0.0 --generate-notes
```

已发布标签应视为稳定引用。删除或移动公共标签前先与协作者确认。

== 常见故障 / Troubleshooting

#table(
  columns: (1.15fr, 2.8fr),
  inset: 5pt,
  stroke: 0.4pt + luma(80%),
  table.header([*现象*], [*处理*]),
  [push 被拒绝], [运行 `git fetch`，检查差异，再用 `git pull --rebase` 或正常合并；不要直接 force。],
  [认证失败], [检查远端 URL，运行 `gh auth status`，或检查 HTTPS token / SSH key。],
  [暂存了错误文件], [使用 `git restore --staged -- path`，工作区内容不会丢失。],
  [提交到了错误分支], [先创建正确分支保住提交，再切回原分支处理；可用 `reflog` 定位。],
  [发现密钥], [立即轮换密钥，再按 GitHub 的敏感数据清理流程重写历史。],
  [处于 detached HEAD], [若修改要保留，立即 `git switch -c recovery-branch`。],
)

== 当前模板的首次提交 / This Repository

当前模板目录已经使用 `main` 分支并配置了 `origin`。首次发布前可执行：

```sh
cd /Users/lpf/Desktop/Learn/typst/note/template

git status
git add -A
git diff --cached --stat
git diff --cached
git commit -m "Add Typst note template"
git push -u origin main
```

若 `origin/main` 已有提交，先执行 `git fetch origin` 并检查远端历史，不要盲目强推。

此后的典型维护：

```sh
git status
git pull --rebase

# edit and rebuild
sh build.sh

git status
git add -A
git diff --cached
git commit -m "Update learning notes"
git push
```

== 官方资料 / Official References

- #link("https://git-scm.com/docs")[Git Reference]
- #link("https://git-scm.com/docs/git-add")[git-add documentation]
- #link("https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github")[Adding locally hosted code to GitHub]
- #link("https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github")[About authentication to GitHub]
- #link("https://docs.github.com/en/pull-requests/how-tos/create-pull-requests/creating-a-pull-request")[Creating a pull request]
]

#chapter-content
