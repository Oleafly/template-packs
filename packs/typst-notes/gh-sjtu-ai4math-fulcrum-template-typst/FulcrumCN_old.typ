// FulcrumCN_old.typ
//
// 老中文 (original CN) implementation. 这些是项目历史原有的命令:
// 公理 / 规则 / 定义 / 实例 / 结构 / 结构性质 / 性质 / 定理 / 引理
// 例 / 反例 / 注 / 题目 / 解答 / 证明 / 构造 / 约定 / 令 / 目标
// 以及对应的 *块 命令 (公理块/规则块/定义块/...)
// 还有中文 proof 写作工具 unfold / apply / have / rfl / sorry / QED
//
// 这些命令的实现完全保留, 行为与重构前一致, 任何已有用法都不受影响。
//
// 共享的 helpers (Clause*, entry, optionLink, _meta) 和 state 在 Fulcrum.typ
// 中定义, 这里通过 import 取得。用户文档不需要直接 import 本文件,
// 直接 import Fulcrum.typ 即可同时拿到老中文/新中文/英文工具。


#import "FulcrumCore.typ": (
  // 通用 entry 工厂
  entry,
  // 通用工具
  optionLink,
  // 状态对象
  WarningMessage,
  counterList,
  remark_visible,
  showRemark,
  hideRemark,
  // CNL clause helpers
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
// 1. 简单写作工具
// ============================================================

#let 令 = (varName, type: [], value) => {
  [#optionLink("TypeLet", [令]) #varName]
  if (type != []) [ $:#type$]
  [ 为 #value]
}

#let 约定 = (uuid: "", body) => {
  let b
  if (type(body) == array) {
    b = list(..body)
  } else if (type(body) == content) {
    b = body
  }

  entry(
    env: "约定",
    counter_name: "variable",
    color_stroke: rgb("#00B8A0"),
    color_fill: rgb("#D0FFF1"),
    style: "remark",
  )(uuid: uuid, "", "", b)
}


// ============================================================
// 2. 中文老条目实现 (含 *块 命令)
// ============================================================

#let 公理 = entry(
  env: "公理",
  counter_name: "axiom",
  color_stroke: rgb("#C1C103"),
  color_fill: rgb("#FFFFAC"),
)
#let 公理块 = entry(
  env: "公理",
  counter_name: "axiom",
  color_stroke: rgb("#C1C103"),
  color_fill: rgb("#FFFFAC"),
)

// 规则
#let 规则 = entry(
  env: "规则",
  counter_name: "axiom",
  color_stroke: rgb("#C1C103"),
  color_fill: rgb("#FFFFAC"),
)
#let 规则块 = entry(
  env: "规则",
  counter_name: "axiom",
  color_stroke: rgb("#C1C103"),
  color_fill: rgb("#FFFFAC"),
)

// 定义
/**
 * 非标准化定义块函数
 * 位置参数：
 * `title_cn : string` 定义块的中文标题
 * `title_en : string` 定义块的英文标题
 *
 */
#let 定义块 = entry(
  env: "定义",
  counter_name: "definition",
  color_stroke: rgb("#009C27"),
  color_fill: rgb("#D6FEE0"),
)

