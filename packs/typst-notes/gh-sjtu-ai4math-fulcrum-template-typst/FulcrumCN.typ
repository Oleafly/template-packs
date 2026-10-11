// FulcrumCN.typ
//
// 新中文 (new CN) CNL 模板: 条目 + 子句 二级分离架构。
//
// 设计原则:
// 1. 条目命令(*条目)只管框: 颜色、标题、uuid、贡献者、计数器
// 2. 子句命令(*子句)只管文字: CNL 语义自洽的完整子句
// 3. 一个条目内可放多个子句, 各子句各自处理可选参数为空的情况
// 4. 与旧 Fulcrum.typ 共存, 不冲突, 旧代码继续可用
//
// ============================================================
// 条目 (*条目)
//   定义条目 / 公理条目 / 引理条目 / 定理条目 / 推论条目 / 性质条目
//   注条目 / 例条目 / 反例条目 / 构造条目 / 证明条目 / 题目条目
//
// 设计要点: Entry 层不区分 “定义还是结构", 一律用 #定义条目, 交给
//          内部 *子句 区分 (调 #定义子句 / #递归定义子句 / #结构子句 / #结构实例子句)
//
// 子句 (*子句)
//   定义类(用于 #定义条目 / #公理条目 内):
//     #定义子句       —— 普通定义
//     #递归定义子句   —— 归纳/递归定义
//     #结构子句       —— 结构体定义(类型, 含成员列表, 支持 extends/继承)
//     #结构实例子句   —— 结构体的具体实例(含 value)
//
//   定理类(用于 #引理条目/#定理条目/#推论条目/#公理条目/#性质条目 内):
//     #定理子句       —— 普通定理 / 性质 / 推论(陈述+条件)
//
//   推论本身不需要专属子句, 用 #定理子句 即可。
//
// 调用约定: 所有"必填"参数都是 named (有默认值 none, 函数体内 assert),
//          这样调用必须写 `主体: ..., 内容: ...` 等, 顺序自由可读。
// ============================================================


#import "FulcrumCore.typ": (
  entry,
  mainEntryNumber,
  exampleEntryNumber,
  _meta,
  ClauseHypotheses,
  ClauseConclusion,
  ClauseMembers,
  ClauseNotation,
  ClauseDefine,
  ClauseBe,
  ClauseIff,
  ClauseContains,
)


// ============================================================
// 1. 条目命令(*条目)- 只管框
//
// 计数规则:
//   - 公理         → single (独立一级, 不带章节)
//   - 定义 / 定理 / 引理  → main, counter "entry", 显示 章.节.K
//   - 推论 / 性质      → sub, 读 mainEntryNumber, 不 step "entry"; sub counter "property_sub"; 显示 章.节.K.j
//   - 例 / 反例      → main (各自), counter "example", 显示 章.节.M
//   - 题目         → single, counter "problem", 显示 K (允许 number: 覆盖)
//   - 注 / 构造 / 证明 / 解答  → none (不编号)
// ============================================================

