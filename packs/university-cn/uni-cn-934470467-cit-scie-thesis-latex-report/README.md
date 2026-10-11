> 修改方式，只需要把你当前的cls替换成现在的cls即可


## 2026.5.27 修改 与《V9格式规范》对照微调
1. 独创性声明标题去掉加粗（V9 中该标题为非加粗）。
2. 中文摘要的中文题目去掉加粗（V9 中"中文摘要标题"样式无加粗）。
3. 封面日期改用阿拉伯数字格式"2026 年 5 月"，并修正字体：数字使用 Times、中文使用宋体（原版因缺少 `\selectfont` 数字与中文大小不一致）。
4. 目录各级条目段前距由 0pt 调整为 6pt，避免条目过密。
5. 英文摘要"ABSTRACT"改为"Abstract"（英文题目保持全大写）。
6. 附录页不再出现在目录中（删除 `\addcontentsline`）。

## 2026.5.13 修改 页眉、图表题与代码块示例
1. 将正文、中文摘要、英文摘要页眉统一为楷体五号，避免摘要页与正文页眉字体不一致。
2. 删除正文示例中额外的 `\captionsetup{font={small}}`，使图题、表题都使用模板统一的五号宋体 + Times New Roman 设置。
3. 清理正文示例中重复加载的全局宏包，避免用户正文覆盖模板排版设置。
4. 修正模板选项转发目标为 `ctexart`，并显式加载 `etoolbox`，提高模板依赖稳定性。
5. 去掉表题 `skip` 的重复覆盖，保留模板中表题上方位置和间距设置。
6. 删除原先将代码清单作为“图”编号的浮动体定义，代码块仅作为普通灰底 `lstlisting` 展示，不再自动标注为图或代码清单。
7. 在示例正文中增加无编号代码块和算法环境示例，用于验证代码块灰底和算法编号能正常编译。

## 2026.5.11 修改 左右边距
1. 为了正文观感更美观，将模板正文左右边距从3.0cm调整为 2.1cm。
2. 如果需要自己修改页边距，请打开 `graduate-design-manual.cls`，在 `\geometry{...}` 中调整 `left` 和 `right` 的数值。

## 2026.5.8 修改 一系列小bug
1. 去掉 图 表标题加粗
2. 图 1-1内空格
3. 行距统一
4. 页眉headheight
5. 目录页码bug（有个版本改出问题了之前）
6. 中英文混排换行问题 （讨论的最多的，LaTeX底层问题，避免那种长路径长函数名在论文中，也可以人工微调）
7. 代码块有中文注释出现断行
8. 封面第二行下划线有点贴字

# 常州工学院毕业设计说明书（论文）LaTeX 模板

本模板依据《常州工学院计算机信息工程学院毕业设计说明书（论文）格式规范》定制开发。

## 1. 项目简介
本模板旨在为常州工学院计算机学院的学生提供一个标准化的 LaTeX 排版环境，自动处理封面绘制、目录生成、中英文摘要、正文格式（标题间距、行距、字间距）、公式编号、参考文献引用等繁琐的排版工作。

## 2. 环境要求
* **LaTeX 编译器**: 必须使用 **XeLaTeX**（以支持 `xeCJK` 宏包和本地字体调用）。
* **参考文献工具**: BibTeX (配合 `gbt7714` 样式)。
* **操作系统**: Windows / macOS / Linux (已配置跨平台字体路径兼容)。

## 3. 获取模板

推荐使用浅克隆，只获取最新一层提交，不下载完整历史记录：

```bash
git clone --depth 1 https://github.com/934470467/cit-scie-thesis-latex.git
```

如果已经克隆过仓库，后续更新可在项目目录中执行：

```bash
git pull
```

## 4. 编译

支持 Overleaf、VSCode(LaTeX Workshop)、TeXstudio 等主流工具平台外。我们也提供了基于 `make` 的命令行编译方式。

`make` 编译方式适合 macOS、Linux 和 Windows WSL 环境；Windows 原生 cmd / PowerShell 用户建议使用 Overleaf、VSCode(LaTeX Workshop) 或 TeXstudio 编译。

请使用 `XeLaTeX + BibTeX` 完成论文编译。

make相关命令：
```bash
# 编译命令，项目根目录只保留最终生成的 report.pdf，所有中间文件会输出到 .tmp/
make

# 删除中间过程文件
make clean

# 删除中间过程文件和最终pdf
make distclean
```

## 5. Overleaf 上传说明

如果要上传到 Overleaf，可以将项目目录压缩为 zip 后上传。

如果 Overleaf 提示 zip 文件过大，优先删除压缩包里的 `.git` 文件夹；该目录只保存 Git 历史记录，删除后不会影响 LaTeX 编译。也建议不要上传 `.tmp/`、`.DS_Store` 等临时文件。

## 6. 目录结构说明
```text
.
├── graduate-design-manual.cls   # 核心类文件：定义了论文的所有格式规范
├── report.tex                   # 论文主文件 (如适用)
├── report.bib                   # BibTeX 参考文献数据库
├── Makefile                     # make 编译入口
├── fonts/                       # 本地字体库 (必须包含，由 .cls 文件调用)
│   ├── Simsun.ttc               # 宋体
│   ├── SimHei.ttf               # 黑体
│   ├── Kaiti.ttf                # 楷体
│   ├── STZHONGS.ttf             # 华文中宋
│   ├── times.ttf                # Times New Roman
│   └── arial.ttf                # Arial
├── figures/                     # 插图文件夹
│   ├── cit-name.pdf             # 封面校名矢量图
│   └── cit-name.png             # 封面校名图片
└── gbt7714/                     # 参考文献 GB/T 7714 标准样式包
```

如有更改需求，请PR提交。
