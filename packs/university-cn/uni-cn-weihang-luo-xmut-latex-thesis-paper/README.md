# XMUT-Thesis-LaTeX

## 厦门理工学院（Xiamen University of Technology, XMUT）硕士学位论文 LaTeX 模板

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## 📖 项目简介

本项目是**厦门理工学院（XMUT）研究生学位论文 LaTeX 模板**，基于学校官方 Word 模板的格式规范修改制作而成。

### 背景

模板整体框架参考了**厦门大学 LaTeX 论文模板**，并根据厦门理工学院的格式要求进行了适配和修改。

为了简化使用和提高兼容性，模板中的部分内容（如封面、声明页等）采用了**插入 PDF 页面**的方式实现——只需按照学校 Word 模板填写相应页面，导出为 PDF 后替换即可，无需担心格式差异问题。

### ⚠️ 重要提示

> **论文格式请以学校最新官方要求为准！**
> 
> 本模板仅供学习参考，请使用者在提交论文前务必对照学校最新的格式规范进行核对和调整。

## ✨ 特性

- 📝 支持硕士/博士学位论文
- 🔤 完整的中英文排版支持
- 📊 内置图表、公式、参考文献示例
- 📄 支持 PDF 页面插入（封面、声明等）
- 🎨 符合学校论文格式规范（Word）

## 📁 目录结构

```
XMUT-Thesis-LaTeX/
├── paper.tex              # 📄 主文档文件（主要编辑此文件）
├── xmut-thesis-grd.cls    # 🎨 论文样式类文件
├── glossaries-cn.sty      # 📚 术语表样式文件
├── README.md              # 📖 说明文档
├── figures/               # 🖼️ 图片目录
├── fonts/                 # 🔤 字体文件目录
├── pdf_files/             # 📑 封面等 PDF 文件目录
└── reference/             # 📚 参考文献目录
    ├── chapter.bib        # 参考文献数据库
    └── gbt7714-numerical.bst  # GB/T 7714 参考文献格式
```

## 🚀 快速开始

### 环境要求

- **TeX 发行版**：TeX Live 2020+ 或 MiKTeX 20+
- **编译引擎**：XeLaTeX（中文支持）
- **推荐编辑器**：VS Code + LaTeX Workshop 插件 / TeXstudio / Overleaf（付费）

### 字体要求

- 宋体 (SimSun)
- 黑体 (SimHei)
- 楷体 (KaiTi)
- 仿宋 (FangSong)

### 编译方法

**方法一：命令行编译（环境配置后）**

```bash
xelatex paper.tex
bibtex paper
xelatex paper.tex
xelatex paper.tex
```

**方法二：使用 latexmk**

```bash
latexmk -xelatex paper.tex
```

**方法三：VS Code + LaTeX Workshop**

安装 LaTeX Workshop 插件后，打开 `paper.tex`，保存时自动编译。

## 📝 使用指南

### 文档类选项

```latex
\documentclass[pdf, master]{xmut-thesis-grd}
```

| 选项 | 说明 |
|------|------|
| `master` | 硕士论文（默认） |
| `pdf` | 使用 PDF 格式的封面页 |
| `twoside` | 双面打印模式（不加则为单面） |

### 主要修改内容

1. **论文标题**
   ```latex
   \title{你的中文标题}
   \entitle{Your English Title}
   ```

2. **摘要与关键词**
   - 中文摘要：`\begin{cnabstract}...\end{cnabstract}`
   - 英文摘要：`\begin{enabstract}...\end{enabstract}`

3. **正文章节**
   - 使用 `\chapter{章标题}` 和 `\section{节标题}` 组织内容

4. **参考文献**
   - 编辑 `reference/chapter.bib` 添加文献条目
   - 使用 `\cite{引用键}` 在正文中引用

5. **图片插入**
   ```latex
   \begin{figure}[ht]
       \centering
       \includegraphics[width=0.8\textwidth]{figures/your_image.pdf}
       \caption{图片标题}
       \label{fig:your_label}
   \end{figure}
   ```

6. **封面等 PDF 页面**
   - 将填写好的封面、声明等导出为 PDF
   - 放入 `pdf_files/` 目录并在样式文件中配置

## ❓ 常见问题

### Q1: 编译报错找不到字体？
请确保系统安装了所需的中文字体，或将字体文件放入 `fonts/` 目录。

### Q2: 参考文献不显示？
请按照完整的编译顺序执行：xelatex → bibtex → xelatex → xelatex

### Q3: 封面格式不对？
建议使用学校官方 Word 模板制作封面，导出为 PDF 后通过 `\includepdf` 插入。

### Q4: Overleaf 上能用吗？
可以，但需要上传所需的字体文件，并确保编译器设置为 XeLaTeX，但是学位论文通常很大，免费模式下无法完成编译（超时）。



## 🙏 致谢

- **厦门大学 LaTeX 论文模板** [xmu-thesis-grd](https://github.com/zoam/xmu-thesis-grd) 提供的框架参考