/// 标准化定义条目函数。提供结构化的定义显示格式，支持假设、名称、内容、记号等
/// 
/// *必填参数*：
/// 1. `title_cn : content` 定义的中文标题
/// 2. `title_en : content` 定义的英文标题
/// 3. `target : content` 被定义项的陈述
/// 4. `value : content` 定义的主体内容
/// *可选参数*：
/// - `uuid : str` 定义的唯一标识符，用于链接引用
/// - `isExtension : bool` 是否为扩展定义，默认 false
/// - `isPredicate : bool` 是否为谓词定义，默认 false
/// - `hypotheses : content | list` 假设内容
/// - `notation : content` 定义的记号，默认空
/// - `hstyle : str` 假设显示样式，"inline" 或 "display"，默认 "inline"
/// - `tstyle : str` 被定义项陈述显示样式，"inline" 或 "display"，默认 "inline"
/// - `bstyle : str` 主体显示样式，"inline" 或 "display"，默认 "inline"
/// - `nstyle : str` 记号显示样式，"inline" 或 "display"，默认 "inline"
/// - `contributors : list` 贡献者列表，用于显示在条目右下角，默认空
#let 定义 = (
  title_cn,
  title_en,
  target,
  value,
  uuid: "",
  isExtension: false,
  isPredicate: false,
  hypotheses: (),
  notation: [],
  hstyle: "inline",
  tstyle: "inline",
  bstyle: "inline",
  nstyle: "inline",
  contributors: (),
  // 下面这个废除
  extention: none,
  // 下面这个废除
  isExtention: false,
) => {
  // Deprecation
  if (extention != none) {
    isExtension = extention
    WarningMessage.update([Warning (in command `定义`): argument `extention` is deprecated and will be removed in future versions. Please use `isExtension` instead.])
  }

  if (isExtention) {
    isExtension = true
    WarningMessage.update([Warning (in command `定义`): argument `isExtention` is deprecated and will be removed in future versions. Please use `isExtension` instead.])
  }

  定义块(uuid: uuid, title_cn, title_en, isExtension: isExtension, contributors: contributors, {
    // 假设
    ClauseHypotheses(hypotheses, hstyle)
    // 目标
    ClauseDefine(target, tstyle: tstyle)
    // 目标
    (if (isPredicate) { ClauseIff(bstyle: bstyle) } else { ClauseBe(bstyle: bstyle) }) + value
    // 记号
    ClauseNotation(notation, bstyle, nstyle)
  })
}

/// 标准化实例条目函数。用于展示具体实例的结构化组件
/// 
/// *必填参数*：
/// 1. `title_cn : content` 实例的中文标题
/// 2. `title_en : content` 实例的英文标题
/// 3. `target : content` 实例的目标
/// 4. `content : list` 实例的成员列表，每个元素为包含 name、name_en、varName、value 的字典
/// 5. `class : content` 实例所属的类别
/// *可选参数*：
/// - `uuid : str` 实例的唯一标识符，用于链接引用
/// - `hypotheses : content | list` 假设内容
/// - `hstyle : str` 假设显示样式，"inline" 或 "display"，默认 "inline"
/// - `isExtension : bool` 是否为扩展实例，默认 false
/// - `isPredicate : bool` 是否为谓词实例，默认 false
/// - `contributors : list` 贡献者列表，用于显示在条目右下角，默认空
#let 实例 = (
  uuid: "",
  title_cn,
  title_en,
  hypotheses: (),
  hstyle: "inline",
  target,
  class,
  members,
  isExtension: false,
  isPredicate: false,
  contributors: (),
  // 下面这个废除
  extention: none,
) => {
  if (extention != none) {
    isExtension = extention
    WarningMessage.update([Warning (in command `实例`): argument `extention` is deprecated and will be removed in future versions. Please use `isExtension` instead.])
  }

  定义块(uuid: uuid, title_cn, title_en, isExtension: isExtension, contributors: contributors, {
    // 假设
    ClauseHypotheses(hypotheses, hstyle)
    // 目标
    [定义【]
    target
    [】为携带以下信息的]
    class
    [：]
    ClauseMembers(members)
  })
}

// 结构
#let 结构块 = entry(
  env: "结构",
  counter_name: "definition",
  color_stroke: rgb("#009C27"),
  color_fill: rgb("#D6FEE0"),
)

