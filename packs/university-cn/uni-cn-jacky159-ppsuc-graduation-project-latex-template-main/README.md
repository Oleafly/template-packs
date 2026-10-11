# PPSUC Graduation Project LaTeX Template

中国人民公安大学信息网络安全学院本科毕业论文（设计）LaTeX 模板项目。

这个仓库以学校官方提供的 Word / PDF 模板为参考，整理出一套可编译的 LaTeX 版本，方便后续在 GitHub 上维护、版本管理和二次修改。

## 项目目标

- 以 `信网学院本科毕业设计模板（2024）.docx` 和 `信网学院本科毕业设计模板（2024）.pdf` 为版式参考
- 提供可直接编译的 LaTeX 工程
- 尽量保留学校模板中的中文字体、封面样式和正文层级
- 方便后续继续微调为个人论文终稿

## 目录结构

```text
PPSUC_Graduation_Project/
├── latex-template/
│   ├── main.tex
│   ├── main.pdf
│   ├── README.md
│   ├── assets/
│   │   ├── official-template.pdf
│   │   ├── pup-title.png
│   │   ├── pup-emblem-gray.png
│   │   └── sample-framework.png
│   └── fonts/
│       ├── SIMSUN.TTC
│       ├── SIMHEI.TTF
│       ├── 楷体_GB2312.TTF
│       └── 仿宋_GB2312.TTF
├── 信网学院本科毕业设计模板（2024）.docx
└── 信网学院本科毕业设计模板（2024）.pdf
```

## 当前状态

- 已完成 XeLaTeX 编译验证
- 当前主工程文件为 `latex-template/main.tex`
- 当前输出 PDF 为 `latex-template/main.pdf`
- 模板实现采用了“官方样张 + LaTeX 可编辑页”混合方案：
  - 前置固定页和尾部固定样张页，优先按官方 PDF 对齐
  - 中间正文示例页保留为可编辑的 LaTeX 内容

这意味着它已经很适合继续作为个人论文模板使用，但如果你希望“整份文档每一页都完全由 LaTeX 重建”，还可以继续往下细化。

## 快速开始

进入模板目录：

```bash
cd latex-template
```

使用 `latexmk` 编译：

```bash
latexmk -xelatex -interaction=nonstopmode -halt-on-error main.tex
```

如果只想用 `xelatex`：

```bash
xelatex main.tex
xelatex main.tex
```

编译成功后会生成：

```text
latex-template/main.pdf
```

## 环境要求

建议环境：

- TeX Live
- `xelatex`
- `latexmk`
- 中文支持宏包，如 `ctex`

本项目当前模板依赖本地字体文件：

- `SIMSUN.TTC`
- `SIMHEI.TTF`
- `楷体_GB2312.TTF`
- `仿宋_GB2312.TTF`

字体文件默认放在 `latex-template/fonts/` 下，模板会直接从该目录加载。

## 你最常需要修改的内容

打开 [latex-template/main.tex](latex-template/main.tex)，优先修改顶部这些字段：

- `\thesistitlecn`
- `\thesissubtitlecn`
- `\thesistitleen`
- `\thesissubtitleen`
- `\studentname`
- `\studentid`
- `\college`
- `\grade`
- `\major`
- `\company`
- `\advisor`
- `\cnabstracttitle`
- `\cnabstractsubtitle`
- `\cnabstracttext`
- `\cnkeywordslineone`
- `\cnkeywordslinetwo`
- `\enabstracttext`
- `\enkeywordslineone`
- `\enkeywordslinetwo`

## 参考来源

官方参考文件位于仓库根目录：

- [信网学院本科毕业设计模板（2024）.docx](信网学院本科毕业设计模板（2024）.docx)
- [信网学院本科毕业设计模板（2024）.pdf](信网学院本科毕业设计模板（2024）.pdf)

其中 `latex-template/assets/official-template.pdf` 用于部分固定样张页的精确对齐。

## 模板对比

下图左侧为官方 PDF 模板，右侧为当前 LaTeX 编译输出。

![Official PDF vs compiled LaTeX output](docs/template-comparison.png)
