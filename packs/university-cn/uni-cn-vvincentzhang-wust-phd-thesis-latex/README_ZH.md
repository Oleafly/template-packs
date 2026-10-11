# WUST-PhD-Thesis-Latex

WUSTThesis.cls 2025/05/15 version V1.0

---

武汉科技大学（WUST）博士/硕士学位论文非官方 LaTeX 模板。

---

## 环境要求

- **TeX 发行版：** TeX Live 2024+ / MiKTeX
- **编译引擎：** XeLaTeX（必须）
- **参考文献：** BibTeX

## 快速开始

### 使用 latexmk（推荐）

```bash
# 编译
latexmk -xelatex main.tex

# 清理编译产物
latexmk -c main.tex

# 彻底清理（含 PDF）
latexmk -C main.tex
```

### 手动编译

```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

### Overleaf

将整个项目上传到 Overleaf，编译器选择 **XeLaTeX**。

## 项目结构

```
├── main.tex          # 主入口文件
├── WUSTthesis.cls    # 文档类
├── WUSTThesis.bst    # 参考文献格式
├── WUSTtils.sty      # 辅助宏包
├── .latexmkrc        # latexmk 配置文件
├── body/             # 所有章节 .tex 文件
│   ├── cover.tex     # 封面信息（标题、作者等）
│   ├── chap01.tex ~ chap04.tex  # 章节（根据自己需要增减）
│   ├── conclusion.tex
│   ├── ack.tex       # 致谢
│   ├── publications.tex   # 附录：发表论文
│   └── project.tex   # 附录：参与项目
├── figures/          # 图片文件
├── font/             # 中文字体文件（用于 Overleaf 等环境）
└── ref/
    └── refs.bib      # 参考文献数据库
```

## 使用说明

1. 在 `main.tex` 中选择模式：
   - `draftformat` — 草稿（页眉显示学校名称）
   - `finalformat` — 盲审（页眉不显示学校名称）
2. 在 `body/cover.tex` 中填写自己的论文信息（标题、作者、导师、摘要等）
3. 在 `body/` 目录下按需增加或减少章节，并在 `main.tex` 中对应修改 `\include`
4. 参考文献放入 `ref/refs.bib`

---

## 致谢

基于 [HUST-PhD-Thesis-Latex](https://github.com/XinzeZhang/HUST-PhD-Thesis-Latex) (V3.1) 修改制作。

感谢贡献者：Lianghao Li, Jianqing Lin (2021 V3.1), Xinze Zhang (2020 V3.0), Huikan Liu (2006 V2.0), Feng Jiang (2005 V1.0).

贡献者：Wancheng Zhang (zhangwancheng@wust.edu.cn)

---

+ 尽量还原武汉科技大学官方《博士论文编排式样（理工类）.doc》文档的样式
+ 目前还没实现英文目录的生成，还有一些地方需要进一步优化
+ 当前版本已足够使用（本人已使用该模板完成毕业论文的撰写）
+ 本人水平有限，期待更多人参与进来，继续完善该模板，谢谢