/// 标准化结构条目函数。用于定义包含特定组件的结构
/// 
/// *必填参数*：
/// 1. `title_cn : content` 结构的中文标题
/// 2. `title_en : content` 结构的英文标题
/// 3. `target : content` 结构的目标
/// 4. `members : list` 结构的成员列表，每个元素为包含 name、name_en、varName、value 的字典
/// *可选参数*：
/// - `uuid : str` 结构的唯一标识符，用于链接引用
/// - `hypotheses : content | list` 假设内容
/// - `extends : list` 继承的结构列表
/// - `hstyle : str` 假设显示样式，"inline" 或 "display"，默认 "inline"
/// - `isExtension : bool` 是否为扩展结构，默认 false
/// - `isPredicate : bool` 是否为谓词结构，默认 false
/// - `notation : content` 结构的记号，默认空
/// - `nstyle : str` 记号显示样式，"inline" 或 "display"，默认 "inline"
/// - `contributors : list` 贡献者列表，用于显示在条目右下角，默认空
#let 结构 = (
  uuid: "",
  title_cn,
  title_en,
  hypotheses: (),
  extends: (),
  hstyle: "inline",
  target,
  members,
  isExtension: false,
  isPredicate: false,
  notation: [],
  nstyle: "inline",
  contributors: (),
  // 下面这个废除
  extention: none,
) => {
  if (extention != none) {
    isExtension = extention
    WarningMessage.update([Warning (in command `结构`): argument `extention` is deprecated and will be removed in future versions. Please use `isExtension` instead.])
  }

  结构块(uuid: uuid, title_cn, title_en, isExtension: isExtension, contributors: contributors, {
    // 假设
    ClauseHypotheses(hypotheses, hstyle)
    // 目标
    [定义【#target;】]
    if (isPredicate) [#ClauseIff(bstyle: "display")] else [#ClauseContains(bstyle: "display")]
    // 成员: extends 摊平为纯命题, prepend 到成员前
    let ext_members = extends.map(e => (value: e))
    ClauseMembers(ext_members + members)
    // 记号
    ClauseNotation(notation, "display", nstyle)
  })
}

// 性质
#let 性质块 = entry(
  env: "性质",
  counter_name: "property",
  color_stroke: rgb("#AC00AF"),
  color_fill: rgb("#FFEDFF"),
)

/// 标准化性质条目函数。用于展示某对象的性质或特征
/// 
/// *必填参数*：
/// 1. `title_cn : content` 性质的中文标题
/// 2. `title_en : content` 性质的英文标题
/// 3. `conclusion : content` 性质的结论
/// *可选参数*：
/// - `uuid : str` 性质的唯一标识符，用于链接引用
/// - `hypotheses : content | list` 假设内容
/// - `hstyle : str` 假设显示样式，"inline" 或 "display"，默认 "inline"
/// - `cstyle : str` 结论显示样式，"inline" 或 "display"，默认 "inline"
/// - `isExtension : bool` 是否为扩展性质，默认 false
/// - `contributors : list` 贡献者列表，用于显示在条目右下角，默认空
#let 性质 = (
  uuid: "",
  title_cn,
  title_en,
  hypotheses: (),
  hstyle: "inline",
  conclusion,
  cstyle: "inline",
  isExtension: false,
  contributors: (),
  // 下面这个废除
  extention: none,
  // 下面这个废除
  bstyle: "WARNING", 
) => {
  // Deprecation
  if (extention != none) {
    isExtension = extention
    WarningMessage.update([Warning (in command `性质`): argument `extention` is deprecated and will be removed in future versions. Please use `isExtension` instead.])
  }

  if (bstyle != "WARNING") {
    cstyle = bstyle
    WarningMessage.update([Warning (in command `性质`): argument `bstyle` is deprecated and will be removed in future versions. Please use `cstyle` instead.])
  }
  性质块(uuid: uuid, title_cn, title_en, isExtension: isExtension, contributors: contributors, {
    // 假设
    ClauseHypotheses(hypotheses, hstyle)
    // 结论
    ClauseConclusion(hypotheses != (), conclusion, cstyle)
  })
}

