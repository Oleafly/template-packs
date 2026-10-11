= 快速入门

== 模板简介

本模板是基于 Typst 排版系统开发的复旦大学学位论文模板，以《复旦大学博士、硕士学位论文规范（2026 年 6 月修订版）》为依据。Typst 是一种现代化排版系统，相比 LaTeX 具有编译速度更快、语法更简洁、错误提示更友好等优势。

模板支持以下学位论文类型：

- *博士学位论文*（默认）：设置 `degree: "doctor"`，可选 `degree-category: "学术学位"` 或 `"专业学位"`
- *硕士学位论文*：设置 `degree: "master"`，可选 `degree-category: "学术学位"` 或 `"专业学位"`
- *本科毕业论文（设计）*：设置 `degree: "bachelor"`

模板自动处理封面、声明页、摘要、目录、页眉页脚、图表编号、参考文献格式等排版细节，用户只需专注于论文内容的撰写。

== 环境准备

=== 安装 Typst

Typst 是一种现代化的排版系统，具有编译速度快、语法简洁的特点。安装方法如下：

+ 访问 Typst 官方网站 #link("https://typst.app") 下载对应平台的安装包
+ 或通过包管理器安装：
  - macOS：`brew install typst`
  - Windows：`scoop install typst`
  - Linux：`cargo install --git https://github.com/typst/typst --locked typst-cli`
  - Arch Linux：`pacman -S typst`
+ 安装完成后在终端运行 `typst --version` 验证安装

=== 安装编辑器（推荐 VS Code）

推荐使用 VS Code 配合 Tinymist 插件进行编辑，操作步骤如下：

+ 安装 VS Code（#link("https://code.visualstudio.com/")）或 Cursor（#link("https://www.cursor.com/")）
+ 在扩展商店中搜索并安装 `Tinymist Typst` 插件
+ 安装后打开 `.typ` 文件即可获得语法高亮、自动补全功能
+ 按 `Ctrl+Shift+P`（macOS 为 `Cmd+Shift+P`）输入 "Typst Preview" 可开启实时预览

=== 安装中文字体

模板需要中文字体支持。不同操作系统的字体安装方式如下：

*Windows 用户*：系统自带宋体（SimSun）、黑体（SimHei）等字体，通常无需额外安装。

*macOS 用户*：系统自带华文字体（STSongti、STHeiti 等），通常无需额外安装。

*Linux 用户*：推荐安装 Noto CJK 字体：

```bash
# Ubuntu / Debian
sudo apt install fonts-noto-cjk fonts-noto-cjk-extra

# Fedora
sudo dnf install google-noto-serif-cjk-sc-fonts google-noto-sans-cjk-sc-fonts

# Arch Linux
sudo pacman -S noto-fonts-cjk
```

也可以将 Windows 字体（`simsun.ttc`、`simhei.ttf` 等）复制到 `/usr/share/fonts/` 目录下，然后运行 `sudo fc-cache -fv` 刷新字体缓存。

可通过以下命令查看系统已安装的字体：

```bash
typst fonts
```

=== 获取模板

从 GitHub 仓库克隆模板项目：

```bash
git clone https://github.com/MobtgZhang/fdu-typst-thesis.git
cd fdu-typst-thesis
```

需要确保项目根目录下有 `images/fudan-name.png`（复旦大学校名图片），该图片用于生成封面。

== 项目结构

模板的目录结构如下：

```
fdu-typst-thesis/
├── main.typ                 主入口文件（编辑论文信息和章节组织）
├── typst.toml               Typst 包配置
├── images/
│   └── fudan-name.png       校名图片（封面用）
├── ref/
│   └── references.bib       参考文献数据库（BibTeX 格式）
├── template/                模板核心文件
│   ├── thesis.typ           模板主入口（组装全部页面）
│   ├── config.typ           字号、字体、页边距配置
│   ├── utils.typ            工具函数（中文编号、日期格式化等）
│   ├── components.typ       可复用组件（三线表等）
│   ├── styles.typ           页眉页脚样式
│   └── pages/
│       ├── cover.typ        封面页（研究生/本科/盲审）
│       ├── declaration.typ  独创性声明和授权声明
│       ├── committee.typ    扉页（指导小组成员名单）
│       ├── abstract-zh.typ  中文摘要页
│       ├── abstract-en.typ  英文摘要页
│       └── outline-page.typ 目录页
└── chapters/                论文正文内容
    ├── abstract.typ         摘要内容（中英文）
    ├── chapter1.typ         第一章（本文件）
    ├── chapter2.typ         第二章
    ├── chapter3.typ         第三章
    ├── appendix.typ         附录
    └── acknowledgements.typ 致谢
```

