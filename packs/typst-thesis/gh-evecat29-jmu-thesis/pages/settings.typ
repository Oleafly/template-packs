#let setup_page(song, doc, thesis_info) = {
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    
    header: context {
      let loc = here()
      let abs_page = loc.page()
      let logical_page_count = counter(page).at(loc).first()
      
      // 获取当前及之前的所有一级标题
      let all_h1 = query(heading.where(level: 1))
      let past_h1 = all_h1.filter(h => h.location().page() <= abs_page)
      
      if past_h1.len() == 0 { return }
      
      let cur_h = past_h1.last()
      let h_body = cur_h.body

      // 特殊页面保留页眉
      let h_str = repr(h_body)
      let is_toc = cur_h.has("label") and cur_h.label == <toc>
      let is_abstract_cn = cur_h.has("label") and cur_h.label == <abstract>
      let is_abstract_en = cur_h.has("label") and cur_h.label == <abstract_en>

      let is_summary = cur_h.has("label") and cur_h.label == <summary>
      let is_thanks = cur_h.has("label") and cur_h.label == <thanks>
      let is_refs = cur_h.has("label") and cur_h.label == <refs>
      
      let header_content = if is_abstract_cn {
        [摘#h(1em)要]
      } else if is_abstract_en {
        [Abstract]
      } else if is_toc {
        [目#h(1em)录]
      } else if is_summary {
        [总结与展望]
      } else if is_thanks {
        [致#h(1em)谢]
      } else if is_refs {
        [参考文献]
      } else if calc.even(logical_page_count) {
        // 相对页码的偶数页显示自定义内容
        thesis_info.custom_pagefront
      } else {
        // 相对页码的奇数页显示标题
        if cur_h.numbering != none {
          let num = numbering(cur_h.numbering, ..counter(heading).at(cur_h.location()))
          num + h(0.5em) + h_body
        } else {
          h_body
        }
      }

      // 渲染输出
      if header_content != none {
        set align(center)
        set text(size: 10.5pt)
        song(header_content)
        v(-0.8em)
        line(length: 100%, stroke: 0.5pt)
      }
    },

    footer: context {
      set align(center)
      set text(size: 10.5pt)
      song(counter(page).display())
    }
  )

  doc
}