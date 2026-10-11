// ============================================================
//  代码相关
//    codly    —— 代码块（行号、语言标签、局部高亮）
//    lovelace —— 伪代码 / 算法
// ============================================================

// codly 的配置函数：想给单个代码块换设置就在它前面调 #codly(...)，
// 用 #codly-disable() 恢复成朴素样式。
#import "@preview/codly:1.3.0": codly, codly-disable, codly-enable, codly-offset, codly-range

// #pseudocode-list[...] 写算法伪代码
#import "@preview/lovelace:0.3.0": *
