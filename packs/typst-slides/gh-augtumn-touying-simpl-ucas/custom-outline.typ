// ============================================================================
// Custom Outline Module - 自定义大纲模块
// ============================================================================
// 提供基于上下文的灵活大纲制作功能
// 支持过滤和样式自定义
// Version: 1.1.0
// ============================================================================

// ============================================================================
// 常量定义 / Constants
// ============================================================================

#let DEFAULT-OUTLINE-DEPTH = 3
#let MAX-OUTLINE-DEPTH = 6

// ============================================================================
// 工具函数 / Utility Functions
// ============================================================================

/// 验证标题级别
#let validate-level(level) = {
  if level != auto {
    assert(
      type(level) == int and level > 0 and level <= MAX-OUTLINE-DEPTH,
      message: "level must be auto or an integer between 1 and " + str(MAX-OUTLINE-DEPTH) + ", got: " + str(level)
    )
  }
}

/// 安全地获取数组元素
#let safe-at(arr, index, default: none) = {
  if arr.len() > 0 and index >= -arr.len() and index < arr.len() {
    arr.at(index)
  } else {
    default
  }
}

/// 检查两个路径是否有共同前缀
#let has-common-prefix(path1, path2, length) = {
  if path1.len() < length or path2.len() < length {
    return false
  }
  path1.slice(0, length) == path2.slice(0, length)
}

/// 获取当前标题 / Get current heading at the current location
///
/// 在文档的当前位置查找最近的标题元素，可用于确定上下文。
///
/// **参数 / Parameters:**
/// - `level`: 标题级别（auto 表示任意级别，1-6 表示特定级别）
/// - `outlined`: 是否只考虑大纲中的标题（默认 true）
///
/// **返回 / Returns:**
/// - 当前位置之前的最近标题，如果不存在则返回 none
///
/// **示例 / Examples:**
/// ```typst
/// // 获取当前任意级别的标题
/// #let current = current-heading()
///
/// // 获取当前一级标题
/// #let h1 = current-heading(level: 1)
///
/// // 包括非大纲标题
/// #let all = current-heading(outlined: false)
/// ```
#let current-heading(level: auto, outlined: true) = {
  // 参数验证
  validate-level(level)
  assert(type(outlined) == bool, message: "outlined must be boolean")
  
  let here = here()
  let results = query(heading.where(outlined: outlined).before(inclusive: false, here))
  
  safe-at(results, -1, default: none)
}

/// 构建标题上下文信息 / Build headings context information
///
/// 分析文档中的所有标题，生成包含层级路径和关系的结构化数据。
/// 路径表示为数组，例如 [1, 2, 3] 表示第1个一级标题下的第2个二级标题下的第3个三级标题。
///
/// **参数 / Parameters:**
/// - `target`: 目标标题选择器（默认为 `heading.where(outlined: true)`）
///
/// **返回 / Returns:**
/// 包含以下字段的字典：
/// - `current-heading`: 当前位置的标题元素（如果存在）
/// - `current-heading-idx`: 当前标题在结果数组中的索引（如果存在）
/// - `headings`: 包含所有标题的数组，每个元素包含：
///   - `path`: 标题的层级路径数组
///   - `heading`: 标题元素
///
/// **示例 / Examples:**
/// ```typst
/// #let ctx = headings-context()
/// #let current = ctx.current-heading
/// #let all-headings = ctx.headings
/// ```
#let headings-context(target: heading.where(outlined: true)) = {
  let current-hd = current-heading()
  let current-loc = if current-hd != none { current-hd.location() }
  
  let headings = query(target)
  
  // 验证标题数量
  if headings.len() == 0 {
    return (
      current-heading: none,
      current-heading-idx: none,
      headings: ()
    )
  }
  
  let path = ()
  let prev-level = 0
  let current-heading-idx = none
  let result = ()

  for (idx, hd) in headings.enumerate() {
    let level-diff = hd.level - prev-level
    
    // 更新路径：增加层级
    if level-diff > 0 {
      for _ in range(level-diff) {
        path.push(1)
      }
    } 
    // 更新路径：减少层级并递增同级计数
    else {
      for _ in range(-level-diff) {
        let _ = path.pop()
      }
      if path.len() > 0 {
        path.at(-1) = path.at(-1) + 1
      }
    }

    result.push((
      path: path,  // 复制路径（Typst 中数组是引用类型）
      heading: hd
    ))

    // 通过位置匹配找到当前标题（避免内容相同的标题误匹配）
    if current-loc != none and hd.location() == current-loc {
      current-heading-idx = result.len() - 1
    }
    
    prev-level = hd.level
  }

  (
    current-heading: current-hd,
    current-heading-idx: current-heading-idx,
    headings: result
  )
}