使用模板时，主要需要编辑的文件是：

- `main.typ` — 配置论文信息（标题、作者、学位类型等）
- `chapters/abstract.typ` — 编写中英文摘要和关键词
- `chapters/chapter*.typ` — 编写各章节正文
- `chapters/acknowledgements.typ` — 编写致谢内容
- `chapters/appendix.typ` — 编写附录内容（可选）
- `ref/references.bib` — 添加参考文献

`template/` 目录下的文件是模板核心，一般情况下无需修改。

== 基本配置

=== 论文信息配置

在 `main.typ` 中通过 `info` 参数配置论文基本信息。以下是一个完整的配置示例：

```typst
#show: thesis.with(
  info: (
    // 中文标题（不超过30个汉字）
    title: "基于深度学习的自然语言处理关键技术研究",
    // 英文标题
    title-en: "Research on Key Technologies of NLP Based on Deep Learning",
    // 作者姓名
    author: "张三",
    // 学号
    student-id: "21110000000",
    // 培养单位正式名称
    school: "计算机科学技术学院",
    // 学科专业（学术学位与专业学位均使用此字段）
    major: "计算机科学与技术",
    // 指导教师（姓名+全角空格+职称）
    supervisor: "李四　教授",
    // 副指导教师（可选，不需要则设为 none）
    supervisor-second: none,
    // 学位类型（默认 "doctor"）
    degree: "doctor",
    // 学位类别（可选）
    degree-category: "学术学位",
    // 密级（非涉密论文设为 none）
    secret-level: none,
    // 论文提交日期
    date: datetime.today(),
    // 中图分类号
    clc: "TP391",
  ),
  // ...
)
```

=== 学位类型说明

`degree` 参数控制论文类型，不同类型的封面样式和页眉文字有所不同：

- `"doctor"` — 博士学位论文（默认），封面显示"博士学位论文"
- `"master"` — 硕士学位论文，封面显示"硕士学位论文"
- `"bachelor"` — 本科毕业论文，封面显示"本科毕业论文（设计）"

`degree-category` 参数控制学位类别（仅硕博有效）：

- `"学术学位"` — 封面显示“（学术学位）”，专业字段名为“学科专业”
- `"专业学位"` — 封面显示“（专业学位）”，专业字段名同样为“学科专业”
- `none` — 不显示学位类别

=== 编译选项

除了论文信息外，`main.typ` 中还有以下编译选项：

```typst
#show: thesis.with(
  // 盲审模式（隐藏个人信息）
  blind: false,
  // 双面打印模式
  twoside: true,
  // 目录深度（默认显示到三级标题）
  outline-depth: 3,
  // 生成插图目录
  list-of-image: false,
  // 生成表格目录
  list-of-table: false,
  // ...
)
```

=== 指导小组成员（扉页）

如需生成扉页，设置 `committee` 参数：

```typst
committee: (
  "张三　教授　　复旦大学",
  "李四　副教授　复旦大学",
  "王五　研究员　中国科学院",
),
```

设为 `none`（默认）则不生成扉页。

== 编译方法

=== 基本编译

```bash
typst compile main.typ
```

编译成功后在当前目录生成 `main.pdf` 文件。

=== 实时预览

使用 `watch` 命令可以在保存文件后自动重新编译：

```bash
typst watch main.typ
```

配合 PDF 阅读器即可实现实时预览效果。如果使用 VS Code + Tinymist 插件，可以直接在编辑器内预览。

=== 盲审模式

盲审模式会自动隐藏以下信息：封面上的作者姓名、学号、培养单位、指导教师；声明页；致谢内容。

通过命令行参数启用盲审模式：

```bash
typst compile --input blind=true main.typ
```

也可以在 `main.typ` 中直接设置 `blind: true`。命令行参数的优先级高于文件中的设置。

=== 双面打印

启用双面打印模式后，一级标题从奇数页（右侧页）开始，章节之间会自动插入空白页：

```bash
typst compile --input twoside=true main.typ
```

=== 指定字体路径

如果系统缺少所需字体，可以指定字体文件所在目录：

```bash
typst compile main.typ --font-path /path/to/your/fonts/
```

=== 组合使用命令行参数

多个参数可以同时使用：

```bash
typst compile main.typ --input blind=true --input twoside=true --font-path ./fonts/
```
