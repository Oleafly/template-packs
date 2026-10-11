# 🚀 SEU XiaoBao LaTeX 模板

东南大学校庆研究生学术报告会论文 LaTeX 模板（非官方） 使用需谨慎！

本模板目前仍在持续迭代中，欢迎大家提交 Issue 和 PR，共同完善。

## 📢 Latest News  
- **2026.03.30** - 校报投稿会有志愿者审阅格式：**请优先使用官方word模板！以免带来不便**
- **2026.03.12** - 调整作者简介部分、调整文中引用、调整行间距
- **2026.03.11** - 创建项目

## 📚 效果预览
![alt text](figures/image.png)

编译 `template.tex` 即可查看完整排版效果，模板已按报告会征稿要求配置好页面、字体、页眉页脚、双栏、标题层级、图表标题、参考文献等格式。

## 🖥️ 项目结构

```
├── seu-report.cls          % 文档类（核心样式文件）
├── template.tex            % 模板示例（可直接修改使用）
├── figures/
│   ├── seu-color-logo.png  % 页眉校徽
│   └── seu-color-logo2.png % 示例插图
├── .latexmkrc              % latexmk 编译配置
└── .vscode/settings.json   % VS Code LaTeX Workshop 配置
```

## 📜 快速开始

### 方式一：Overleaf（推荐）
需要会员账号，如没有会员推荐方式二。

1. 下载本项目 ZIP（GitHub 页面点击 Code → Download ZIP）
2. 打开 [Overleaf](https://www.overleaf.com)，点击 New Project → Upload Project
3. 上传 ZIP 文件
4. 在 Overleaf 左上角 Menu 中，将编译器设置为 **XeLaTeX**
5. 点击 Recompile 即可

### 方式二：VS Code本地编译（推荐）

1. 安装 TeX Live（2020+）
2. 安装 [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) 扩展
3. 打开项目文件夹，项目已包含 `.vscode/settings.json` 配置
4. 打开 `template.tex`，按 `Ctrl+Alt+B` 编译

## 使用说明

编辑 `template.tex`，修改以下元信息命令填入你的论文内容：

```latex
\cnTitle{中文标题}
\enTitle{English Title}
\cnAuthor{作者1\textsuperscript{1}，作者2\textsuperscript{2}}
\enAuthor{Author1\textsuperscript{1}, Author2\textsuperscript{2}}
\cnInstitute{（1.单位，城市，邮编；2.单位，城市，邮编）}
\enInstitute{(1. Department, City, Zip; 2. Department, City, Zip)}
\cnAbstract{中文摘要内容}
\enAbstract{English abstract content}
\cnKeywords{关键词1；关键词2；关键词3}
\enKeywords{Keyword1; Keyword2; Keyword3}
\authorInfo{作者简介：...}
\fundInfo{基金项目：...}       % 无基金可删除此行
```

## 字体说明

模板使用以下字体：

| 用途 | 字体 |
|------|------|
| 英文正文 | Times New Roman |
| 中文宋体 | SimSun |

## License

本模板仅供学术交流使用，与东南大学官方无关。
