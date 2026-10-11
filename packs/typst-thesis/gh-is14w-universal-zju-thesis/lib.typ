// ZJU Thesis Template for Typst
// 浙江大学学位论文模板

#import "core/template.typ": zju-thesis
#import "core/utils.typ": formula

// 导出主模板函数
#let zju-bachelor = zju-thesis
#let zju-master = zju-thesis  // 将来可以扩展
#let zju-doctor = zju-thesis  // 将来可以扩展

// 兼容性导出
#let doc = zju-thesis
