<div align="center">
  <img src="CUG_Beamer_Theme/pic/CUG_Logo1.png" width="112" alt="中国地质大学（武汉）标识">

  # CUG Template

  **面向中国地质大学（武汉）同学的报告与答辩模板集合**

  <sub>把时间留给问题、实验与表达，而不是反复调格式。</sub>

  <br><br>

  [![许可证](https://img.shields.io/github/license/lusunn111/CUG-Template?style=flat-square&color=0A6EBD)](LICENSE)
  [![最近更新](https://img.shields.io/github/last-commit/lusunn111/CUG-Template?style=flat-square&color=0A6EBD)](../../commits/main)
  [![参与维护](https://img.shields.io/badge/欢迎-共同维护-0A6EBD?style=flat-square)](CONTRIBUTING.md)
</div>

> 这是一个由使用者持续打磨的非官方模板库。它服务于课程报告、开题答辩、中期检查、毕业设计等常见场景，也欢迎后来者把自己踩过的格式坑变成大家可复用的改进。

## 为什么有这个仓库

在报告写作和答辩准备的最后阶段，格式往往会吞掉本应属于研究、实验和表达的时间。本仓库把作者日常使用且验证过的 PPT、Beamer、Word 与 LaTeX 模板集中起来：需要快速完成答辩展示时有可直接替换内容的 PPT；希望版本可控、公式排版稳定时可以使用 Beamer；课程报告和 LaTeX 报告则参考了学校相关要求进行整理。

模板不是规范本身。提交前请始终以学院或教务处发布的最新版要求为准，并自行完成内容、封面信息、引用与格式核对。

## 模板一览

| 类型 | 入口 | 适用场景 | 使用方式 |
| :-- | :-- | :-- | :-- |
| PPT | [`lusunn111 的 CUGPPT 模板.pptx`](./lusunn111%20的%20CUGPPT%20模板.pptx) | 开题、中期、预答辩、答辩汇报 | 直接用 Microsoft PowerPoint 或 WPS 打开，替换文字、图片与页脚信息。 |
| Beamer | [`CUG_Beamer_Theme/`](./CUG_Beamer_Theme) | 时间紧、内容以公式和结构化叙事为主的学术汇报 | 修改 `slide.tex`，使用 XeLaTeX（支持中文的 LaTeX 编译器）编译。 |
| Word | [`本科生课程报告模板.docx`](./本科生课程报告模板.docx) | 课程报告、需要 Word 协作的文档 | 打开后优先改封面与正文样式，不要随意重建已有样式。 |
| LaTeX | [`CUG 本科生毕业设计 Latex 模板/`](./CUG%20本科生毕业设计%20Latex%20模板) | 长报告、公式密集或需要版本管理的报告 | 以 `Thesis.tex` 为入口，使用 XeLaTeX 编译。 |

## 快速开始

### 直接使用 PPT 或 Word

下载单个文件即可开始。建议第一步先将封面中的题目、姓名、学号、专业、指导教师和日期替换完整，再按已有版式复制页面。演示模板中的论文、会议标识和图片仅是示例材料，正式提交前必须替换为你有权使用的内容。

### 使用 Beamer

安装 TeX Live（LaTeX 发行版）或 MacTeX 后，进入目录并执行：

```bash
cd CUG_Beamer_Theme
xelatex slide.tex
```

日常修改主要集中在 `slide.tex` 的作者、题目、单位、日期和各页内容；主题定义位于 `CUG.sty`。如使用编辑器，选择 `XeLaTeX` 编译器即可。

### 使用 LaTeX 报告模板

进入模板目录，优先修改 `Thesis.tex` 顶部的题目、作者、学院、学号和指导教师等信息：

```bash
cd "CUG 本科生毕业设计 Latex 模板"
xelatex Thesis.tex
bibtex Thesis
xelatex Thesis.tex
xelatex Thesis.tex
```

模板依赖中文字体。Windows 用户通常已安装宋体、黑体与楷体；macOS 或 Linux 用户请安装可替代的中文字体，并按 `CUGThesis.cls` 中的字体设置进行调整。仓库不会分发受限字体文件。

## 仓库结构

```text
CUG-Template/
├── lusunn111 的 CUGPPT 模板.pptx              # 可直接编辑的答辩演示模板
├── 本科生课程报告模板.docx                    # Word 课程报告模板
├── CUG_Beamer_Theme/
│   ├── slide.tex                              # Beamer 内容入口
│   ├── CUG.sty                                # Beamer 主题定义
│   └── pic/                                   # 主题图片资源
└── CUG 本科生毕业设计 Latex 模板/
    ├── Thesis.tex                             # LaTeX 内容入口
    ├── CUGThesis.cls                          # 文档类与排版定义
    ├── Bibs/                                  # 参考文献数据库
    └── Figures/                               # 示例图片资源
```

## 维护与贡献

这个仓库最有价值的部分，不是某一版模板，而是它能否随着学校要求和同学们的实际使用持续变好。欢迎提交问题、修复和模板改进，尤其是：封面或页边距与最新要求不一致、不同系统上的字体兼容性问题、Beamer 组件改进、以及更清晰的使用说明。

提交前请确认三件事：改动可复现、与最新正式要求一致、不会加入未获授权的校徽、字体、论文图片或课程材料。具体约定见 [贡献指南](CONTRIBUTING.md)。

## 许可与声明

本仓库内容采用 [MIT 许可证](LICENSE) 发布，欢迎在保留许可证的前提下使用、修改与分享。模板用于辅助排版与表达；提交前仍请以学院或教务处的最新要求为准。

本项目与中国地质大学（武汉）及其任何院系均无官方隶属关系。

---

<div align="center">
  如果它替你省下了一小时调格式的时间，欢迎点一个 Star，也欢迎把改进留给下一位同学。<br>
  <sub>Maintained with care by <a href="https://github.com/lusunn111">@lusunn111</a>, <a href="https://github.com/JiaqiTan111">@JiaqiTan111</a>, and future CUG students.</sub>
</div>
