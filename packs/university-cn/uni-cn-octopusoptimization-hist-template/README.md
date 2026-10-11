# Hist_Template（HIST Thesis LaTeX Template）

一个**开箱即用**的中文学位论文 LaTeX 模板（基于 `ctexrep`），格式符合河南科技学院硕士研究生毕业论文要求。模板已经将论文写作中最常见、最容易出问题的格式与环境统一配置完成，包括封面信息、目录样式、页眉页脚、参考文献、定理环境、算法伪代码、三线表以及交叉引用等。  
**正常使用时，仅需要修改 `InfoSetting.tex` 并编写各章节内容。**

---

# QQ交流群
![image](figures/QQ交流群.png)


## 目录结构

```text
Hist_Template/
├── main.tex                  # 编译入口（XeLaTeX）
├── InfoSetting.tex           # ✅论文元信息与功能开关（主要修改此文件）
├── config/                   # 模板核心配置（一般无需修改）
│   ├── thesis-fonts.tex      # 字体设置（使用 fonts/ 下内置中文字体）
│   ├── thesis-layout.tex     # 页面尺寸、行距、段落格式
│   ├── thesis-style.tex      # 标题样式、目录样式、页眉页脚、表格配置
│   ├── thesis-math.tex       # 定理/公式/算法环境与编号规则
│   └── thesis-ref.tex        # 参考文献（GB/T 7714）与引用设置
├── front/                    # 前置部分
│   ├── frontmatter.tex
│   ├── cover-hist.tex
│   ├── title-en-hist.tex
│   ├── statement.tex
│   ├── abstract-cn.tex
│   ├── abstract-en.tex
│   └── symbols.tex
├── chapters/                 # 正文章节
│   ├── chap1.tex
│   ├── chap2.tex             # 本章为模板使用说明与示例
│   ├── conclusion.tex
│   ├── thanks.tex
│   └── results.tex
├── appendix/
│   └── appendixA.tex
├── figures/
├── fonts/                    # 模板自带中文字体
└── references.bib
```

---

## 快速开始

