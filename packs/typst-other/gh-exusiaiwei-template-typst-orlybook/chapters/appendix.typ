= 附录

== 附录 A：Python 安装指南

=== Windows

+ 访问 https://python.org 下载安装包
+ 运行安装程序，*务必勾选 "Add Python to PATH"*
+ 打开命令提示符，输入 `python --version` 验证安装

=== macOS

```bash
# 使用 Homebrew 安装
brew install python3

# 验证安装
python3 --version
```

=== Linux

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3 python3-pip

# 验证安装
python3 --version
```

== 附录 B：常用库速查表

#figure(
  table(
    columns: 3,
    [*库名*], [*用途*], [*安装命令*],
    [NumPy], [数值计算], [`pip install numpy`],
    [Pandas], [数据分析], [`pip install pandas`],
    [Matplotlib], [数据可视化], [`pip install matplotlib`],
    [Requests], [HTTP 请求], [`pip install requests`],
    [Flask], [Web 框架], [`pip install flask`],
  ),
  caption: [Python 常用第三方库]
)

== 附录 C：参考资源

- *官方文档*：https://docs.python.org
- *Python 教程*：https://docs.python.org/tutorial
- *PEP 8 风格指南*：https://pep8.org
- *Real Python*：https://realpython.com
