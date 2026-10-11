#let library = (
  id: "project-library",
  source-refs: (
    "source/projects.md：proj-002.时间、模拟数据、技术、个人分析工作、验证方法及 MAE 结果",
  ),
  review-notes: ("模拟数据课程实验；7.8 与 9.4 的 MAE 只适用于一次示例验证切分。",),
  dates: "2025 秋季学期",
  title: "图书借阅趋势分析与需求预测",
  role: "个人课程实验",
  stack: ("Python", "pandas", "NumPy", "Matplotlib", "scikit-learn", "statsmodels"),
  bullets: (
    "基于 2,400 条含 12 项字段的模拟借阅记录，完成缺失值处理、按月聚合、类别占比和借阅时长分析，并绘制趋势与分组图。",
    "以每月各类别借阅量为目标，按时间顺序切分数据，对比季节性基线、线性回归与随机森林；将清洗、特征构造和评估拆为可复用函数。",
    "在该模拟数据的一次验证切分中，随机森林 MAE 为 7.8 本/月，季节性基线为 9.4 本/月；报告展示预测曲线、残差图和误差表。",
  ),
)
