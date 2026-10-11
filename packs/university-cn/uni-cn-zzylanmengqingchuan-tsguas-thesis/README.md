# TSGUAS-Thesis

TSGUAS 天津中德应用技术大学 LaTeX 本科毕业设计（论文）模板（软件工程专业）。

依据《软件工程专业毕业设计指导文件 V2.0》（软件工程专业委员会，2025-12-19）
中的 Word 模板与格式规范实现，全部格式（页边距、字号、行距、页眉页脚、
图表公式编号、参考文献 GB/T 7714-2015 等）已固化在 `izdthesis.cls` 中，
写作时只需填内容。

[![GitHub stars](https://img.shields.io/github/stars/zzylanmengqingchuan/TSGUAS-Thesis?style=flat)](https://github.com/zzylanmengqingchuan/TSGUAS-Thesis/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/zzylanmengqingchuan/TSGUAS-Thesis?style=flat)](https://github.com/zzylanmengqingchuan/TSGUAS-Thesis/forks)
[![GitHub issues](https://img.shields.io/github/issues/zzylanmengqingchuan/TSGUAS-Thesis)](https://github.com/zzylanmengqingchuan/TSGUAS-Thesis/issues)
[![GitHub last commit](https://img.shields.io/github/last-commit/zzylanmengqingchuan/TSGUAS-Thesis)](https://github.com/zzylanmengqingchuan/TSGUAS-Thesis/commits/main)

## 仓库内容

```
TSGUAS-Thesis/
├── izdthesis.cls                   ← 模板文档类，格式定义全部在此
├── main.tex                        ← 空白论文骨架（七章结构 + 示例）
├── ref.bib                         ← 参考文献库示例
├── figures/                        ← 封面校徽校名图
├── fonts/                          ← 开源思源宋体/思源黑体（含 OFL 许可证）
└── examples/                       ← 两篇完整范文示例（学校历年下发的范文）
    ├── fanwen01-springcloud/       《基于SpringCloud的企业系统自动生成平台》（2021届）
    └── fanwen02-conferenceroom/    《基于SpringBoot技术的会议室预约管理系统设计与实现》（2022届）
```

- **写自己的论文**：用根目录的空白模板（`izdthesis.cls` + `main.tex`）。
- **看完整效果/学写法**：`examples/` 下两篇范文是学校每年发给同学的范文的
  LaTeX 转录版，内容 100% 覆盖原文，展示了模板在真实论文中的排版效果。
  示例中的 PDF 均为本模板渲染生成，并非学校下发的原始 PDF。

## 效果预览

以下截图均为本模板在 TeXstudio 中经 XeLaTeX 本地编译的实际效果
（左侧为 LaTeX 源码与编译日志，右侧为 PDF 预览）。

### 示例一：《基于SpringBoot技术的会议室预约管理系统设计与实现》（2022 届范文）

![封面页：校徽、中英文题目、信息栏全部由模板自动生成](docs/images/preview-fanwen02-cover.png)

![目录页：标题居中、章条目"第X章"前缀、点线页码全部自动生成](docs/images/preview-fanwen02-toc.png)

![正文页：页眉页码、标题层级、图表编号与浮动排版由模板控制](docs/images/preview-fanwen02-body.png)

### 示例二：《基于SpringCloud的企业系统自动生成平台》（2021 届范文）

![封面页：题目、姓名、学院、导师等通过模板命令填写](docs/images/preview-fanwen01-cover.png)

![目录页：章节目录与页码自动生成，无需手工调整](docs/images/preview-fanwen01-toc.png)

![系统设计章节：架构图、时序图等插图按章自动编号](docs/images/preview-fanwen01-body.png)

## 注意事项

- 本模板为**学生自发整理的开源项目，与学校官方无关**。模板作者虽已按
  指导文件逐条实现格式要求，但仍不免有不足之处；如学院当年下发的文件
  有更新，请以学院最新要求为准。如遇使用 bug 或有改进建议，欢迎提出
  Issue 与 PR。
- 本仓库**不包含**学校 Word 模板所指的"宋体/黑体"字体文件
  （中易 SimSun/SimHei，商业字体，授权不允许再分发）。仓库默认使用开源的
  思源宋体/思源黑体，效果一致；如嵌入字体名须为 SimSun/SimHei，可从本机
  Windows/Office 字体目录自行复制（见下文"关于字体"）。
- 论文的**内容性要求**（字数、页数、查重率、参考文献数量与年限、数据
  真实性等）模板无法替你保证，请务必逐条对照指导文件自查。
- `examples/` 中范文的原作者为对应届别的学长，转录仅供学习模板用法，
  请勿抄袭其论文内容。

## 使用方法

### 1. 准备环境

- **LaTeX 发行版（必需）**：TeX Live 2020+（含 ctex、gbt7714、Fandol 字体，
  完整安装即满足）。Windows 到 [tug.org/texlive](https://tug.org/texlive/)
  下载，macOS 安装 [MacTeX](https://tug.org/mactex/) 即可。
- **编译方式**：XeLaTeX（模板使用了系统字体，不能用 pdfLaTeX）。
- **编辑器（推荐）**：[TeXstudio](https://texstudio.org/)（免费、跨平台）。
  安装后在 选项 → 配置 TeXstudio → 构建 中将"默认编译器"设为 **XeLaTeX**，
  之后打开 `main.tex` 按 **F5** 即可一键编译并预览；也可使用
  VS Code + LaTeX Workshop 插件，编译器同样选择 XeLaTeX。

### 2. 编译

```bash
latexmk            # 自动完成 xelatex + bibtex 多遍编译，生成 main.pdf
latexmk -c         # 清理中间文件
```

或手动：`xelatex main && bibtex main && xelatex main && xelatex main`

### 3. 填写封面与页眉信息

打开 `main.tex`，在导言区填写论文信息，**封面与页眉务必改成自己的
实际情况**：

```latex
\ctitle{你的论文题目}            % 封面中文题目
\etitle{Your Thesis Title}      % 封面外文题目
\stuname{你的姓名}              % 封面：姓名
\college{软件与通信学院}         % 封面：学院
\major{软件工程}                % 封面：专业
\advisor{导师姓名}              % 封面：指导教师
\advisortitle{教授/副教授/讲师}  % 封面：导师职称
\finishdate{2027 年 5 月}       % 封面：完成时间
\gradyear{2027}                % 页眉届别！页眉显示为"天津中德应用技术大学2027届本科生毕业设计（论文）"
```

注意两点：一是 `\gradyear` 决定**每一页页眉**中的届别（"××××届本科生
毕业设计"），毕业年份有变化时一定要改，否则页眉届别会写错；二是
`examples/` 范文中的封面信息属于范文原作者，参考写法即可，不要照抄。

### 4. 撰写正文

1. 填写 `cnabstract`/`enabstract` 中英文摘要（中文摘要 600 字左右、至少
   三段、一页内，末尾 `\keywords{词1；词2；词3}`，英文摘要末尾
   `\enkeywords{...}`）。
2. 正文用 `\chapter{...}` `\section{...}` `\subsection{...}` 撰写；每章自动
   另起一页，编号自动为"第一章 / 1.1 / 1.1.1"。
3. 插图：`figure` 环境自动编号"图2.1"，图题在图下方；表格用 `table`
   环境，表题在表上方，表内字体五号（`\zihao{5}`，骨架中有示例）。
4. 公式：`equation` 环境自动按章编号为"式（3.1）"（中文括号），正文用
   `\ref{eq:xxx}` 引用。
5. 代码：`lstlisting` 环境，五号等宽，每段不超过半页；长代码放
   `\begin{izdappendix}...\end{izdappendix}` 附录（不计入正文字数）。
6. 引用文献：正文 `\cite{key}` 自动生成上标；文末 `\izdbibliography{ref}`
   自动生成 GB/T 7714-2015 格式参考文献。
7. 致谢：`\begin{acknowledgements}...\end{acknowledgements}`（限 1 页）。

### 5. 编译范文示例（可选）

`examples/` 下的示例不带字体文件（避免仓库重复存储），编译前先把根目录
`fonts/` 复制过去：

```bash
cp -r fonts examples/fanwen01-springcloud/
cd examples/fanwen01-springcloud
latexmk            # 生成 main.pdf（约 80 页）
```

`fanwen02-conferenceroom` 同理。

## 格式要求实现情况

对照《软件工程专业毕业设计指导文件 V2.0》逐条核对。已勾选项由模板
自动实现；未勾选项属于写作内容要求，需作者自行保证。

### 总体要求

- [ ] 篇幅：毕业设计页数不低于 30 页（字数不低于 8000 字）
- [ ] 查重率：总体不超过 20%
- [ ] 系统功能一般在 10 个左右

### 布局与页面

- [x] 封面页边距：上 3 cm、下 2.5 cm、左右 3 cm
- [x] 其余页面页边距：上 2.8 cm、下 2.4 cm、左 2.5 cm、右 2.2 cm
- [x] 摘要、ABSTRACT、目录：无页眉、无页码
- [x] 正文起标注页眉（五号、居中）与页码（页脚居中、从第 1 页起）
- [x] 每一章另起一页

### 字体、字号与行距

- [x] 正文：小四号，中文宋体，英文和数字 Times New Roman
- [x] 全文段前段后 0 行，行距 1.25 倍，段首缩进 2 字符
- [x] 一级标题"第 X 章"：小三黑体、顶格居中，与内容间空 4 个半角空格，
      段前段后 0.5 行
- [x] 二级、三级标题：四号黑体、顶格，标号与标题间空 1 个半角空格
- [x] 摘要标题"摘  要"：三号黑体居中（两字间空 2 个全角空格），与内容空一行
- [x] 中文摘要内容：小四号宋体；英文摘要内容：小四号 Times New Roman
- [x] 目录标题"目  录"：三号黑体顶格居中；章条目四号宋体、节条目小四宋体
- [x] 页眉：五号，中文宋体、外文 Times New Roman，居中

### 图、表、公式与代码

- [x] 图、表按章用阿拉伯数字编号（图 2.1、表 3.1），图与表分别排序
- [x] 图题在图下方、表题在表上方，五号宋体居中；编号与名称间空 2 个半角空格
- [x] 表格内容：五号，中文宋体、外文 Times New Roman
- [x] 公式按章编号"式（3.1）"（括号为中文全角括号），换行居中
- [x] 代码：五号字体
- [ ] 每段代码不超过半页（写作要求）
- [ ] 图、表、公式、代码均须配有 1 段以上文字表述（写作要求）

### 摘要与关键词

- [ ] 中文摘要 600 字左右、至少分三段、一页之内完成（写作要求）
- [x] 关键词 3 至 7 个，"关键词"三字小四黑体顶格、中文冒号，
      词间用中文分号隔开，换行悬挂 4 字符
- [x] 英文 Key words 与中文关键词对应，格式一致

### 参考文献

- [x] 标题"参考文献"：四号黑体顶格（与一级标题格式不同，按规范特例处理）
- [x] 条目：五号，中文宋体、外文 Times New Roman，GB/T 7714-2015 格式，
      悬挂缩进
- [x] 正文中按顺序以上角标标注引用
- [ ] 不少于 15 篇、近 5 年文献、外文不少于 2 篇（写作要求）

### 致谢与附录

- [x] 致谢标题"致  谢"：小三黑体居中（两字间空 4 个半角空格），
      内容小四宋体、首行缩进 2 字符
- [ ] 致谢内容限 1 页（写作要求）
- [x] 附录（可选）：小三黑体居中标题，内容不计入正文字数

## 关于字体

学校规范要求：中文宋体/黑体，英文和数字 Times New Roman。

**本仓库不包含中易字体文件（SimSun/SimHei）。** 学校 Word 模板所指的"宋体/黑体"
是微软/中易的商业字体，其授权只允许在安装了 Windows/Office 的本机使用，
**不允许再分发**，因此无法放入公开仓库。本仓库默认使用开源的
**思源宋体/思源黑体**（Source Han Serif/Sans SC，SIL OFL 许可证，见
`fonts/OFL.txt`）——这是开源世界事实标准的宋体/黑体风格字体，开箱即用，
排版风格与规范要求一致。

**如需与学校 Word 模板完全一致的字体效果**（PDF 中嵌入的字体名为 SimSun/SimHei）：
你自己的电脑大概率已经合法拥有这两个字体，只需复制到本项目 `fonts/` 目录，
重新编译即可（模板自动识别，无需改动任何代码）：

- Windows：`C:\Windows\Fonts\simsun.ttc`、`C:\Windows\Fonts\simhei.ttf`
- macOS + Microsoft Office：`/Applications/Microsoft Word.app/Contents/Resources/DFonts/Simsun.ttc`、`SimHei.ttf`

注意：SimSun 没有 Bold 字重，模板按 Word 的做法对宋体加粗做伪粗处理；
只需复制本机字体自用，请勿将字体文件再次分发。

- **英文与数字**：Times New Roman（macOS/Windows 一般自带）；系统没有时自动
  退回开源的 TeX Gyre Termes（与 Times New Roman 等宽兼容）。
- 可切换的字体模式（改 `\documentclass` 的可选参数）：
  - `\documentclass[fandol]{izdthesis}` —— 用 TeX Live 自带的 Fandol 字体，
    不依赖 `fonts/` 目录（体积最小）；
  - `\documentclass[winfonts]{izdthesis}` —— 若学校严格要求中易字体
    SimSun/SimHei（Windows 自带，需系统已安装）；
  - `\documentclass[macfonts]{izdthesis}` —— 用 macOS 系统自带的
    Songti SC/Heiti SC。

## 适用情况

- 适用于天津中德应用技术大学软件与通信学院**软件工程专业**本科毕业设计
  （论文）的写作与排版。
- 本校其他专业若格式要求一致或相近，亦可参照使用，但请自行核对本专业
  当年的格式规范。
- 如学院后续发布新版指导文件，以学院文件为准；也欢迎提交 Issue/PR
  帮助模板跟进更新。

## 说明

本模板由天津中德应用技术大学软件与通信学院软件工程专业 2023 级学生
（2027 届）编写并维护，为学生自发整理的开源项目，与学校官方无关；
格式依据公开的指导文件实现，如与学院最新要求有出入，请以学院当年下发的
文件为准。欢迎 Issue 与 PR。

## 致谢与支持

本项目的模板编写、范文转录与文档撰写均在 [Kimi Code](https://www.kimi.com/)
（AI 编程助手）的协作下完成——这也是"AI 辅助 LaTeX 写作"的一次实践：
相比 Word 需要手动调整格式，LaTeX 源文件可以让 AI 直接参与修改与维护。

如果你觉得这个项目对你有帮助，除了 Star 之外，也可以通过作者的
[Kimi 邀请链接](https://kimi-bot.com/activities/zh-cn/viral-referral/share?scenario=invite&from=share_poster&invitation_code=5ZDWXQ)
注册支持一下：邀请双方均可获得官方抽奖机会（最高可得 1 年会员等值权益）。

## Star History

如果觉得这个项目对你有帮助，欢迎点一个 Star 支持一下：

[![GitHub stars](https://img.shields.io/github/stars/zzylanmengqingchuan/TSGUAS-Thesis?style=social)](https://github.com/zzylanmengqingchuan/TSGUAS-Thesis/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/zzylanmengqingchuan/TSGUAS-Thesis?style=social)](https://github.com/zzylanmengqingchuan/TSGUAS-Thesis/forks)

<a href="https://www.star-history.com/#zzylanmengqingchuan/TSGUAS-Thesis&Date">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=zzylanmengqingchuan/TSGUAS-Thesis&type=Date&theme=dark" />
    <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=zzylanmengqingchuan/TSGUAS-Thesis&type=Date" />
    <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=zzylanmengqingchuan/TSGUAS-Thesis&type=Date" />
  </picture>
</a>
