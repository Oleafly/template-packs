= 排版实验及结果讨论

本章介绍用Typst软件排版学位论文的实际操作步骤。

== 安装Typst软件

#let marker(it) = {
  box(fill: yellow, stroke: gray, outset: 2pt, it)
}

=== 基于VS Code + tinymist插件
对大多数同学使用Typst的方式是通过Virtual Studio Code编辑器的tinymist插件。安装和使用的步骤如下：
+ 下载安装VS Code编辑器本身，具体方法见官方网站说明。
+ 打开VS Code，关注界面左上角

  #figure(
    caption: [VS Code界面],
    block({
      image("../assets/screenshot-tinymist-install.png")
      place(left + horizon, dx: 3pt, dy: 6pt)[#marker[1]]
      place(left + top, dx: 2cm, dy: 1.5cm)[#marker[2]]
      place(left + top, dx: 2cm, dy: 2.8cm)[#marker[3]]
    }),
  )
+ 点击 #marker[1] ，切换到插件管理面板。
+ 点击 #marker[2] 处输入框，输入`tinymist`。
+ 点击 #marker[3] 处图标，安装tinymist插件。

=== 基于命令行
Typst本质上是一个命令行编辑器，可以通过以下命令生成 `.pdf`文件。
```sh
typst main.typ --output pdf
```
这种方式与编辑器的搭配更灵活，适合有命令行基础的同学。使用方法详情见官方文档。
=== 其他
Typst官方提供在线编辑功能，可以免费使用，详情见官方网站。另外Typst可以作为模块被Python程序调用，详情见`typst-py`项目。


== 下载示例代码
从下列网址下载模板代码，存储到本地目录中。
```
https://codeberg.org/SWJTU-XYH/typst-swjtu-template
```

== 论文写作

=== 打开项目

+ 用VS Code编辑器打开本地的`typst-swjtu-template`目录。注意，是打开目录而不是目录中的具体文件。
  #figure(
    caption: [Tinymist预览],
    block({
      image("../assets/screenshot-tinymist-preview.png")
      place(center + top, dx: -3pt, dy: 1.5cm)[#marker[1]]
    }),
  )
+ 点击 #marker[1] ，打开预览面板。

此时窗口右侧的预览面板中应该出现本文的页面。

=== 替换基本信息

=== 开始写作

== 导出和打印