/// 定义条目: 绿色框, 主条目 章.节.K (共享 counter "new_main")
/// 含义: 定义 / 结构 / 实例 统一靠 #定义条目, 区分下放到 *子句
#let 定义条目 = entry(
  env: "定义",
  counter_name: "new_main",
  color_stroke: rgb("#009C27"),
  color_fill: rgb("#D6FEE0"),
  count_mode: "main",
  main_state: mainEntryNumber,
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 公理条目: 黄色框, 独立一级编号
#let 公理条目 = entry(
  env: "公理",
  counter_name: "axiom",
  color_stroke: rgb("#C1C103"),
  color_fill: rgb("#FFFFAC"),
  count_mode: "single",
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 引理条目: 蓝色框, 主条目 章.节.K (共享 counter "new_main" 与 定义/定理)
#let 引理条目 = entry(
  env: "引理",
  counter_name: "new_main",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
  count_mode: "main",
  main_state: mainEntryNumber,
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 定理条目: 蓝色框, 主条目 章.节.K (共享 counter "new_main")
#let 定理条目 = entry(
  env: "定理",
  counter_name: "new_main",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
  count_mode: "main",
  main_state: mainEntryNumber,
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 推论条目: 蓝色框 (同定理/引理), 子条目 章.节.K.j (不推升主 K)
#let 推论条目 = entry(
  env: "推论",
  counter_name: "new_main",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
  count_mode: "sub",
  sub_parent_state: mainEntryNumber,
  sub_counter_name: "new_property_sub",
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 性质条目: 品红框, 子条目 章.节.K.j (不推升主 K)
#let 性质条目 = entry(
  env: "性质",
  counter_name: "new_main",
  color_stroke: rgb("#AC00AF"),
  color_fill: rgb("#FFEDFF"),
  count_mode: "sub",
  sub_parent_state: mainEntryNumber,
  sub_counter_name: "new_property_sub",
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 注条目: 橙色 remark 风格, 不编号
#let 注条目 = entry(
  env: "注",
  counter_name: "remark",
  color_stroke: rgb("#E07B00"),
  color_fill: rgb("#FFEBD2"),
  style: "remark",
  count_mode: "none",
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 例条目: 紫色框, 主条目 章.节.M (共享 counter "new_example" 与 反例)
#let 例条目 = entry(
  env: "例",
  counter_name: "new_example",
  color_stroke: rgb("#7700E4"),
  color_fill: rgb("#EFDFFF"),
  count_mode: "main",
  main_state: exampleEntryNumber,
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 反例条目: 红色框, 主条目 章.节.M (共享 counter "new_example")
#let 反例条目 = entry(
  env: "反例",
  counter_name: "new_example",
  color_stroke: rgb("#D20022"),
  color_fill: rgb("#FFD6DC"),
  count_mode: "main",
  main_state: exampleEntryNumber,
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 构造条目: 灰色 proof 风格, 不编号
#let 构造条目 = entry(
  env: "构造",
  counter_name: "construction",
  color_stroke: rgb("#787878"),
  color_fill: rgb("#F0F0F0"),
  style: "proof",
  count_mode: "none",
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 证明条目: 灰色 proof 风格, 不编号
#let 证明条目 = entry(
  env: "证明",
  counter_name: "proof",
  color_stroke: rgb("#787878"),
  color_fill: rgb("#F0F0F0"),
  style: "proof",
  count_mode: "none",
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)

/// 题目条目: 蓝色 problem 风格, 独立一级编号, 允许 number: 覆盖
#let 题目条目 = entry(
  env: "题目",
  counter_name: "problem",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
  style: "problem",
  count_mode: "single",
  colon: "：",
  paren_open: "（",
  paren_close: "）",
)


// ============================================================
// 2. 子句命令(*子句)- 只管文字
// ============================================================

// 内部 helper: 渲染 type 注解
// type != none 且 主体不是谓词 → "[主体 : type]"
// 否则 → "[主体]"
#let _format-target = (target, t) => {
  if (t != none) {
    [#target #h(0.2em)$:$#h(0.2em)#t]
  } else {
    target
  }
}

// 内部 helper: 处理 hypotheses 单个内容 / 数组的两种输入
#let _normalize-hypotheses = (hypotheses) => {
  if (type(hypotheses) == str or type(hypotheses) == content) {
    (hypotheses,)
  } else {
    hypotheses
  }
}


// ----------------------------------------
// 2.1 #定义子句 - 普通定义
//
//   设 [条件], 定义【[主体] : [type]】 为 [内容], 记作 [记号]
//   设 [条件], 定义【[主体] : [type]】 当且仅当 [内容], 记作 [记号]   (isPredicate=true)
//
// 必填: 主体, 内容   (named, 调用必须写 主体: ..., 内容: ...)
// 可选: 条件, type, 记号, isPredicate, *style
// ----------------------------------------
#let 定义子句 = (
  主体: none,
  内容: none,
  条件: (),
  type: none,
  记号: [],
  isPredicate: false,
  hstyle: "inline",
  tstyle: "inline",
  bstyle: "inline",
  nstyle: "inline",
) => {
  let _t = std.type
  assert(主体 != none, message: "定义子句: 参数 `主体` 必填")
  assert(内容 != none, message: "定义子句: 参数 `内容` 必填")
  let hyps = _normalize-hypotheses(条件)
  // 假设
  ClauseHypotheses(hyps, hstyle)
  // 目标 (含可选 type 注解)
  ClauseDefine(_format-target(主体, type), tstyle: tstyle)
  // 连接词 + 内容
  (if (isPredicate) { ClauseIff(bstyle: bstyle) } else { ClauseBe(bstyle: bstyle) }) + 内容
  // 记号
  ClauseNotation(记号, bstyle, nstyle)
}


