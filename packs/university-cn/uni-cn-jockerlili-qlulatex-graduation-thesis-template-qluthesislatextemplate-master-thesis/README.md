<div align="center">

# QLUThesis $\LaTeX$ Template

_✨ 拥抱高效排版，享受折腾 $\LaTeX$ ✨_

</div>


<img src="./QLUThesisLatexTemplate-master/Thesis/static/figures/MainLOGO-pretty.png" style="zoom: 15%">

## 📖 说明

齐鲁工业大学本科生毕业论文 LaTeX 模版

## 💡 为何使用 $\LaTeX$​

<center>致爱折腾的你</center>

$\LaTeX$作为专业化的排版工具，在书籍出版、论文撰写、美赛等竞赛中都有广泛的应用

在刚刚结束的毕业设计撰写中，很多使用 Word 的同学在写作过程中出现大量难以解决的格式问题，非常头疼。$\LaTeX$ 虽然学习曲线较为陡峭，但花费一个小时左右时间熟悉后即可完全专注于内容撰写而无需操心任何格式问题。本模版即旨在你只需复制粘贴修改具体内容即可作出 __基本__ 符合齐鲁工业大学现行规范的毕业设计。供后人参阅

$\LaTeX$ + 本模板可以实现：

* 无比优雅的数学公式
* 章节的自动标号
* 公式的自动标号
* 插图的自动标号
* 表格的自动标号
* 目录的自动生成
* 参考文献和标引的自动标号
* __所有格式的自动正确__

## 📌 如何使用本模板

### 基本使用

