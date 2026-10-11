// FulcrumCore.typ
//
// Internal core: 语言无关的通用基础设施。
// 用户文档不要直接 import 本文件 - 始终走 Fulcrum.typ。
//
// 本文件提供给三个语言子文件 (FulcrumEN.typ / FulcrumCN_old.typ / FulcrumCN.typ)
// 共享的:
//   - 状态对象 (WarningMessage, counterList, allowQuery, remark_visible)
//   - 主题 (FulcrumCN show-rule, ApplyBold, rawLangColorMap)
//   - 通用 entry 工厂 (entry)
//   - 通用工具 (optionLink, showRemark, hideRemark)
//   - CNL clause helpers (Clause* 8 个)
//
// 本文件不 import 任何其他文件, 是依赖图的根。


// ============================================================
// 1. 状态对象 + 警告渲染
// ============================================================

#let WarningMessage = state("warning", [])
#let WarningRender = context {
  let message = WarningMessage.get()
  if (message != []) {
    block(
      fill: rgb("#FFF3CD"),
      inset: 4pt,
      radius: 4pt,
      stroke: rgb("#856404"),
      width: 100%,
      spacing: 1em,
    )[
      #text(fill: rgb("#856404"), message)
    ]
  }
}

#let counterList = state("counterList", ())

/// 子句中“散文连接词”的统一染色器: 深绿 #007030。
/// 用法: 在任何 Clause* helper 渲染散文文字 (设/则/为/记作/...) 时
///        把这段文字裹进 _meta(...), 让用户传入的实参 (主体/内容/记号/...)
///        保持原色, 只染散文部分。
#let _meta(body) = text(fill: rgb("#007030"), body)

/// 工具函数,适配中文宋体的加粗函数

// ============================================================
// 2. 主题: ApplyBold + rawLangColorMap + FulcrumCN show-rule
// ============================================================

#let ApplyBold = (body) => {
  set text(font: ("New Computer Modern", "SimHei", "Noto Sans CJK SC"), weight: "bold")
  body
}

#let rawLangColorMap = (
  JavaScript: rgb("#808000"),
  TypeScript: rgb("#008000"),
  Lean: blue,
)

/// 显示设置，通过 `#show : FulcrumCN` 启用。配置中文排版样式（字体、缩进、编号等）
/// - `body : content` <#1> 文档正文内容
#let FulcrumCN = (body) => {
  // 章节编号样式：“1.1.”
  set heading(numbering: "1.1.")
  // 在每个 level-2 heading (== 节) 置位主条目/例反例 counter 重置到 0
  // (使新节里 定义/定理 从 1 开始, 例/反例 从 1 开始)
  show heading.where(level: 2): it => {
    counter("new_main").update(0)
    counter("new_example").update(0)
    counter("new_property_sub").update(0)
    it
  }
  // level-1 heading (= 章) 同样重置
  show heading.where(level: 1): it => {
    counter("new_main").update(0)
    counter("new_example").update(0)
    counter("new_property_sub").update(0)
    it
  }
  // 字体样式:西文使用 New Computer Modern,中文使用宋体
  set text(font: ("New Computer Modern", "SimSun", "Noto Serif CJK SC"))
  // 首行缩进两个字符宽度
  set par(first-line-indent: (amount: 2em, all: true),)
  // 有序枚举缩进两个字符宽度
  set enum(indent: 2em)
  // 无序枚举缩进两个字符宽度
  set list(indent: 2em)
  // 图片编号规则为"图1"
  set figure(supplement: [图])
  //
  set math.mat(delim: "[")
  // 章节标题加粗
  show heading: ApplyBold
  // 普通加粗
  show strong: ApplyBold
  // 中文斜体:楷体
  show emph: set text(font: ("KaiTi", "Noto Serif CJK SC", "New Computer Modern Math"), style: "italic")
  // 超链接样式:深蓝色
  show link: set text(weight: "regular", fill: rgb("#000080"))
  // 代码块
  set raw(theme: "vscode-light-modern.tmTheme")
  show raw.where(block: true): (body) => {
    let langColor = rgb("#606060")
    if (body.lang in rawLangColorMap){
      langColor = rawLangColorMap.at(body.lang)
    }
    set text(font: ("Consolas", "SimHei", "Noto Sans CJK SC"))
    block(
      fill: rgb("#FFFFFF"),
      inset: 8pt,
      stroke: (left: 3pt + langColor, y: 1pt + langColor),
    )[
      #v(-0.6em)
      #align(left)[#text(weight: "bold", fill: langColor, body.lang)]
      #v(-0.9em)
      #line(length: 100%, stroke: 0.5pt + langColor)
      #v(-0.5em)
      #body
    ]
  }
  // 行内代码块
  show raw.where(block: false): (body) => {
    set text(font: ("Consolas", "SimHei", "Noto Sans CJK SC"))
    box(
      fill: rgb("#EEEEEE"),
      inset: 4pt,
      radius: 4pt,
      baseline: 4pt,
      body
    )
  }
  show title: (body) => [#align(center)[#ApplyBold(text(body))]]

  // 全局警告信息渲染
  set page(header: WarningRender)

  body
}