// ----------------------------------------
// 2.2 #递归定义子句 - 归纳/递归定义
//
// 一般情形 (isPredicate=false):
//   设 [条件], 定义【[主体] : [type]】类型的成员为以下之一:
//     1. [构造子1] : [类型1]
//     2. ...
//
// 谓词情形 (isPredicate=true):
//   设 [条件], 定义【[主体]】(可省 type) 若以下之一成立:
//     1. [构造子1] : [类型1]
//     2. ...
//
// 必填: 主体, 构造子   (named)
// 可选: 条件, type, isPredicate, *style
//
// 构造子: array, 每条 (name: ..., type: ...) 字典 (其中 type 可省)
//                若该条仅一个 content, 当 name 处理无 type 后续。
// ----------------------------------------
#let 递归定义子句 = (
  主体: none,
  构造子: none,
  条件: (),
  type: none,
  isPredicate: false,
  hstyle: "inline",
  tstyle: "inline",
) => {
  let _t = std.type
  assert(主体 != none, message: "递归定义子句: 参数 `主体` 必填")
  assert(构造子 != none, message: "递归定义子句: 参数 `构造子` 必填")
  let hyps = _normalize-hypotheses(条件)
  // 假设
  ClauseHypotheses(hyps, hstyle)
  // 目标
  ClauseDefine(_format-target(主体, type), tstyle: tstyle)
  // 连接词
  if (isPredicate) {
    _meta([类型若以下之一成立：])
  } else {
    _meta([类型的成员为以下之一：])
  }
  // 构造子列表
  enum(
    ..构造子.map(c => {
      // 兼容: dict 或 content
      if (_t(c) == dictionary) {
        if ("type" in c and c.type != none) {
          [#strong(c.name) #h(0.2em)$:$#h(0.2em) #c.type]
        } else {
          strong(c.name)
        }
      } else {
        c
      }
    })
  )
}


// ----------------------------------------
// 2.3 #结构子句 - 结构体类型定义
//
//   设 [条件], 定义【[主体]】[包含以下成员 / 当且仅当]：
//     1. [extends 父类 (摊平到第 1..k 条)]
//     2. ...
//     k+1. [本身的成员]
//     ...
//   记作 [记号]。
//
// 必填: 主体, 成员   (named)
// 可选: 条件, 继承 / extends, 记号, isPredicate, *style
//
// extends 反 继承 二选一 (中英文别名, 都接受 单个 content/str 或 array):
//   #结构子句(extends: [#半群], ...)              // 单个父类
//   #结构子句(extends: ([#半群], [#集合]), ...)   // 多个父类
//   #结构子句(继承: [#半群], ...)                 // 中文别名
//
// 渲染时, extends 的每一项会作为一条 "纯命题成员" prepend 到 成员 列表最前,
// 然后用 ClauseMembers 统一渲染为 numbered list, 不再走 "在 ... 基础上" 的额外语句。
//
// 成员: array, 每条字典:
//   (name?, name_en?, varName?, type?, value, style?)
//
//   - 含 name + value: **名字**：value
//   - 含 name + varName + type + value: **名字** (var : type) := value
//   - 含 name + varName + value: **名字** (var : value)
//   - 仅 value (无 name): 纯命题, 直接渲染 value (extends 摊平用)
//
// isPredicate 控制连接词:
//   - true  → "当且仅当"  (主体是命题, 例如 "X 是群")
//   - false → "包含以下成员" (主体是 结构数据 / 类型, 例如 "群")
// ----------------------------------------
#let 结构子句 = (
  主体: none,
  成员: none,
  条件: (),
  继承: (),
  extends: none,    // 别名, 与 继承 二选一 (谁非 none 用谁)
  记号: [],
  isPredicate: false,
  hstyle: "inline",
  nstyle: "inline",
) => {
  let _t = std.type
  assert(主体 != none, message: "结构子句: 参数 `主体` 必填")
  assert(成员 != none, message: "结构子句: 参数 `成员` 必填")
  let hyps = _normalize-hypotheses(条件)
  // 优先 extends, fallback 到 继承 (允许中英文双参数)
  let ext_raw = if (extends != none) { extends } else { 继承 }
  let exts = if (ext_raw == none or ext_raw == ()) { () } else if (_t(ext_raw) == str or _t(ext_raw) == content) { (ext_raw,) } else { ext_raw }
  // 将 extends 摊平为纯命题成员, prepend 到成员列表
  let ext_members = exts.map(e => (value: e))
  let all_members = ext_members + 成员
  assert(all_members.len() > 0, message: "结构子句: `成员` 与 `extends` 不能同时为空")
  // 假设
  ClauseHypotheses(hyps, hstyle)
  // 目标
  _meta([定义【])
  主体
  _meta([】])
  // 连接词
  if (isPredicate) {
    ClauseIff(bstyle: "display")
  } else {
    ClauseContains(bstyle: "display")
  }
  // 成员 (extends 已摊平到前)
  ClauseMembers(all_members)
  // 记号
  ClauseNotation(记号, "display", nstyle)
}


