// Fulcrum.typ
//
// 用户入口: re-export hub。
// 用户文档继续写:
//   #import "../../Fulcrum-Template-Typst/Fulcrum.typ": *
// 即可一次性拿到 Core + EN + CN_old + CN 的全部命名。
//
// 物理结构:
//   FulcrumCore.typ      内部, 通用基础 (entry / Clause* / optionLink / 状态 / 主题)
//      ↑ import
//   FulcrumEN.typ        英文实现 (declare/theorem/proposition/instance_block/...)
//   FulcrumCN_old.typ    老中文实现 (定义/定理/性质/结构/...)
//   FulcrumCN.typ        新中文 (条目+子句二级架构)
//      ↑ import (这三个 + Core)
//   Fulcrum.typ          本文件, 只 re-export, 无实现

#import "FulcrumCore.typ": *
#import "FulcrumEN.typ": *
#import "FulcrumCN_old.typ": *
#import "FulcrumCN.typ": *
