// 只保存文档级配置。布局候选不得写入页面已用高度等反馈状态。

#let mode-state = state("physics-handout-mode", "student")
#let theme-state = state("physics-handout-theme", none)
#let metadata-state = state("physics-handout-metadata", (:))
// 题目编号按语义分类分组，而不是按 choice/calculation 等题型分组。
// 具体 series 配置由 handout 入口写入，计数器由 questions.typ 按 series 延迟创建。
#let question-series-state = state("physics-handout-question-series", (:))
