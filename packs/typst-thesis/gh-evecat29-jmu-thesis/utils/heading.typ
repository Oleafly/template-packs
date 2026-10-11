// 多级标题配置

#let apply_style(it, user-config) = {
  let lvl = str(it.level)
  
  if lvl in user-config.keys() {
    let conf = user-config.at(lvl)
    
    // 第一级标题自动分页
    if conf.at("pagebreak", default: false) { 
      pagebreak(weak: true) 
    }

    // 手动提取编号
    let heading-content = {
      if it.numbering != none {
        numbering(it.numbering, ..counter(heading).at(it.location()))
        // 插入间距
        h(0.5em) 
      }
      it.body
    }

    // 应用字体
    let styled-content = if "font-cjk" in conf {
      let cjk-func = conf.font-cjk
      let latin-kind = conf.at("font-latin", default: "serif")
      let w = conf.at("weight", default: "regular")
      
      cjk-func(heading-content, weight: w, latin: latin-kind)
    } else {
      heading-content
    }

    // 设置对齐和字号
    set align(conf.at("align", default: left))
    set text(size: conf.at("size", default: 10.5pt))
    
    block(
      width: 100%,
      above: conf.at("above", default: 1em),
      below: conf.at("below", default: 1em),
      styled-content
    )
  } else {
    // 如果没有配置该层级，则返回原始标题
    it
  }
}