/// 标准化结构性质条目函数。展示结构性质及其包含的成员
/// 
/// *必填参数*：
/// 1. `title_cn : content` 结构性质的中文标题
/// 2. `title_en : content` 结构性质的英文标题
/// 3. `content : content` 性质的内容
/// *可选参数*：
/// - `uuid : str` 结构性质的唯一标识符，用于链接引用
/// - `hypotheses : content | list` 假设内容
/// - `hstyle : str` 假设显示样式，"inline" 或 "display"，默认 "inline"
/// - `members : list` 成员列表，每个元素为包含 name、name_en、varName、value 的字典
/// - `contributors : list` 贡献者列表，用于显示在条目右下角，默认空
#let 结构性质 = (
  uuid: "",
  title_cn,
  title_en,
  hypotheses: (),
  hstyle: "inline",
  content,
  members: (),
  contributors: (),
) => {
  性质块(uuid: uuid, title_cn, title_en, contributors: contributors, {
    // 假设
    ClauseHypotheses(hypotheses, hstyle)
    // 主体
    content
    if (members.len() > 0) [，其中：] else [。]
    // 成员
    ClauseMembers(members)
  })
}

// 定理
#let 定理块 = entry(
  env: "定理",
  counter_name: "theorem",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
)

/// 标准化定理条目函数。用于陈述和证明重要的数学定理
/// 
/// *必填参数*：
/// 1. `title_cn : content` 定理的中文标题
/// 2. `title_en : content` 定理的英文标题
/// 3. `conclusion : content` 定理的结论
/// *可选参数*：
/// - `uuid : str` 定理的唯一标识符，用于链接引用
/// - `hypotheses : content | list` 假设内容
/// - `hstyle : str` 假设显示样式，"inline" 或 "display"，默认 "inline"
/// - `cstyle : str` 结论显示样式，"inline" 或 "display"，默认 "inline"
/// - `isExtension : bool` 是否为扩展定理，默认 false
/// - `contributors : list` 贡献者列表，用于显示在条目右下角，默认空
#let 定理 = (
  uuid: "",
  title_cn,
  title_en,
  conclusion,
  hypotheses: (),
  hstyle: "inline",
  cstyle: "inline",
  isExtension: false,
  contributors: (),
  // 下面这个废除
  extention: none,
) => {
  if (extention != none) {
    isExtension = extention
    WarningMessage.update([Warning (in command `定理`): argument `extention` is deprecated and will be removed in future versions. Please use `isExtension` instead.])
  }

  定理块(uuid: uuid, title_cn, title_en, isExtension: isExtension, contributors: contributors, {
    // 假设
    ClauseHypotheses(hypotheses, hstyle)
    // 结论
    ClauseConclusion(hypotheses != (), conclusion, cstyle)
  })
}
#let 引理块 = entry(
  env: "引理",
  counter_name: "theorem",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
)

/// 标准化引理条目函数。用于陈述和证明辅助性的数学命题
/// 
/// *必填参数*：
/// 1. `title_cn : content` 引理的中文标题
/// 2. `title_en : content` 引理的英文标题
/// 3. `conclusion : content` 引理的结论
/// *可选参数*：
/// - `uuid : str` 引理的唯一标识符，用于链接引用
/// - `hypotheses : content | list` 假设内容
/// - `hstyle : str` 假设显示样式，"inline" 或 "display"，默认 "inline"
/// - `cstyle : str` 结论显示样式，"inline" 或 "display"，默认 "inline"
/// - `isExtension : bool` 是否为扩展引理，默认 false
/// - `contributors : list` 贡献者列表，用于显示在条目右下角，默认空
#let 引理 = (
  uuid: "",
  title_cn,
  title_en,
  conclusion,
  hypotheses: (),
  hstyle: "inline",
  cstyle: "inline",
  isExtension: false,
  contributors: (),
  // 下面这个废除
  extention: none,
) => {
  if (extention != none) {
    isExtension = extention
    WarningMessage.update([Warning (in command `引理`): argument `extention` is deprecated and will be removed in future versions. Please use `isExtension` instead.])
  }

  引理块(uuid: uuid, title_cn, title_en, isExtension: isExtension, contributors: contributors, {
    // 假设
    ClauseHypotheses(hypotheses, hstyle)
    // 结论
    ClauseConclusion(hypotheses != (), conclusion, cstyle)
  })
}