// ============================================================
// 3. 通用工具: allowQuery + optionLink
// ============================================================

#let allowQuery = state("allowQuery", true)
// #allowQuery.update(false)

/// 索引创建函数。如果存在标签则链接到标签,否则链接到 URL,若都无则显示纯文本
/// 1. `uuid : str | label` 索引指向的 uuid
/// 2. `body : content` 索引显示的内容
/// - `url : str` 索引指向的 URL,一般为维基百科
#let optionLink = (
  uuid,
  body,
  url: ""
) => {
  // 标签容器
  let l

  // 类型检查
  if (type(uuid) == str) {
    // `str` 则转换为 `label`
    l = label(uuid)
  } else if (type(uuid) == label) {
    // `label` 则不变
    l = uuid
  } else {
    // 报类型错
    assert(false, message: "Type Error: type of argument `uuid` must be either `str` or `label`.")
  }
  context {
    // 查找标签是否在文档中存在
    let elements = ()
    if (allowQuery.get()){
      elements = query(l)
    } else {
      elements = ()
    }
    // 视情况链接或显示纯文本
    if (elements.len() > 0) {
      // 标签存在,链接到标签
      link(l)[#body]
    } else if (url != "") {
      // 标签不存在但 URL 不为空,链接到 URL
      link(url)[#body]
    } else {
      // 显示纯文本
      body
    }
  }
}


// ============================================================
// 4. 通用 entry 工厂
// ============================================================

// 子条目 "上一个主条目" 号码 snapshot
// (子条目 如 性质/推论 读这个, 主条目 如 定义/定理 写这个)
#let mainEntryNumber = state("mainEntryNumber", 0)
#let exampleEntryNumber = state("exampleEntryNumber", 0)

#let entry(
  env: "条目",
  counter_name: "",
  color_stroke: rgb("#000000"),
  color_fill: rgb("#DDDDDD"),
  parentEntry: "",
  style: "full",
  // 标点设定 (默认 ASCII; CN 侧调用传中文)
  colon: ":",
  paren_open: "(",
  paren_close: ")",
  // 计数模式:
  //   "legacy"  - 原生逻辑 (老命令 向后兼容). 显示 heading.display() + envCounter.
  //   "main"    - 主条目. step counter, snapshot 到 main_state, 显示 章.节.K
  //   "sub"     - 子条目. 不 step main, step 自己 sub counter, 读 main_state, 显示 章.节.K.j
  //   "single"  - 独立一级编号. step counter, 不带章节, 显示 K. 允许 number: 覆盖.
  //   "none"    - 不编号。
  count_mode: "legacy",
  // 仅 mode == "main" 时使用: 该主 counter 的 number snapshot state.
  main_state: none,
  // 仅 mode == "sub" 时使用: 读哪个 main_state 取 K.
  sub_parent_state: none,
  // 仅 mode == "sub" 时使用: sub counter 名称.
  sub_counter_name: "",
) = {
  // 若不指定计数器名称,以环境为名创建计数器
  if (counter_name == "") {
    counter_name = env
  }
  let envCounter = counter(counter_name)
  let subCounter = if (sub_counter_name != "") { counter(sub_counter_name) } else { none }

  // 返回条目函数
  (
    uuid: "",
    title_cn,
    title_en,
    body,
    style: style,
    isExtension: false,
    extention: none,
    contributors: (),
    count: none,
    number: none,    // 面向 single 模式 的手动覆盖 (例如 题目 重编号)
  ) => {
    if (extention != none) {
      isExtension = extention
      WarningMessage.update([Warning (in command `entry`): argument `extention` is deprecated and will be removed in future versions. Please use `isExtension` instead.])
    }

    // 覆盖全局格式,清空首行缩进
    set par(first-line-indent: 0em)
    counterList.update(prev => {
      if ((prev == none) or (not counter_name in prev)) {
        prev + (counter_name,)
      }
    })

    if(count != none and type(count) == int) {
      envCounter.update(count - 1)
    }

    // 新 number 参数 (single 模式 中 手动重编号)
    if (number != none and count_mode == "single") {
      envCounter.update(number - 1)
    }

    // 以 count_mode 驱动 step 逻辑
    if (not isExtension) {
      if (count_mode == "legacy" or count_mode == "main" or count_mode == "single") {
        envCounter.step()
      } else if (count_mode == "sub") {
        // 不 step main; step sub
        if (subCounter != none) { subCounter.step() }
      } else if (count_mode == "none") {
        // 不 step 任何 counter
      }
    } else {
      v(-1em)
    }

    // main 条目 step 后 重置子计数器 为 0 (使下一个 sub 条目 从 j=1 起编)
    if (count_mode == "main" and not isExtension) {
      // 默认 sub counter 名为 "new_property_sub" (性质/推论 使用)
      counter("new_property_sub").update(0)
    }

    // 主条目 snapshot K 到 main_state, 同时 reset 子计数器 (重新从 0 起)
    if (count_mode == "main" and main_state != none and not isExtension) {
      context {
        main_state.update(envCounter.get().at(0))
      }
    }

    count = context envCounter.get().at(0)

    // 条目块
    block(
      fill: color_fill,
      inset: (x: 12pt, y: 8pt),
      stroke: if (style != "proof") {(left: 3pt + color_stroke)} else {(left: 3pt + color_stroke, y: 1pt + color_stroke)},
      width: 100%,
      spacing: 1em,
      {
        if (style in ("remark", "proof", "problem")) {
          // 单行块
          strong({
            [#env#if (uuid != "") { label(uuid) }]
            if (count_mode == "none") {
              // 不显示号
            } else if (count_mode == "single") {
              context [ #envCounter.display()]
            } else if (count != none) [#count]
            [#colon]
          })
          body
        } else {
          // 正常块
          strong({
            if (not isExtension) {
              env
              context {
                if (count_mode == "main") {
                  // 章.节.K
                  let levels = counter(heading).display()
                  let k = envCounter.get().at(0)
                  if (levels != "0.") { [ #levels#k] } else { [ #k] }
                } else if (count_mode == "sub") {
                  // 章.节.K.j  K 从 main_state 读, j 从 sub counter 读
                  let levels = counter(heading).display()
                  let k = if (sub_parent_state != none) { sub_parent_state.get() } else { 0 }
                  let j = if (subCounter != none) { subCounter.get().at(0) } else { 0 }
                  if (levels != "0.") { [ #levels#k.#j] } else { [ #k.#j] }
                } else if (count_mode == "single") {
                  // 一级数字
                  [ #envCounter.display()]
                } else if (count_mode == "none") {
                  // 无号
                } else {
                  // legacy: 原生逻辑
                  if (count == none) {
                    let num = if (parentEntry != "") {
                      [#counter(parentEntry).get().at(0)]
                    } + envCounter.get().at(0)
                    let levels = counter(heading).display()
                    if (levels != "0.") { [#levels#num] } else { [#num] }
                  } else {count}
                }
              }
              [#colon]
            } else [#v(-5pt)#line(length: 100%, stroke: 0.5pt + color_stroke)#v(-5pt)#env#colon]
            [#title_cn#if (uuid != "") { label(uuid) }]
            if title_en != "" { paren_open + title_en + paren_close }
          })
          v(-5pt)
          line(length: 100%, stroke: 0.5pt + color_stroke)
          v(-5pt)
          body
        }

        place(
          bottom + right,
        )[
          #show link : set text(fill: white)
          #text(fill: white, contributors.join(","))
        ]
      },
    )
  }
}

// 定义命令

/// 约定条目。用绿色主题创建约定块
/// - `uuid : str` <可选> 条目的唯一标识符,用于链接引用

// ============================================================
// 5. CNL clause helpers (中英新老共用)
// ============================================================

#let ClauseHypotheses = (
  hypotheses,
  hstyle,
) => {
  if (type(hypotheses) == str or type(hypotheses) == content) {
    hypotheses = (hypotheses,)
  }
  if (hypotheses.len() > 0) {
    if (hstyle == "display") {
      _meta([设：]) + enum(..hypotheses.map(h => [#h#_meta([；])]))
    } else {
      if (hypotheses.len() > 0) {
        _meta([设])
        hypotheses.join(_meta([，]))
      }
    }
    _meta([，])
  }
}

/// Clause: 结论子句
#let ClauseConclusion = (
  hasHyp,
  conclusion,
  cstyle,
) => {
  if (hasHyp) {
    _meta([则])
    if (cstyle != "display") {
      _meta([：])
    }
  }
  if (cstyle == "display") {
    conclusion
  } else {
    conclusion
    _meta([。])
  }
}

/// Clause: 成员子句
///
/// 每条成员支持三种形态:
///   1. 命名成员 (name + varName + value/type):
///        **名字（en）**（var : type） := value
///        **名字（en）**（var : value）
///   2. 命名命题 (name + value, 无 varName):
///        **名字（en）**：value
///   3. 纯命题 (仅 value, 无 name): 直接渲染 value, 用于 extends 摊平
///        value
///
/// 末尾标点:
///   - style == "display": 不加 (成员自带换行)
///   - 最后一项: 。
///   - 其余: ；
#let ClauseMembers = (members) => {
  let n = members.len()
  enum(..members.enumerate().map(pair => {
    let (i, member) = pair
    let hasName = "name" in member
    let hasVar = "varName" in member
    let isLast = (i == n - 1)
    // 成员名 (可选)
    if hasName {
      strong({
        member.name
        if ("name_en" in member) [（#member.name_en）]
      })
    }
    // 变量名与值
    if hasVar {
      if ("type" in member) {
        [（]
        $#member.varName : #member.type$
        [）]
        $:=$
        member.value
      } else {
        [（]
        $#member.varName : #member.value$
        [）]
      }
    } else if "value" in member {
      if hasName { _meta([：]) }
      member.value
    }
    // 末尾标点
    if (not ("style" in member and member.style == "display")) {
      if isLast { _meta([。]) } else { _meta([；]) }
    }
  }))
}

/// Clause: 记号子句
#let ClauseNotation = (
  notation,
  bstyle,
  nstyle,
) => {
  if (notation != []) {
    if (bstyle == "display") {
      _meta([记作：])
      notation
    } else {
      _meta([，记作：])
      notation
    }
  }
  if ((notation != [] and nstyle != "display") or (notation == [] and bstyle != "display")) {
    _meta([。])
  }
}

/// Clause: 定义目标子句
#let ClauseDefine = (
  target,
  tstyle: "inline",
) => {
  if (tstyle == "display") {
    _meta([定义：])
    target
  } else {
    _meta([定义【])
    target
    _meta([】])
  }
}

/// Clause: "为" 子句(仅连接词)
///
/// inline 模式末尾追加一个普通空格 (而非 ~), 让中文 + 数学/英文之间有正常间距。
/// 文本 + 文本之间作者会自己处理 (用全角句末标点 / 中文紧贴), 这里只保护 后面接 $...$ / Latin 字母 的边界。
#let ClauseBe = (bstyle: "inline") => {
  if (bstyle == "display") { _meta([为：]) } else { _meta([为]) + " " }
}

/// Clause: "当且仅当" 子句(仅连接词)
///
/// 同 ClauseBe: inline 模式追加一个空格, 让 "当且仅当" 和后面的 $...$ / 拉丁字母 之间有间距。
/// (display 模式以 ：换行, 已自然分隔, 不加空格。)
#let ClauseIff = (bstyle: "inline") => {
  if (bstyle == "display") { _meta([当且仅当：]) } else { _meta([当且仅当]) + " " }
}

/// Clause: "包含以下成员" 子句(仅连接词)
#let ClauseContains = (bstyle: "display") => {
  if (bstyle == "display") { _meta([包含以下成员：]) } else { _meta([包含以下成员]) }
}


// ============================================================
// 6. remark_visible 状态 + show/hide 工具
// ============================================================

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