/// 创建自定义大纲 / Create a custom outline with filtering and styling
///
/// 提供强大的上下文感知大纲生成功能，可以根据当前位置动态过滤和样式化大纲条目。
/// 这是构建动态目录、章节导航和内容概览的核心工具。
///
/// **核心功能**
/// 1. **上下文感知**: 自动识别当前所在章节
/// 2. **关系判断**: 判断每个标题与当前位置的关系（同级、父子、兄弟等）
/// 3. **灵活过滤**: 自定义哪些标题应该显示
/// 4. **样式定制**: 为不同关系的标题应用不同样式
///
/// **参数 / Parameters:**
///
/// `filter` - 过滤函数 `(hd) => boolean`
///   决定哪些标题应该出现在大纲中。
///   
///   参数 `hd` 是包含以下字段的字典：
///   - `here-path`: array - 当前位置标题的层级路径（如 [1, 2, 3]）
///   - `here-level`: int - 当前位置标题的深度（`here-path.len()`）
///   - `level`: int - 被判断标题的深度
///   - `path`: array - 被判断标题的层级路径
///   - `relation`: dict/none - 与当前标题的关系（如果有当前标题）：
///     - `same`: bool - 是否是当前标题本身
///     - `parent`: bool - 是否是当前标题的祖先
///     - `child`: bool - 是否是当前标题的后代
///     - `sibling`: bool - 是否是当前标题的同级兄弟
///     - `unrelated`: bool - 是否与当前标题无关
///   - `loc`: location - 标题的位置对象
///   - `heading`: element - 标题元素本身
///
/// `transform` - 转换函数 `(hd, it) => content`
///   自定义大纲条目的显示样式。
///   
///   参数：
///   - `hd`: 与 filter 中相同的标题字典
///   - `it`: 当前的 `outline.entry` 元素
///   
///   返回：转换后的内容
///
/// `target` - 目标标题选择器
///   默认为 `heading.where(outlined: true)`，可自定义筛选哪些标题。
///
/// `..args` - 额外参数
///   传递给内置 `outline()` 函数的其他参数（如 `title`, `depth` 等）。
///
/// **示例 / Examples:**
///
/// ```typst
/// // 示例1：只显示与当前章节相关的标题
/// #custom-outline(
///   filter: hd => hd.relation != none and not hd.relation.unrelated
/// )
///
/// // 示例2：高亮当前章节，淡化其他章节
/// #custom-outline(
///   filter: hd => hd.level <= 2,
///   transform: (hd, it) => {
///     if hd.relation != none and hd.relation.same {
///       strong(text(fill: blue, it))
///     } else if hd.relation != none and hd.relation.child {
///       text(fill: blue, it)
///     } else {
///       text(fill: gray, it)
///     }
///   }
/// )
///
/// // 示例3：多级缩进的层级大纲
/// #custom-outline(
///   transform: (hd, it) => {
///     let indent = "  " * (hd.level - 1)
///     [#indent #it]
///   }
/// )
///
/// // 示例4：只显示一级和二级标题
/// #custom-outline(
///   filter: hd => hd.level <= 2,
///   title: [章节概览]
/// )
///
/// // 示例5：显示当前章节及其子章节
/// #custom-outline(
///   filter: hd => {
///     if hd.relation == none { return true }
///     hd.relation.same or hd.relation.child
///   },
///   transform: (hd, it) => {
///     if hd.relation != none and hd.relation.same {
///       text(weight: "bold", size: 1.2em, it)
///     } else {
///       it
///     }
///   }
/// )
///
/// // 示例6：面包屑导航样式
/// #custom-outline(
///   filter: hd => hd.relation != none and (hd.relation.parent or hd.relation.same),
///   transform: (hd, it) => {
///     if hd.relation.same {
///       text(weight: "bold", it)
///     } else {
///       text(fill: gray.darken(30%), it)
///     }
///   },
///   title: none
/// )
/// ```
///
/// **技巧 / Tips:**
/// - 使用 `hd.level` 控制显示深度
/// - 使用 `hd.relation` 实现上下文感知样式
/// - 结合 `filter` 和 `transform` 创建复杂的大纲效果
/// - 在章节页使用可以创建"你在这里"的导航效果
#let custom-outline(
  filter: hd => true,
  transform: (_, it) => it,
  target: heading.where(outlined: true),
  ..args
) = context {
  // 参数验证（注意：Typst 中 type() 返回类型对象，不是字符串）
  assert(type(filter) == function, message: "filter must be a function")
  assert(type(transform) == function, message: "transform must be a function")
  
  // 获取标题上下文
  let cx = headings-context(target: target)
  let idx = cx.at("current-heading-idx", default: none)
  let scope-path = if idx != none {
    cx.headings.at(idx).path
  } else {
    none
  }

  // 构建增强的标题信息并应用过滤器
  let headings = cx.headings.map(hd => {
    let level = hd.path.len()

    // 计算与当前标题的关系
    let relation = if scope-path != none {
      let path-len = calc.min(level, scope-path.len())
      let has-common = has-common-prefix(hd.path, scope-path, path-len)

      let is-same = hd.path == scope-path
      let is-parent = not is-same and has-common and level < scope-path.len()
      let is-child = not is-same and has-common and level > scope-path.len()
      
      // 兄弟节点：同级别且共享父路径
      let is-sibling = (not is-same and level == scope-path.len() and path-len > 1 and has-common-prefix(hd.path, scope-path, path-len - 1))

      (
        same: is-same,
        parent: is-parent,
        child: is-child,
        sibling: is-sibling,
        unrelated: not (is-same or is-parent or is-child or is-sibling),
      )
    } else {
      none
    }
    
    // 返回完整的标题信息
    (
      here-path: scope-path,
      here-level: if scope-path != none { scope-path.len() } else { none },
      level: level,
      path: hd.path,
      relation: relation,
      loc: hd.heading.location(),
      heading: hd.heading
    )
  }).filter(filter)

  // 处理空结果：返回空大纲
  if headings.len() == 0 {
    // 使用不可能匹配的选择器生成空大纲
    let nonsense-target = selector(<__EMPTY__>).and(<__OUTLINE__>)
    outline(target: nonsense-target, ..args)
    return
  }

  // 创建位置到标题信息的映射（性能优化）
  let location-map = (:)
  for hd in headings {
    location-map.insert(repr(hd.loc.position()), hd)
  }

  // 查找标题的辅助函数
  let find-heading(location) = {
    location-map.at(repr(location.position()), default: none)
  }

  // 应用样式转换
  show outline.entry: it => {
    let hd = find-heading(it.element.location())
    if hd != none {
      transform(hd, it)
    } else {
      it  // 降级处理
    }
  }

  // 构建选择器
  let selection = selector(headings.at(0).loc)
  for idx in range(1, headings.len()) {
    selection = selection.or(headings.at(idx).loc)
  }

  outline(target: selection, ..args)
}