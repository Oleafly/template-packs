// ============================================================
// 示例：使用模板创建用户手册
// 说明: 此文件展示了如何使用模板的各种组件
// ============================================================

#import "template.typ": *

// ======================= 配置信息 =======================
#let config = (
  software-name: "企业数据管理平台",
  software-short-name: "数据平台",
  version: "V2.0",
  doc-title: "用户手册",
  author: "XX科技有限公司",
  date: "2025年12月",
)

#show: doc => setup-page(doc, config)

// ======================= 封面页 =======================
#cover-page(config)

// ======================= 目录页 =======================
#toc-page()

// ======================= 正文 =======================
#pagebreak()

= 简介

== 编写目的

本用户手册旨在为【#config.software-name】的用户提供全面、详细的操作指导。

#tip-box("这是使用模板中 tip-box 组件的示例，类型为 info（信息提示）", type: "info")

#v(0.5em)

#tip-box("这是警告类型的提示框示例", type: "warning")

#v(0.5em)

#tip-box("这是危险类型的提示框示例", type: "danger")

#v(0.5em)

#tip-box("这是成功类型的提示框示例", type: "success")

== 系统背景

这里展示功能卡片组件的使用：

#feature-card("功能卡片示例", "这是使用 feature-card 组件创建的功能卡片，可以用来突出显示重要功能或特性说明。")

#v(0.5em)

#feature-card("另一个功能卡片", "支持创建多个卡片并排或堆叠展示。")

#pagebreak()

= 软件概述

== 功能模块

这里展示信息表格组件的使用：

#info-table(
  [项目], [说明],
  [软件名称], [#config.software-name],
  [版本号], [#config.version],
  [开发团队], [#config.author],
  [编制日期], [#config.date],
)

== 技术特点

这里展示徽章组件的使用：

系统支持三种状态显示：#badge("正常", color: colors.success) #badge("警告", color: colors.warning) #badge("异常", color: colors.danger)

#divider()

这里展示步骤列表组件的使用：

#step-list(
  "打开浏览器，输入系统地址",
  "输入用户名和密码进行登录",
  "进入系统主界面，开始使用各项功能",
  "完成操作后，点击退出按钮安全退出系统",
)

#pagebreak()

= 使用说明

== 系统登录

=== 功能描述

系统采用Web浏览器访问方式。

=== 处理逻辑

这里展示键盘快捷键组件的使用：

常用快捷键：按 #kbd("Ctrl") + #kbd("S") 保存，按 #kbd("Ctrl") + #kbd("F") 搜索

=== 页面截图

这里展示截图占位符组件的使用：

#screenshot-placeholder("请在此处插入登录界面截图")

== 数据管理

=== 功能描述

数据管理模块提供数据的增删改查功能。

=== 处理逻辑

这里展示代码块组件的使用（如果您的软件涉及代码）：

#code-block("// 示例代码
function processData(data) {
  return data.filter(item => item.active);
}", lang: "javascript")

=== 页面截图

#screenshot-placeholder("请在此处插入数据管理界面截图")

#pagebreak()

= 常见问题解答

*问题：如何重置密码？*

解答：点击登录页面的"忘记密码"链接，按照提示操作即可重置密码。

*问题：系统支持哪些浏览器？*

解答：建议使用 Chrome 90+、Firefox 88+、Edge 90+ 等现代浏览器。
