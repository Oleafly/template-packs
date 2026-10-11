# 厦门大学本科生课程论文 LaTeX 模板

Xiamen University Undergraduate Course Paper LaTeX Template

## 简介

本模板依据《厦门大学学报（哲学社会科学版）》排版规范编写，适用于厦门大学本科生课程论文的撰写与排版。

## 文件说明

```
├── xmu_course.cls    # 文档类文件（核心模板）
├── main.tex          # 主文件（含配置注释，可直接修改使用）
├── example.tex       # 完整示例文件（含范文）
├── logo/             # 校徽与校名图片
│   ├── logo.png      #   厦门大学校徽（5.48cm × 5.48cm）
│   └── logotype.png  #   厦门大学鲁迅体校名（6.96cm × 2.51cm）
├── typeface/         # 字体文件
│   ├── SimSun.ttc    #   宋体（正文）
│   ├── SimHei.ttf    #   黑体（二级标题）
│   ├── SimKai.ttf    #   楷体（一级标题/作者简介）
│   ├── Deng.ttf      #   等线 Regular（封面）
│   ├── Dengb.ttf     #   等线 Bold
│   └── Dengl.ttf     #   等线 Light
└── README.md         # 本文件
```

## 使用方法

### 1. 本地编译（推荐）

**环境要求：**
- TeX Live 2020 及以上（或 MiKTeX）
- XeLaTeX 编译引擎
- Windows 系统（等线字体已包含在 typeface/ 中）
- 可选：gbt7714 宏包（参考文献国标格式）

**编译命令：**
```bash
xelatex main.tex
xelatex main.tex   # 需要两次编译以生成目录/交叉引用
```

也可使用 `latexmk`:
```bash
latexmk -xelatex main.tex
```

### 2. Overleaf 编译

1. 新建项目，将所有文件（包括 `typeface/` 目录下的字体）上传至项目根目录
2. 编译器选择 **XeLaTeX**
3. 编译两次以生成完整的交叉引用

## 封面配置

在 `main.tex` 中通过以下命令配置封面信息：

```latex
\covertitle{2023--2024学年\ 春季学期期末论文}  % 封面大标题
\coursename{课程名称}                            % 课程名称
\classinfo{周X\ 第XX节}                          % 班级/上课时间
\college{所在学院}                               % 学院
\major{专业名称}                                 % 专业
\grade{XXXX级}                                   % 年级
\authorname{姓名}                                % 姓名
\studentid{学号}                                 % 学号
\coverdate{20XX年X月}                            % 日期
```

使用 `\makecover` 生成封面。

## 正文排版规范

| 要素         | 字体       | 字号     | 说明                       |
| ------------ | ---------- | -------- | -------------------------- |
| 中文篇名     | 宋体       | 二号     | 不超过 20 字，末尾无标点   |
| 作者署名     | 楷体       | 四号     | 居中                       |
| 作者单位     | 宋体       | 小五号   | 加圆括号，居中             |
| 中文摘要     | 宋体       | 小五号   | 200--500 字                |
| 关键词       | 宋体       | 小五号   | 3--5 个，分号隔开          |
| 正文         | 宋体       | 五号     | 单倍行距，42 字 × 42 行   |
| 一级标题     | 楷体       | 四号     | 居中                       |
| 二级标题     | 黑体       | 五号     | 左对齐                     |
| 图表内文字   | —          | ≤小五号  | 表格使用三线表             |
| 脚注         | 宋体       | 小五号   | 圈码编序，当页地脚         |
| 参考文献     | 宋体       | 小五号   | GB/T 7714 格式             |
| 作者简介     | 楷体       | 小五号   | 首页地脚                   |

## 页边距

- 上下：2.54 cm
- 左右：3.18 cm
- 纸张：A4

## 注意事项

1. **字体：** 所有必需字体（宋体、黑体、楷体、等线）均已包含在 `typeface/` 目录中，可直接跨平台使用。模板优先加载本地字体文件，找不到时回退到系统字体。
2. **编译引擎：** 必须使用 XeLaTeX，不支持 pdfLaTeX。
3. **参考文献：** 若安装了 `gbt7714` 宏包，可使用 `\bibliography` 自动格式化；否则请使用 `thebibliography` 环境手动编排。
4. **数字格式：** 正文中数字请使用宋体（Times New Roman 风格的阿拉伯数字）。

## 许可

MIT License
