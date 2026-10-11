#let ledger = (
  id: "project-ledger",
  source-refs: ("source/projects.md：proj-003.名称、时间、技术、实现、测试与边界",),
  review-notes: ("本地个人练习，没有银行接入或真实用户。",),
  dates: "2024 秋季学期",
  title: "命令行账本与 CSV 对账工具",
  role: "个人练习",
  stack: ("Python", "CSV", "argparse", "pytest"),
  bullets: (
    "实现 CSV 记录导入、按月和类别汇总、重复记录检测及错误行报告，校验交易日期与金额字段。",
    "使用 argparse 组织命令行参数，为导入、重复检测和汇总逻辑编写 18 个 pytest 用例，示例环境 18/18 通过。",
  ),
)