// ----------------------------------------
// 2.4 #结构实例子句 - 结构体的具体实例
//
//   设 [条件], 定义【[主体]】是携带以下信息的 [类别]:
//     1. [成员名] (varName : type) := value
//     2. ...
//   记作 [记号]。
//
// 必填: 主体, 类别, 成员    (named)
// 可选: 条件, 记号, *style
// ----------------------------------------
#let 结构实例子句 = (
  主体: none,
  类别: none,
  成员: none,
  条件: (),
  记号: [],
  hstyle: "inline",
  nstyle: "inline",
) => {
  assert(主体 != none, message: "结构实例子句: 参数 `主体` 必填")
  assert(类别 != none, message: "结构实例子句: 参数 `类别` 必填")
  assert(成员 != none, message: "结构实例子句: 参数 `成员` 必填")
  let hyps = _normalize-hypotheses(条件)
  ClauseHypotheses(hyps, hstyle)
  _meta([定义【])
  主体
  _meta([】为携带以下信息的])
  类别
  _meta([：])
  ClauseMembers(成员)
  ClauseNotation(记号, "display", nstyle)
}


// ----------------------------------------
// (#同义子句 已废弃 2026-06-18: 合并到 #结构子句)
// 之前 "X = Y 与 Z 的同义定义" 走 #同义子句, 现统一写法:
//   #结构子句(主体: [#交换幺环], extends: ([#交换环], [#幺环]), 成员: ())
// extends 会摊平为 numbered list 的前两条:
//   定义【交换幺环】包含以下成员：
//     1. 交换环；
//     2. 幺环。
// ----------------------------------------


// ----------------------------------------
// 2.6 #定理子句 - 唯一定理类子句
//
//   设 [条件], 则 [结论]
//   [结论]   (无条件时)
//
// 必填: 结论    (named)
// 可选: 条件, *style
//
// 用于: #定理条目 / #引理条目 / #推论条目 / #公理条目 / #性质条目 内
// ----------------------------------------
#let 定理子句 = (
  结论: none,
  条件: (),
  hstyle: "inline",
  cstyle: "inline",
) => {
  assert(结论 != none, message: "定理子句: 参数 `结论` 必填")
  let hyps = _normalize-hypotheses(条件)
  let hasHyp = hyps.len() > 0
  // 假设
  ClauseHypotheses(hyps, hstyle)
  // 结论
  ClauseConclusion(hasHyp, 结论, cstyle)
}