首先请阅读文档《[一份不太简短的 $\LaTeX$ 介绍](http://www.ctan.org/tex-archive/info/lshort/chinese/)》，了解 $\LaTeX$ 的基础语法。

New Structure

```TEXT
(Root)Thesis
 ├─ .vscode/                         # settings.json 配置 VSCode + LaTeX Workshop
 ├─ pages/                           # 分页 TeX 文件
 │   ├─ extra/                       # 附加页面 TeX 文件
 │   │   ├─ acknowledgements.tex     # 致谢
 │   │   ├─ paperInChinese.tex       # 中文文献
 │   │   ├─ paperInEnglish.tex       # 英文文献
 │   ├─ abstract.tex                 # 摘要部分
 │   ├─ body.tex                     # 正文部分
 │   ├─ tail.tex                     # 文末部分 (致谢+附录)
 ├─ scripts/                         # 清理脚本
 ├─ setup/                           # 初始化 TeX 文件
 │   ├─ cover.tex                    # 封面信息
 │   ├─ format.tex                   # 格式定义
 │   ├─ package.tex                  # 加载宏包
 ├─ static/                          # 静态文件
 │   ├─ code/                        # 代码片段
 │   ├─ doc/                         # 原始文档
 │   │   ├─ NewVersion/              # 新版本 docx/pdf
 │   │   ├─ OldVersion/              # 老版本 docx/pdf
 │   ├─ figures/                     # 图片
 │   ├─ font/                        # 字体文件
 │   ├─ references/                  # 参考文献 bib 文件
```

### 代码引入

在目录`static/code/`中添加代码

```
smile.py
\lstinputlisting[language=python]{static/code/smile.py}
```

### 参考文献

所有参考文献在 `static/references/reference.bib` 中。BibTex 格式的参考文献可通过以下步骤获得：

* 打开浏览器，访问 [Google Scholar](http://scholar.google.com)

* 查找你所需的文献

* 点击文献下方 引用/cite 按钮

* 在弹出框内点击 BibTex

* 复制新窗口里的文本粘贴到 reference.bib 中

* 在 body.tex 中需要引用的地方使用`\cite{}`命令进行引用，括号里填参考文献第一行左花括号后面的 identifier。

  例如有这样一篇bib格式的参考文献：@INPROCEEDINGS{6909475,

  ```
  @INPROCEEDINGS{6909475,
  	author={Girshick, Ross and Donahue, Jeff and Darrell, Trevor and Malik, Jitendra},
  	booktitle={2014 IEEE Conference on Computer Vision and Pattern Recognition}, 
  	title={Rich Feature Hierarchies for Accurate Object Detection and Semantic Segmentation}, 
  	year={2014},
  	volume={},
  	number={},
  	pages={580-587},
  	doi={10.1109/CVPR.2014.81}}
  ```

  在文中在需要的地方添加**\cite{6909475}**（数字就是上面bib文本中的第一个数字序列，可以自定义），就能引用你需要的参考文献了。

### 目录，字体，字号，编号，序号，页码，页眉，排版...

全都是自动的

## 🛠 关于本魔改

本魔改适用于Texstudio，使用 `xelatex->bibtex->xelatex->xelatex` 编译链。在 macOS, Windows 10 下进行修改与测试，无法完全保证其它平台的正常使用。希望 Linux 用户踊跃反馈。

最新修改版本适用于VSCode，在Windows 11、Debian 12、Ubuntu 24 LTS下测试通过，其使用流程可以完全在终端中结合NeoVIM进行。

### 魔改内容

* 移除 CJK，使用 ctex
* 根据现行本科生毕业论文规范修改格式
* 适应 macOS, Windows, Linux 与 xelatex
* 为适应我推荐的工具链做了一些优化
* 根据现行本科生毕业论文规范修改格式 2.0
* 适配 Debian系Linux (Debian/Ubuntu)

### 编译

> - 编译操作在 `main.tex` 所在目录下进行
> - 以下编译方式任选其一即可

#### Visual Studio Code

在应用推荐工具链后，打开 `main.tex`，执行 Ctrl + Alt + B；或点击左侧 TEX Tab 并单击 Build LaTeX project。

最新已在包中添加了.vscode/settings.json文件，其中包括FULL Build和Quick Build两个模式，当还没有涉及参考文献的时候可以使用Quick模式，并默认自动运行linux-clean脚本清除多余文件。两个模式支持记忆上一次所使用的模式，请从VSCode左侧插件运行选项中直接点击完成切换，后续使用快捷键即可

> [!WARNING]
> 请按照自己的需求，从.vscode/settings.json中开启对应的清理脚本！

#### 使用`Latexmk`编译

```bash
latexmk -pvc -xelatex -file-line-error -interaction=nonstopmode -synctex=1 main.tex
```

#### 手动编译

**依次运行**以下四条命令：

```bash
xelatex main.tex
bibtex main.aux
xelatex main.tex
xelatex main.tex
```

注意：由于存在目录、参考文献和图表编号等，需要多次编译以保证顺序正确。

### 清理缓存及日志

#### Atom

安装插件 `language-latex` 和 `latex`，提供 Build 和 Clean 的功能。

#### Visual Studio Code

安装插件 `LaTeX Workshop`，提供 clean up。

#### Latexmk

```bash
latexmk -c
```

#### 其他

也可使用 [@Halcao](https://github.com/Halcao) 提供的小脚本 `Thesis/macos-clean.sh`。

## ⚙ 推荐工具链

* 发行版
  * macOS: MacTex
  * Windows: TeX Live
  
  - Debian/Ubuntu: Tex Live
* Visual Studio Code
  * LaTeX Workshop
* Atom
  * language-latex
  * latexer
    * latextools
* Sublime Text 3
  * LatexTools
  * Latex-cwl
  * LatexWordCount
  
* Overleaf 经测试无法支持免费的compile time

注意：最新版已集成.vscode/settings.json，开箱即用

## 🙏 致谢

qluthesis 的原作者们作出了前人栽树的不可磨灭的贡献：

本模板主要借鉴于天津大学本科latex论文模板，在这里无比感谢前人的栽树！

* 张井 天津大学2010级管理与经济学部信息管理与信息系统专业硕士生
* 余蓝涛 天津大学2008级精密仪器与光电子工程学院测控技术与仪器专业本科生
* 北京大学孟祥溪院士。

QLU 数学与人工智能学部(原 数统学院) 二次开发修改的改版人员

- 李赟博 齐鲁工业大学 2019级数学与人工智能学院智能科学与技术专业本科生

- [XLY23333](https://xly23333.xyz) 齐鲁工业大学 2022级数学与人工智能学部智能科学与技术专业本科生 [December 23, 2025]

## 📜 License

由于原项目使用 GNU GPL v3 协议，本项目作为基于 qluthesis 的衍生项目，仍保持 GNU GPL v3 协议。

## 🆕 更新日志

### 2025年12月23日更新内容

> 一人 一桌 一台电脑 一个通宵

开发环境

> [!NOTE]
> OS: Ubuntu 24.04.3 LTS (Gnome)
>
> IDE: VSCode-insiders +  LaTeX Workshop
>
> LaTeX Engine: TeX 3.141592653 (TeX Live 2023/Debian)

1. 更新到了最新版本的论文要求模板 (20251223)
2. 修改了整体模板结构，使用pages文件夹管理所有$\TeX$分页，static文件夹保存所有静态文件
3. 添加扉页、原创、授权声明等页面
4. 修复目录问题、修复页面编码错误、更新最新页边距和页眉页脚适配
5. 添加了RawTTF+BoldTTF的黑体、宋体、仿宋字体，用于更加贴近Word板式
6. 按照最新的word格式，全面修改了模板中的文段内容，添加伪代码示例
7. 移除了代码中的冗余部分，优化公式表格代码间距

ps: 本次修改是拿MS Word导出的pdf截屏半透明贴在屏幕上一点点硬改的，对于局部细节可能含有一定范围，但在打印状态下几乎可以忽略不计

### 2023年5月16日更新内容

1. 取消了中英文摘要关联在封面中，单独定义了abstract.tex文件进行编译，使得摘要可以在目录之下。
2. 目录部分单独用罗马数字编码。
3. 摘要部分适配了页眉。

## ⏳ 待更新内容
