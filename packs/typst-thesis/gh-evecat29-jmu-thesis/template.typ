// 文档配置
#import "const.typ": get_heading_config, ctyp_settings, get_body_config

// 中文字号支持
#import "@preview/pointless-size:0.1.2": zh

// ctyp
#import "@preview/ctyp:0.3.0": ctyp, enum-label, item-label

#let thesis_template(
    info: (:),
    body
  ) = {
  // 配置ctyp
  let (ctypset, cjk) = ctyp_settings(ctyp, enum-label, item-label)
  show: ctypset
  let (song, hei, kai, fang) = cjk

  // 视窗的字体没有粗体，用描边假粗体
  import "@preview/zh-format:0.1.0": zh-format
  show: zh-format

  // 标题格式配置
  import "utils/lib.typ" as utils
  show heading: it => utils.heading.apply_style(it, get_heading_config(cjk))

  // 正文配置
  show: doc => utils.body.apply_style(doc, get_body_config())

  // 导入页面
  import "pages/lib.typ": cover, integrity, copyright, setup_page, abstract
  show: doc => setup_page(song, doc, info) // 页面基本设置/页眉页脚

  cover(cjk, info) // 论文封面
  integrity(cjk, info) // 诚信书
  copyright(cjk, info) // 版权使用授权书
  pagebreak() // 空页

  // 罗马数字页码
  set page(numbering: "I")
  counter(page).update(1)

  abstract(cjk, info) // 摘要页

  // 目录
  [#heading(level: 1, numbering: none, outlined: false)[目#h(1em)录] <toc>]
  outline(title: none)
  pagebreak()


  // 切到数字页码
  set page(numbering: "1")
  counter(page).update(1)

  // 设置一些正文会用到的组件
  show: body => utils.tables.table_setup(body)
  show: body => utils.photos.image_setup(body)
  show: body => utils.math.math_setup(body)
  show: body => utils.code.code_setup(body)

  body // 正文

  

  // 确保从新的一页开始
  pagebreak(weak: true)

  // 对特殊页关闭标题编号
  set heading(numbering: none)

  // 总结与展望页
  if "conclusion" in info and info.conclusion != none {
    [#heading(level: 1, outlined: true)[总结与展望]<summary>]
    info.conclusion
  }

  // 致谢页
  if "acknowledgment" in info and info.acknowledgment != none {
    [#heading(level: 1, outlined: true)[致谢]<thanks>]
    info.acknowledgment
  }

  // 参考文献页
  if "bib_path" in info and info.bib_path != none {
    // 使用内置 bibliography 函数
    [#heading(level: 1, outlined: true)[参考文献]<refs>]
    bibliography(info.bib_path, title: none, style: "gb-7714-2015-numeric") // 国标
  }
}