### 1. 修改论文信息
打开 `InfoSetting.tex`，根据注释填写或修改：
- 论文中英文题目
- 作者、导师、学位类别、研究方向
- 封面字段（单位代码、分类号、密级、Logo 路径等）
- 功能开关（是否显示图表清单、符号表、附录、英文扉页等）
> 不建议直接修改 main.tex 或 front/*.tex 中的个人信息，模板已统一从 InfoSetting.tex 读取。

### 2. 编译方式
本模板使用 `BibTeX` 参考文献流程，推荐如下顺序：
```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```
`Overleaf`和`keepresearch`中只需要在设置中选择Xelatex编译即可。

说明：
- 必须使用 XeLaTeX
- 参考文献样式为 GB/T 7714（数字顺序制）
- 可直接在 `Overleaf` 或 `keepresearch` 中编译

- 因为论文一般都比较长，`Overleaf`可能会出现编译超时的情况。推荐使用本地Texlive环境编译或使用`keepresearch`在线编译。
- 推荐`keepresearch`，国内网站，不需要科学上网工具，不限制编译时长。本地环境搭建麻烦对新手不友好。
- 使用`Overleaf`或`keepresearch`时，需要设置编译器`XeLaTex`、主文档`main.tex`。


---

## 新增章节说明

本模板采用“**每一章一个文件**”的组织方式，新增章节时**不需要修改模板配置文件**，只需按以下步骤操作。

---
### 1. 新建章节文件

在 `chapters/` 目录下新建一个 `.tex` 文件，例如：

```text
chapters/chap3.tex
```
文件内容示例：
```latex
\chapter{算法设计与理论分析}

\section{问题描述}

这里编写章节正文内容。

\subsection{基本假设}

正文内容……

\subsubsection{符号说明}

正文内容……
```

### 在 `main.tex` 中引入章节
打开 main.tex，在正文部分按顺序加入（通常章节引入顺序如下）：
```latex
\input{chapters/chap1}
\input{chapters/chap2}
% 新增的章节
\input{chapters/chap3}
```
### 关于章节编号

- \chapter、\section、\subsection 默认参与编号

- 模板已开启 \subsubsection 编号（如 2.1.3）  `最高支持四级标题`

- 编号与目录格式已统一配置，无需用户额外设置

### 注意事项

- 不要在章节文件中写 \documentclass 或 \begin{document}

- 每一章建议单独一个 .tex 文件，便于维护与修改

- 图、表、算法、定理请使用模板已提供的环境

- 新增章节后需重新编译两次以上以更新目录与编号

---


## 说明

### 关于htbp
在 figure / table / algorithm 环境中：
```latex
\begin{figure}[htbp]
  ...
\end{figure}

```
方括号里的 htbp 是 浮动体位置建议（placement specifier）。

�� 注意：它是“建议”，不是命令，LaTeX 可以不听你的。


| 字母 | 含义 | 说明 |
|----------|----------|----------|
| h  | here  | 尽量放在当前位置（当前位置附近）  |
| t  | top   | 页面顶部                        |
| b  | bottom| 页面底部                        |
| p  | page  | 单独的浮动页（只放图/表）        |

LaTeX 会按你写的顺序尝试，比如： `[htbp]`

- htbp 用于建议 LaTeX 放置图表的位置，其中

- `h` 表示当前位置，`t` 表示页顶，`b` 表示页底，`p` 表示独立浮动页。

- 在学位论文中，推荐统一使用 `[htbp]` 以获得稳定、规范的排版效果。

### 一些标签
- `\label{tab:performance}`  lable 标签，用于引用（要保证唯一），如`\ref{tab:performance}`
- `\caption{示例}` caption 标签，用于添加图纸，表名等等

## 算法伪代码
已配置 `algorithm` + `algpseudocode`，标题中文化，支持输入/输出与行号。
```latex
\begin{algorithm}[H]
  \caption{示例算法}
  \begin{algorithmic}[1]
    \Require 数据集 $D$
    \Ensure 模型参数 $\theta$
    \State 初始化 $\theta$
    \For{$i=1$ to $T$}
      \State 更新 $\theta$
    \EndFor
  \end{algorithmic}
\end{algorithm}

```

## 表格（三线表）
已加载 `booktabs`，统一三线表规范。

`\setlength{\tabcolsep}{20pt}`用于调整表格的紧凑层度，其中20pt表示把每一列左右的留白设置为 20pt

```latex
\setlength{\tabcolsep}{20pt}
\begin{table}[htbp]
    \centering
    \caption{不同算法性能比较}
    \label{tab:performance}
    \begin{tabular}{lccc}
    \toprule
        算法 & 准确率(\%) & 召回率(\%) & F1 值 \\
        \midrule
        算法 A & 92.3 & 90.1 & 91.2 \\
        算法 B & 89.7 & 88.4 & 89.0 \\
        算法 C & 94.5 & 93.2 & 93.8 \\
    \bottomrule
    \end{tabular}
\end{table}


```
### 表格太宽的处理方法
如果通过上面`\setlength{\tabcolsep}{20pt}`的方法无法满足表格的宽度,可以通过下面`sidewaystable`的方法旋转表格进行处理。
```latex
\begin{sidewaystable}[p]
\centering
    \caption{各算法在不同数据集上的性能对比}
    \label{tab:wide}
    \begin{tabular}{lcccccccc}
    \toprule
        方法 & 指标1 & 指标2 & 指标3 & 指标4 & 指标5 & 指标6 & 指标7 & 指标8 \\
        \midrule
        算法A &  &  &  &  &  &  &  &  \\
        算法B &  &  &  &  &  &  &  &  \\
    \bottomrule
    \end{tabular}
\end{sidewaystable}
```
#### 表格单元格合并
```latex
% 横向合并 
\multicolumn{合并列数}{对齐方式}{内容}
% 纵向合并  宽度通常写 *（自动）
\multirow{合并行数}{宽度}{内容}
```

```latex
\begin{table}[ht]
    \centering
    \caption{table:2-3}
    \label{tab:2-3}
    \begin{tabular}{llccc}
    \toprule
    \multirow{2}{*}{数据集}
    & \multirow{2}{*}{方法}
    & \multicolumn{3}{c}{指标} \\
    \cmidrule(lr){3-5}
    & & Acc & Recall & F1 \\
    \midrule
    a & a & a & a & a\\  % 每行后面都要加换行符号
    \bottomrule
    \end{tabular}
\end{table}
```
## 插入单图片
- latex 支持多种图片格式。但是，建议使用矢量图。
- width=0.65  指定图片宽度，0.65代表图片宽度=页面宽度的65%，可以适当调整图片宽度
```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.65\linewidth]{figures/example.jpg}
  \caption{示例图}
  \label{fig:example}
\end{figure}
```

### 插入多组图
```latex
\begin{figure}[htbp]
  \begin{center}
    \includegraphics[width=0.45\linewidth]{figures/example.jpg}
    \includegraphics[width=0.45\linewidth]{figures/example.jpg}
  \end{center}
  \begin{center}
    \includegraphics[width=0.45\linewidth]{figures/example.jpg}
    \includegraphics[width=0.45\linewidth]{figures/example.jpg}
  \end{center}
  \caption{多组图示例}
  \label{fig:aa}
\end{figure}
```
### 插入子图

```latex
\begin{figure}[htbp]
  \centering
  \begin{subfigure}{\linewidth}
    \centering
    \includegraphics[width=0.45\linewidth]{figures/example.jpg}
    \includegraphics[width=0.45\linewidth]{figures/example.jpg}
    \caption{结果 A}
    \label{fig:a}
  \end{subfigure}
  \hfill
  \begin{subfigure}{0.45\linewidth}
    \centering
    \includegraphics[width=\linewidth]{figures/example.jpg}
    \caption{结果 B}
    \label{fig:b}
  \end{subfigure}
  \caption{不同方法结果对比}
  \label{fig:ab}
\end{figure}
```

## 插入代码
- language 指定代码语言
```latex
\begin{lstlisting}[language=Java, caption={MapReduce 主流程}, label={lst:mr}]
public static void main(String[] args) {
    System.out.println("Hello World");
}
\end{lstlisting}
```

## 定理环境
定理、引理、定义、推论等按章编号，证明环境已配置。
- 按 章编号（如 定理 2.1、引理 2.2）
- 已提供证明环境（proof）
- 环境样式已统一
```latex
\begin{definition}
    设……，称……为广义分式规划问题。
\end{definition}

\begin{theorem}
    若……成立，则……。
\end{theorem}

\begin{proof}
    由……可得……，结论成立。
\end{proof}
```

### 引用与编号
图、表、公式、算法、定理均支持自动编号与交叉引用。
- 图、表、公式、算法、定理均支持自动编号 
- 已配置 hyperref 与 cleveref

- 支持 \ref{} 与 \cref{} 统一引用

## 文献引用

本模板采用 **BibTeX** 管理参考文献，参考文献样式符合 **GB/T 7714—2015（数字顺序制）** 学位论文规范，相关配置已在模板中完成，用户无需额外设置。

- 直接在`references.bib`中添加文献的bibtex格式。
- 在文中使用 \cite{} 进行文献引用
- 如果想修改参考文献的文件名称，在`InfoSetting.tex`中修改`\newcommand{\HISTbibname}{references}` 即可。（不推荐修改）

---

## 使用说明
- 本模板仅提供排版支持，`最终格式请以学校最新论文规范为准`。
- 允许学习与科研用途的自由修改与分发。
