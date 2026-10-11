// 定理类环境：基于 theorion（简单样式，按章编号，支持 @ 引用，引用前缀 thm:）
// 参考 LaTeX 模板的 amsthm 素雅风格：无底色边框，环境名与编号连排
// 内置环境：theorem/definition/lemma/corollary/proposition/example/proof 等
#import "@preview/theorion:0.6.0": *
#import cosmos.simple: *

#show: show-theorion

// 按章编号：定理 2-1（与图表公式格式一致）
#set-theorion-numbering("1-1")
#set-inherited-levels(1)
