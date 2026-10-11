# 信网学院本科毕业设计 LaTeX 模板

这份模板根据原始 Word 文件 `信网学院本科毕业设计模板（2024）.docx` 手工整理而成，已经补齐了以下结构：

- 封面
- 独创性声明
- 使用授权书
- 中文摘要、英文摘要
- 目录
- 正文标题层级
- 图、表、公式、代码示例
- 致谢、参考文献
- 图目录、表目录

## 文件说明

- `main.tex`：主模板，直接编辑这个文件即可
- `assets/pup-emblem.jpeg`：从原 Word 模板提取出的校徽

## 使用方式

建议使用 XeLaTeX 编译：

```bash
xelatex main.tex
xelatex main.tex
```

如果你本地安装了 `latexmk`，也可以用：

```bash
latexmk -xelatex main.tex
```

## 你最常需要改的地方

打开 `main.tex` 顶部这几项，按自己的信息替换：

- `\\thesistitlecn`
- `\\thesistitleen`
- `\\studentname`
- `\\studentid`
- `\\college`
- `\\grade`
- `\\major`
- `\\company`
- `\\advisor`
- `\\cnabstracttext`
- `\\cnkeywords`
- `\\enabstracttext`
- `\\enkeywords`

## 说明

- 模板默认按 A4 纸、正文宋体小四、1.5 倍行距、页眉横线、页脚居中页码进行配置。
- 图表标题、目录标题、章节层级已经尽量向原 Word 模板靠齐。
- 当前环境里没有安装 LaTeX 引擎，所以我没有在这里完成实际编译校验；如果你本地编译后发现学校还有更细的格式要求，我们可以继续一起微调。
