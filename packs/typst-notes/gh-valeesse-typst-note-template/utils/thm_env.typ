// thm_env.typ

// =============================================
// 1. 定理环境生成器
// =============================================

// 标题计数
#let chap_num(numbering_level, loc) = {
  let heading_numbers = counter(heading).at(loc)
  let upper_bound = if numbering_level < heading_numbers.len() { numbering_level } else { heading_numbers.len() }
  // 返回实际用于比较的标题编号数组
  heading_numbers.slice(1, upper_bound)
}

// 定理环境计数
#let thm_num(counter_el, loc) = {
  counter_el.at(loc).last()
}

// 引用计算
#let ref-thm(l) = context {
  let meta_env = query(l).last()
  let loc = meta_env.location()
  let name = meta_env.value.name
  let numbering_level = meta_env.value.at("numbering_level")
  let counter_el = meta_env.value.at("counter_el")
  let current_chap_nums = chap_num(numbering_level, loc)

  // 格式化标题和定理编号用于显示
  link(l)[#name #current_chap_nums.map(str).join(".").#thm_num(counter_el, loc)]
}

// 创建环境
#let create-thm(env_args) = {
  let name = env_args.name
  let counter_el = env_args.counter_el
  let color = env_args.color
  let numbered = env_args.numbered
  let numbering_level = env_args.numbering_level
  let blocked = env_args.blocked

  // 使用 state 来跟踪每个计数器对应的上一个章节号
  let chap_num_state = state("chap-num-state-" + repr(counter_el))

  return (..args, body, l: none) => context {
    let custom_title = if args.pos().len() > 0 { args.pos().first() } else { none }

    // 获取当前位置的章节号
    let current_chap_nums = chap_num(numbering_level, here())
    let current_chap_str = current_chap_nums.map(str).join(".")

    // 按章节重置定理环境计数
    // 如果上次保存的章节号变化了，重置计数器
    if chap_num_state.get() != current_chap_nums {
      counter_el.update(0)
    }
    // 更新 state 为当前的章节号
    chap_num_state.update(current_chap_nums)

    let number = context if numbered {
      [#current_chap_str.#thm_num(counter_el, here())]
    }

    // 构造元数据，方便计算引用时的定理计数
    let meta = if l != none {
      [#metadata(env_args) #l]
    }

    let title = context {
      strong[
        #name
        #if numbered {
          number
        }
        #if custom_title != none {
          [(#custom_title)]
        }
      ]
    }

    let block_content = if blocked {
      block(
        fill: color.lighten(90%),
        stroke: (left: 2pt + color),
        radius: 3pt,
        inset: 10pt,
        width: 100%,
        breakable: true,
        [
          #text(fill: color.darken(20%))[#title]
          #body
        ],
      )
    } else {
      block(width: 100%, breakable: true, [
        #text(fill: color.darken(20%))[#title]
        #body
      ])
    }

    figure(
      caption: none,
      gap: 0em,
      kind: "thm-env",
      supplement: title,
      outlined: false,
    )[
      // 步进当前编号，使编号从1开始
      #counter_el.step()

      // 附加元数据，方便计算引用的定理计数
      #meta

      // 环境内容
      #set align(left)
      #set par(first-line-indent: 0em)
      #block_content
    ]
  }
}

