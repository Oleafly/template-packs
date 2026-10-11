# 图片目录说明
# Figures Directory README

## 【模板水印】此目录用于存放论文图片

请将您的论文图片放置在此目录中。

### 支持的图片格式
- PDF（推荐，矢量图形）
- PNG（适用于截图、位图）
- JPG/JPEG（适用于照片）

### 命名建议
建议采用以下命名规范：
- `章节号-图片描述.pdf`
- 例如：`2-network-architecture.pdf`
- 例如：`3-experiment-result.png`

### 在 LaTeX 中引用图片

```latex
\begin{figure}[ht]
    \centering
    \includegraphics[width=0.8\textwidth]{figures/图片文件名.pdf}
    \caption{图片标题}
    \label{fig:图片标签}
\end{figure}
```

### 注意事项
1. 图片路径相对于主 tex 文件，使用 `figures/文件名` 格式
2. 建议使用 PDF 格式存储矢量图（如流程图、架构图等）
3. 确保图片清晰度足够，建议分辨率不低于 300 DPI
