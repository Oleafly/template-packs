// config.typ — 论文配置文件
// 对应 LaTeX 版 thesis_config.tex，集中管理所有可配置变量
//
// 【使用说明】
// 修改下面引号中的内容即可自定义你的论文信息。
// Typst 中用 #let 定义变量，类似于编程语言中的常量声明。
// 字符串用英文双引号 "..." 包裹。

// ===== 个人信息 =====
#let student-name = "藤田琴音"
#let student-id = "1145141919810"
#let advisor = "万代南梦宫"
#let advisor-title = "教授"
#let school = "初星学院"
#let major = "偶像科"
#let class-name = "2025"

// ===== 论文信息 =====
#let thesis-title = "现今各个游戏企划中偶像元素的凸显"
#let thesis-english = "The Prominence of Idol Elements in Contemporary Game Planning"
#let keywords = "偶像，游戏企划，文化现象，市场分析，粉丝经济"
#let english-keywords = "Idols, Game Planning, Cultural Phenomenon, Market Analysis, Fan Economy"

// ===== 机构与日期 =====
#let university = "武汉理工大学"
#let degree = "本科生毕业设计（论文）开题报告"
#let submit-date = "2026年 2 月 28 日"

// ===== 辅助函数 =====

/// 红色提示文本，用于标记待填写内容
/// 用法：在正文中写 #todo[这里需要补充数据] 会显示红色提示
#let todo(body) = text(fill: red, size: 9pt, weight: "bold")[【提示: #body】]