// 例
#let 例 = entry(
  env: "例",
  counter_name: "example",
  color_stroke: rgb("#7700E4"),
  color_fill: rgb("#EFDFFF"),
)

// 反例
#let 反例 = entry(
  env: "反例",
  counter_name: "counterexample",
  color_stroke: rgb("#D20022"),
  color_fill: rgb("#FFD6DC"),
)

/// 全局状态：控制注释块的可见性
#let remark_visible = state("remark_visible", true)

/// 显示注释块。将 remark_visible 状态设置为 true
#let showRemark = context {
  remark_visible.update(true)
  []
}
/// 隐藏注释块。将 remark_visible 状态设置为 false
#let hideRemark = context {
  remark_visible.update(false)
  []
}

/// 注条目函数。在 remark_visible 状态为 true 时显示注释
/// - `uuid : str` <可选> 注的唯一标识符，用于链接引用
/// - `title_cn : str` <可选> 注的中文标题
/// - `title_en : str` <可选> 注的英文标题
/// - `body : content` <#4 或可选> 注的内容
/// - `inline : bool` <可选> 是否使用行内模式，默认 true
/// - `isExtension : bool` <可选> 是否为扩展注，默认 false
#let 注 = (
  uuid: "",
  title_cn: "",
  title_en: "",
  body,
  inline: true,
  isExtension: false,
  // 下面这个废除
  extention: none,
) => {
  if (extention != none) {
    isExtension = extention
    WarningMessage.update([Warning (in command `注`): argument `extention` is deprecated and will be removed in future versions. Please use `isExtension` instead.])
  }

  context if (remark_visible.get() == true) {
    entry(
      env: "注",
      counter_name: "remark",
      color_stroke: rgb("#E07B00"),
      color_fill: rgb("#FFEBD2"),
      style: "remark",
    )(uuid: uuid, title_cn, title_en, body, style: "remark", isExtension: isExtension)
  }
}

// 作业用

#let 题目 = (uuid : "", count: none, body) => {
  entry(
    env: "题目",
    counter_name: "problem",
    color_stroke: rgb("#005B9C"),
    color_fill: rgb("#DAF0FF"),
    style: "problem",
  )(
    uuid: uuid,
    "", 
    "",
    count: count,
    body
  )
}


#let 解答 = (body) => entry(
  env: "解答",
  counter_name: "solution",
  color_stroke: rgb("#787878"),
  color_fill: rgb("#E9E9E9"),
  style: "remark"
)(
  "",
  "",
  body
)

// CNL 证明

#let 证明块 = entry(
  env: "证明",
  counter_name: "proof",
  color_stroke: rgb("#787878"),
  color_fill: rgb("#E9E9E9"),
  style: "proof"
)

#let 证明 = (
  uuid: "",
  body
) => {
  证明块(
    uuid: uuid,
    "",
    "",
  )[#body]
}

#let 构造块 = entry(
  env: "构造",
  counter_name: "construction",
  color_stroke: rgb("#787878"),
  color_fill: rgb("#E9E9E9"),
  style: "proof"
)

#let 构造 = (
  uuid: "",
  body
) => {
  构造块(
    uuid: uuid,
    "",
    "",
  )[#body]
}

// CNL


// ============================================================
// 3. 中文 proof 写作工具
// ============================================================

#let 目标 = (name: [], goal, c: false) => {
  [*【目标*]
  if (name != []) {
    [*（#name）*]
  }
  [】]
  if (c) {
    [需构造：]
  } else {
    [需证：]
  }
  goal
}

#let unfold = (defs) => {
  [展开定义：#defs。]
}
#let apply = (premise) => {
  [由#premise，]
}
#let have = (body) => [有：] + body
#let rfl = [依定义相等。]
#let sorry = text(fill: red)[`sorry`]
#let QED = place(bottom + right)[$square$]
