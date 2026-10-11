# 吉林大学本科毕业论文（设计）LaTeX 模板

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![LaTeX](https://img.shields.io/badge/Language-LaTeX-blue.svg)](https://www.latex-project.org/)
[![Overleaf](https://img.shields.io/badge/Overleaf-Support-green.svg)](https://www.overleaf.com/)

## 📖 项目简介

本项目提供了一套**开箱即用**的吉林大学本科毕业论文 LaTeX 模板。

本模板按照学校发布的《吉林大学本科毕业论文（设计）撰写要求、书写格式》进行配置，确保格式规范，让同学们专注于论文内容的写作。

---

## 📋 格式标准与实现细节

本模板主要由 `jluthesis.cls` (样式定义) 和 `jluthesis.cfg` (用户配置) 两个核心文件驱动。以下是详细的实现细节与标准对照。

### 1. 封面与承诺书

- **实现方式**: 封面由 LaTeX 代码自动生成 (见 `jluthesis.cls` 中的 `\makecover` 命令)。
- **配置方法**: 所有封面信息（题目、姓名、学号等）均在 `jluthesis.cfg` 中配置，实现了**内容与格式分离**。
- **承诺书**: 通过统一命令 `\makecommitment` 处理；若存在 `docs/commitment.pdf` 则优先插入扫描版 PDF，不存在时回退到 `jluthesis.cfg` 中的文字版承诺书。
- **行距控制**: 封面行距可复写 `\linespread` 进行调整 (默认 1.2-1.6倍)。

### 2. 版面与页面设置

- **页面设置**: 使用 `geometry` 宏包，统一设置为 `margin=1in` (约 2.54cm)，符合 A4 标准。
- **页码编排**:
  - 前置部分 (摘要/目录) 用罗马数字 (I, II...)。
  - 主体部分 (引言起) 用阿拉伯数字 (1, 2...)。
  - 位置：页脚右下角 (`\fancyfoot[R]`)。

### 3. 字体与字号

| 项目         | 要求            | 本模板实现                                                   |
| :----------- | :-------------- | :----------------------------------------------------------- |
| **中文字体** | 宋体、黑体      | 严格遵循国标，使用 `SimSun.ttc` (宋体) 和 `SimHei.ttf` (黑体)。 |
| **英文字体** | Times New Roman | 配合 `xeCJK` 使用标准字体，保证跨平台兼容。                  |
| **正文**     | 小四号          | `\zihao{-4}` (宋体)。                                        |
| **一级标题** | 三号黑体        | `\zihao{3}`，居中。                                          |
| **二级标题** | 四号黑体        | `\zihao{4}`，左对齐。                                        |
| **封面标题** | 小初号          | `\zihao{-0}` (约 36pt)，宋体加粗。                           |

### 4. 目录

- **标题**: “目录”二字为三号黑体，居中。
- **内容**: 一律使用四号宋体 (`\zihao{4}\songti`)。
- **缩进**: 一级标题顶格 -> 二级缩进1汉字 -> 三级缩进2汉字。
- **连接**: 章、节、条与页码之间均用“......”连接。

### 5. 中、英文摘要

- **标题**: “摘要”/“Abstract” 居中，三号黑体/加粗。
- **正文**: 宋体 (SimSun)，小四号，行距 1.4倍。
- **关键词**: “**关键词：**” 加粗顶格，内容另起一行，首行缩进2字符 (采用全角冒号 `：`)。
- **目录状态**: 不出现在目录中。

### 6. 参考文献

- **标准**: GB/T 7714-2015 顺序编码制。
- **实现**: 使用 `gbt7714` 宏包 + 本地自定义样式文件 `jluthesis-gbt7714-numerical.bst` + BibTeX (`references.bib`) 管理，并使期刊名以斜体显示。
- **引用格式**: 数值顺序制，正文中以 `[1]` 形式显示。
- **编号格式**: 文献列表条目编号显示为 `[1]` 带 0.5em 间距，无悬挂缩进。
- **姓名格式**: 英文作者名以首字母缩写带点显示（如 `S.` / `S. T.`），不强制全大写。
- **编译链**: `XeLaTeX -> BibTeX -> XeLaTeX x2`。

---

## 📂 项目结构说明

请务必保持以下目录结构，**不要随意删除或移动文件夹**，否则编译会报错。

```text
thesis-template/
├── docs/                              # [核心] 文档文件夹 (存放承诺书 commitment.pdf)
├── fonts/                             # [核心] 字体文件夹 (SimSun.TTC, SimHei.TTF)
├── images/                            # [资源] 图片文件夹 (存放论文插图)
├── jluthesis.cfg                      # [配置] 论文基本信息配置文件 (题目、姓名、导师等)
├── jluthesis.cls                      # [核心] 样式文件 (定义页眉、标题、格式等核心逻辑)
├── jluthesis-gbt7714-numerical.bst    # [核心] 本地自定义参考文献样式 (期刊名斜体)
├── main.tex                           # [入口] 论文主文件 (在此编写正文)
├── mcode.sty                          # [插件] 代码高亮宏包
├── references.bib                     # [数据] 参考文献数据库
└── README.md                          # [文档] 本说明文件
```

---

## 🤝 贡献与反馈

如果你在使用过程中遇到编译失败、版式偏差、示例说明不清晰等问题，欢迎通过 GitHub Issues 或 Pull Request 反馈。

- 使用者入口：优先查看本 README 中的编译说明、写作与定制速查和常见问题。
- 贡献与维护：详见 `CONTRIBUTING.md`。
- 版本变更：详见 `CHANGELOG.md`。

---
## 🛠️ 字体配置说明

关于 **fonts 文件夹** 与 **系统安装字体** 的区别：

1. **推荐方式 (本模板默认)**：使用 `fonts/` 文件夹。

   * **配置代码**: `\newCJKfontfamily{\heiti}[Path=fonts/, AutoFakeBold={1.7}]{SimHei.TTF}`
   * **优点**: **便携性**。无论在 Windows, Mac 还是 Overleaf，只要项目里有这个文件夹，字体就一定正确。
   * **要求**: 必须将 `SimSun.ttc` 和 `SimHei.ttf` 放入 `fonts/` 文件夹。
2. **替代方式**: 使用系统安装字体（需本地安装对应字体）。

   * **配置代码**: 注释掉 `[Path=fonts/, ...]` 部分，直接使用 `\setCJKmainfont{SimSun}`。
   * **缺点**: 依赖操作系统。如果系统（如 Mac）无此字体，编译会报错。
   * **结论**: **强烈建议保持默认设置**，以确保最稳定的编译效果。

---

## 🛠️ 环境准备与编辑器推荐

你可以选择**本地安装**（推荐长期使用）或**在线编辑**（Overleaf，推荐不想安装软件的同学）。

### 方案一：在线编辑 (Overleaf)

1. **打包项目**: 将本模板的所有文件（包括 `fonts/`, `images/` 等）打成一个 `.zip` 压缩包。
2. **上传**: 登录 [Overleaf](https://www.overleaf.com/)，点击 "New Project (创建新项目)" -> "Upload Project (上传项目)"，上传刚才的压缩包。
3. **设置编译器 (关键)**:
   - 点击左下角的 "设置" 按钮。
   - 将 "Compiler (编译器)" 设置为 **XeLaTeX** (否则中文会乱码)。
   - 点击 "Recompile (重新编译)" 即可预览。

### 方案二：本地安装 (TeX Live + 编辑器）

#### 1. 安装 TeX 发行版

推荐安装 **TeX Live** (Windows/Linux) 或 **MacTeX** (macOS)。此步骤耗时较长，请耐心等待。

- **下载地址**: [吉林大学开源镜像站](https://mirrors.jlu.edu.cn/CTAN/systems/texlive/Images/) (下载其中的 `texlive.iso` 即可)

#### 2. 安装编辑器与配置

你可以根据个人习惯选择编辑器。

**选项 A：Visual Studio Code (现代化，推荐)**

推荐使用 **Visual Studio Code** 。

- **Visual Studio Code**: 经典的轻量级编辑器。
  - 插件推荐: `LaTeX Workshop`。
  - **配置教程**: 关于 VS Code + LaTeX Workshop 的详细配置，请参考知乎大佬 **Ali-loner** 的文章：
    👉 **[Visual Studio Code (vscode)配置LaTeX - Ali-loner的文章 - 知乎](https://zhuanlan.zhihu.com/p/166523064)**
  - **编译方式 (重要)**: 请在侧边栏 "TeX" 面板中选择 recipe **`XeLaTeX -> BibTeX -> XeLaTeX x2`** 进行编译，以确保参考文献正确生成。

**选项 B：TeXstudio (专为 LaTeX 设计，适合新手)**

如果你不想折腾插件配置，可以使用 TeXstudio，它开箱即用，对新手非常友好。

- **下载地址**: [TeXstudio 官网](https://www.texstudio.org/)
- **保姆级教程**: 推荐参考知乎大佬**无为**的文章，详细讲解了 TeX Live + TeXstudio 的安装与配置：
  👉 **[2025 最新LaTeX【texlive+TeXstudio】安装保姆教程 - 无为的文章 - 知乎](https://zhuanlan.zhihu.com/p/1921310237857648721)**

> **TeXstudio 简易配置指南**:
>
> 1. 安装完 TeX Live 后，安装并打开 TeXstudio。
> 2. 点击菜单栏 `Options (选项)` -> `Configure TeXstudio (设置 TeXstudio)`。
> 3. 在左侧选择 `Build (构建)`，将 `Default Compiler (默认编译器)` 修改为 **XeLaTeX** (关键步骤，否则中文不显示)。
> 4. 点击 `OK (确定)` 保存。

---

## 📝 写作与定制速查

本模板的写作入口是 `main.tex`，封面信息集中在 `jluthesis.cfg`，格式规则主要在 `jluthesis.cls` 中。日常写作一般只需要改前两个文件，确需调整排版时再修改样式文件。

### 1. 基本写作流程

1. 在 `jluthesis.cfg` 中填写论文题目、作者、学号、学院、专业、导师和日期。
2. 将签字扫描后的承诺书命名为 `commitment.pdf`，放入 `docs/` 文件夹。
3. 在 `main.tex` 中依次替换中文摘要、英文摘要、关键词、正文各章和致谢。
4. 使用 `XeLaTeX -> BibTeX -> XeLaTeX x2` 编译，确保目录、引用和参考文献全部刷新。

### 2. 常用正文元素

章节命令会自动处理编号、目录和标题样式。

```latex
\section{引言}  
\subsection{研究背景}   
\subsubsection{具体分析}  
```

图片放入 `images/` 文件夹后，用 `figure` 环境插入并设置 `label`，正文中用 `\ref{...}` 引用。

```latex
\begin{figure}[H]
    \centering
    \includegraphics[width=0.8\textwidth]{images/example.jpg} 
    \caption{这是图片标题}
    \label{fig:example}
\end{figure}
```

表格建议使用 `booktabs` 三线表。

```latex
\begin{table}[H]
    \centering
    \caption{这是表格标题}
    \label{tab:data}
    \begin{tabular}{ccc}
        \toprule
        列1名称 & 列2名称 & 列3名称 \\
        \midrule
        数据A & 数据B & 数据C \\
        \bottomrule
    \end{tabular}
\end{table}
```

数学公式使用 `$...$` 或 `equation` 环境，代码使用 `lstlisting` 环境。

```latex
\begin{equation}
    f(x) = \frac{1}{\sqrt{2\pi}\sigma} e^{-\frac{(x-\mu)^2}{2\sigma^2}}
    \label{eq:gauss} % 标签, 用于引用
\end{equation}

\begin{lstlisting}[language=Python]
import numpy as np
print("Hello World")
\end{lstlisting}
```

### 3. 参考文献

参考文献统一写在 `references.bib` 中，正文使用 `\cite{文献Key}` 引用。模板采用 GB/T 7714-2015 顺序编码制，正文引用显示为 `[1]`，列表编号保留为 `[1]` 形式，并已设置期刊名斜体。

```latex
根据张三等人的研究 \cite{zhang2025robust} ...
```

不要在 `main.tex` 中手动写 `\bibitem`。如果引用显示为 `[?]`，请按完整编译链重新编译。

### 4. 格式微调

- **页边距**: 在 `jluthesis.cls` 中修改 `\RequirePackage[margin=1in]{geometry}`。
- **行距**: 正文默认行距在 `jluthesis.cls` 中统一设置；封面行距在 `\makecover` 定义中设置。
- **字体**: 默认从 `fonts/` 文件夹加载宋体和黑体，跨平台更稳定；如需系统字体，可调整带 `Path=fonts/` 的字体定义。
- **页眉页脚**: 修改 `fancyhdr` 相关设置，如 `\fancyhead`、`\fancyfoot`。
- **目录深度**: 修改 `\setcounter{tocdepth}{...}`，`2` 显示到二级标题，`3` 显示到三级标题。
- **参考文献样式**: 修改 `jluthesis-gbt7714-numerical.bst` 顶部的 `load.config` 或相关格式函数。

格式调整前建议先备份当前可编译版本，修改后至少完整编译一次检查封面、目录、正文和参考文献。

---

## ❓ 常见问题

**Q1: 为什么编译后生成了一堆 `.aux`, `.log`, `.out` 文件？**

A: 这些是 LaTeX 编译过程中产生的辅助文件，用于记录交叉引用、目录等信息。**不要手动删除它们**，否则目录和引用会消失。

- **清理方法**: VS Code 插件通常提供了 "Clean up auxiliary files" 功能。
- **关于 main.tex 的位置**: 建议初学者将 `main.tex` 放在根目录，而不是单独文件夹。因为 LaTeX 引用图片和字体时默认基于当前文件路径，如果移动 `main.tex`，所有 `images/` 和 `fonts/` 的路径都需要修改（变成 `../images/`），这会增加出错的风险。

**Q2: 编译报错 "File `docs/commitment.pdf' not found"？**

A: 模板会优先读取 `docs/commitment.pdf`。如果文件不存在，会自动回退到 `jluthesis.cfg` 中的文字版承诺书页。如果你暂时不想显示承诺书，可以在 `main.tex` 中注释掉 `\makecommitment`。

**Q3: 中文全是乱码或者是方框？**

A:
- 确保文件是以 **UTF-8** 编码打开的（VS Code 右下角会显示编码）。
- 确保你正确配置了字体（见“字体配置”一节），并且用的是 **XeLaTeX** 编译器。

**Q4: Overleaf 上编译超时 (Time out)？**

A: 你的图片可能太大了，或者代码有无限循环错误。检查日志 (Logs)。

---

## ⚠️ 声明

本模板是一个简单可用的吉林大学本科学士学位论文 LaTeX 模板，旨在帮助同学们减轻毕业论文撰写过程中的排版工作量。

**关于作者**：本项目由**吉林大学数学学院**一名大四学生制作。由于个人水平有限，时间仓促，模板中难免存在错误或疏漏，恳请各位朋友批评指正。同时也是“抛砖引玉”，欢迎更多校友制作出更优秀的模板丰富吉大的开源资源！

**❗️ 重要提示（必读）：**

1. **非官方版本**：截止目前，**吉林大学及数学学院**官方仅提供了毕业论文撰写要求，**并未**发布、授权或认证过任何 LaTeX 模板。
2. **仅供参考**：本模板是作者对照《吉林大学本科毕业论文（设计）撰写要求》制作的。但这毕竟是个人实现，**不保证**完全符合所有审查老师的个人喜好或学院的临时变动。
3. **使用须知**：具体是否使用本模板，请各位同学根据自身情况及导师要求**自行定夺**。如果在使用过程中遇到格式问题，请以学校发布的官方要求为准进行调整。

随时倾听各位朋友的批评与教导！提前对发现缺陷并反馈的朋友报以诚挚的谢意！

---

## 📜 许可证

本项目采用 MIT 许可证开源。遵循吉林大学学位论文规范。
