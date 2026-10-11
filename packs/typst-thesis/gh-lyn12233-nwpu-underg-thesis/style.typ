/// @file style.typ
/// this style should align to docx_template.pdf
///
/// (max-char-in-line=74)
///
/// # usage
/// ```rust
/// #import "style.typ": get_thesis_by_name
/// #let thesis = get_thesis_by_name("nwpu.undergraduate.release")
/// #show: thesis.begin
/// #show: thesis.before_main // 中英文摘要
/// #(thesis.contents_table)() // 目录
/// #show: thesis.main_body // 正文
/// #show: thesis.tailof_main // 不记章节的内容
/// #(thesis.bib)("your.bib") // 参考文献, 致谢, 附录...
/// ```
///
/// # structure of code
/// all parameters are wrapped into a parms dict, then functions are
/// defined to show different regions, which are packed into `thesis` for
/// export.
///
/// # implementation details
/// ## text
/// (1) font and font size/boundary for section(hdr1), subsection(hdr2),
/// subsubsection(hdr3), main body and caption. note normal text in docx
/// corresponds a 0.15em baseline shift. docx makes cjk text align just
/// at the center of a line selection. (2) normal horizontal spacing,
/// vertical edges from cap-height(1em) to baseline or bigger. (3) enable
/// kerning, disable hyphenate and ligature.
/// ## paragraph
/// (1) spacing between lines and paragraphs, which is usually a 1.25x
/// scale. this needs a conversion skip=scale*15.6pt-1em, for 15.6pt*2 is
/// a grid line in docx format. note the ownership of the space is part of
/// the text, as a multi line selection in docx seams the gap in between
/// precisely. therefore to deal with spacing edit text edges rather than
/// set spacing+leading in `par` (2) allow full justification support,
/// currently the default parameters.
/// ## page
/// (1) margin 3.18cm horizontal and 2.54cm vertical. (2) paper=a4.
/// (3) footer: header:
/// ## heading
/// (1)

#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "corrections.typ": calib

#let font_parms = (
  size: (
    SanHao: 16pt,
    SiHao: 14pt,
    XiaoSi: 12pt,
    WuHao: 10.5pt,
    XiaoWu: 9pt,
  ),
  _font: (
    SongTi: ("Times New Roman", "SimSun"),
    HeiTi: ("Arial", "SimHei"), // todo: may it be times new roman
    NCMMath: ("New Computer Modern Math", "SimSun"),
  ),
)

#let basic_text_parms = (
  font: font_parms._font.SongTi,
  fallback: false, // unknown glyph without fallback cause panic
  // style: "normal",
  weight: "regular", // heading will try to change this implicitly
  // stretch: 100%,
  size: font_parms.size.XiaoSi,
  // fill: luma(0),
  // stroke: none,
  // tracking: 0pt, // space between chars
  // spacing: 100%+0pt, // space between words
  cjk-latin-spacing: none, // auto spacing may not work normal
  baseline: -0.15em + calib.baseline_dy,
  // overhang: true,
  /*
  dispose this, for it may add calc difficulties special texts.
  lineskip is added by either overridding these or setting block insets.
  top-edge: (1em + 15.6pt * 1.25) / 2,
  bottom-edge: (1em - 15.6pt * 1.25) / 2,
  */
  top-edge: 1em,
  bottom-edge: 0em,
  // lang: "en",
  // region: none,
  // script: auto,
  dir: ltr,
  hyphenate: false, // 连字符
  // costs: ...,
  // kerning: true,
  ligatures: false, // 连字
  number-type: "lining",
  // number-width: auto
  // slashed-zero: false,
  // fractions: false,
  // variations: ..., // 变体，包括磅数等
)

#let small_text_parms = (
  ..basic_text_parms,
  size: font_parms.size.WuHao,
  top-edge: (1em + 23.4pt) / 2,
  bottom-edge: (1em - 23.4pt) / 2,
)

#let par_common_skip = 1.25em * 1.3 - 1em // todo change this repr?
#let par_parms = (
  leading: 0pt,
  spacing: 0pt,
  justify: true,
  // justification-limits:(
  //  spacing:(min:66.67%+0pt,max:150%+0pt),
  //  tracking:(min:0pt,max:0pt),
  // )
  // // need to change this later
  // // same as the fields in text, meaning spacing between words and chars
  linebreaks: "optimized", // change linebreak position for justification
  first-line-indent: (amount: 2em, all: true),
  // hanging-indent: 0pt,
)

#let page_parms = (
  paper: "a4",
  // width:auto, height:auto,
  // flipped:false,
  margin: (x: 3.18cm, y: 2.54cm), // todo: calib
  // bleed: (:) // margin out of the page
  // binding: auto // bound page with text direction
  // columns: 1,
  // fill: auto, // color
  // numbering: none, // override this with explicit footer
  // supplement: auto, // supplement in page reference
  // number-align: auto, // override this with footer
  header: align(top)[

    // this is the header, text+logo
    // goes weirder now, 31.2t height -> 1.3em=20.8pt
    // same scale applies to baseline: 0.15em*31.2/20.8 -> 0.1em
    // also top and bottom edge/inset: (1.3em-16pt)/2 -> 2.4pt

    #set text(
      ..basic_text_parms,
      size: font_parms.size.SanHao,
      baseline: -0.1em,
    )
    #v(1.5cm + calib.header_text_dy)
    #block(inset: 0.3 * 8pt, width: 100%, stroke: 0.0pt)[
      #h(10.45 * 8pt)
      #box(width: 1fr, align(center)[
        #h(3 * 8pt + calib.header_text_dx)
        *本科毕业设计（论文）*
      ])
    ]
    #v(calib.header_line_dy)
    #line(length: 100%, stroke: 0.72pt)
    #place(
      top + left,
      dx: 3.44cm,
      dy: 1.5cm + calib.header_img_dy,
      image("ref/npu_logo_1.png", height: 0.61cm, width: 2.99cm),
    )
  ],
  // todo: impl
  header-ascent: 0pt, //
  footer: [
    #block(width: 100%, height: 1fr, place(bottom + left, dx: 23 * font_parms.size.XiaoWu, text(
      ..basic_text_parms,
      size: font_parms.size.XiaoWu,
    )[#context counter(page).display("1")]))
    #v(1.75cm)
  ],
  footer-descent: 0pt,
  // background: none, foreground: none,
)

#let heading_parms = (
  // level: auto,
  // depth: 1, // base level
  // offset: 0, // level offset, calc level=depth+offset
  numbering: (..nums) => {
    if nums.pos().len() == 1 {
      "第" + numbering("一", nums.at(0)) + "章  "
      counter(math.equation).update(0)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
    } else if nums.pos().len() == 2 {
      numbering("1.1", ..nums)
    } else if nums.pos().len() == 3 {
      numbering("1.1.1", ..nums)
    }
  },
  // supplement: auto, // supplement in heading reference
  outlined: true, // include in typst's outline
  bookmarked: true, // include in pdf's outline
  // hanging-indent: auto, // indent for wrapping long heading
)

#let basic_block_parms = (
  // width: auto, height: auto,
  breakable: true, // allow break across pages
  // fill: none,
  // stroke: (:), radius: (:),
  inset: 0pt, // pad between border and content
  outset: 0pt, // pad between layout and border
  // spacing: none, // shorthand of above and below
  above: 0pt,
  below: 0pt,
  // clip: false,
  sticky: false, // you should manually prevent orphaned heading
)

#let outline_parms = (
  title: none,
  // target: heading,
  depth: 3,
  indent: 2em,
)
#let cnt_hdr1 = counter("outline_cnt1")
#let cnt_hdr1_after = counter("outline_cnt2")
#let outline_entry = it => {
  // set block(stroke: 1pt)
  if it.level == 1 {
    // block(height: 7.8pt, fill: aqua)
    if cnt_hdr1.get().at(0) > 0 {
      if cnt_hdr1_after.get().at(0) == 1 {
        block(height: 3.9pt)
      } else {
        block(height: 7.8pt)
      }
    }
    cnt_hdr1.step()
    cnt_hdr1_after.update(1)

    strong(it.prefix())
    strong(it.body())
    box(
      width: 1fr,
      baseline: 0pt,
      // stroke: 0.5pt,
      repeat(text(
        font: "SimSun",
        top-edge: 1em,
        bottom-edge: 0em,
        baseline: 0em,
        size: font_parms.size.WuHao,
      )[…]),
    )
    it.page()
  } else {
    cnt_hdr1_after.update(0)

    h(1.7em * (it.level - 1))
    it.prefix() + " "
    it.body()
    box(
      width: 1fr,
      baseline: 0pt,
      // stroke: 0.5pt,
      repeat(text(
        font: "SimSun",
        top-edge: 1em,
        bottom-edge: 0em,
        baseline: 0em,
        size: font_parms.size.WuHao,
      )[…]),
    )
    it.page()
  }
  v(0pt)
}

#let equation_parms = (
  numbering: (..nums) => {
    set text(
      ..basic_text_parms,
      // this doesn't ctrl equation row height correctly
      // top-edge: (1em + 23.4pt) / 2,
      // bottom-edge: (1em - 23.4pt) / 2,
      // baseline: 0.3em,
    )
    // set actually identical to main matter font
    // consider docx template flawed here
    context "(" + str(counter(heading).get().at(0)) + "-" + str(nums.pos().at(0)) + ")"
  },
  number-align: end + bottom,
  // supplement: auto,
  // alt: none, // alternative desc
)

#let figure_parms = (
  // alt: none,
  // placement: none,
  // scope: "column",
  // caption, kind, supplement, numbering,
  gap: 0pt,
  // outlined: true,
)

#let figure_caption = it => {
  if it.kind == table {
    block(..basic_block_parms, stroke: 0pt, text(
      ..small_text_parms,
      font: font_parms._font.HeiTi,
      (
        "表"
          + str(counter(heading).get().at(0))
          + "-"
          + str(counter(figure.where(kind: table)).get().at(0))
          + "  "
          + it.body
      ),
    ))
  } else if it.kind == image {
    block(..basic_block_parms, stroke: 0pt, text(
      ..small_text_parms,
      (
        "图"
          + str(counter(heading).get().at(0))
          + "-"
          + str(counter(figure.where(kind: image)).get().at(0))
          + "  "
          + it.body
      ),
    ))
  }
}

#let table_parms = (
  column-gutter: 0pt,
  row-gutter: 0pt,
  inset: 0pt,
  align: center + horizon,
  // fill: none,
  stroke: 0.5pt,
)

#let image_parms = (
  // format: auto,
  width: 12cm,
  height: auto,
  fit: "contain",
  scaling: "smooth",
)

#let default_parms = (
  _text: (
    hdr1: (
      ..basic_text_parms,
      font: font_parms._font.HeiTi,
      size: font_parms.size.SanHao,
      baseline: -0.15em + calib.baseline_hdr1_dy,
      top-edge: (1em + 31.2pt) / 2,
      bottom-edge: (1em - 31.2pt) / 2,
    ),
    hdr2: (
      ..basic_text_parms,
      font: font_parms._font.HeiTi,
      size: font_parms.size.SiHao,
      top-edge: (1em + 31.2pt) / 2,
      bottom-edge: (1em - 31.2pt) / 2,
    ),
    hdr3: (
      ..basic_text_parms,
      font: font_parms._font.HeiTi,
      size: font_parms.size.XiaoSi,
      top-edge: (1em + 15.6pt * 1.25) / 2,
      bottom-edge: (1em - 15.6pt * 1.25) / 2,
    ),
    main: (
      ..basic_text_parms,
      top-edge: (1em + 15.6pt * 1.25) / 2,
      bottom-edge: (1em - 15.6pt * 1.25) / 2,
    ),
    math: (
      ..basic_text_parms,
      baseline: 0pt,
      font: font_parms._font.NCMMath,
    ),
    table: small_text_parms,
    cite: (
      baseline: calib.cite_dy,
    ),
  ),
  _par: (
    main: par_parms,
    math: (
      ..par_parms,
      // x1.5 in 12pt, only spacing in multiline equation
      leading: (23.4pt - 1em) / 2,
    ),
  ),
  _page: (
    main: page_parms,
    before_main: (
      ..page_parms,
      footer: [
        #block(width: 100%, height: 1fr, place(bottom + left, dx: 23 * font_parms.size.XiaoWu, text(
          ..basic_text_parms,
          size: font_parms.size.XiaoWu,
        )[#context counter(page).display("I")]))
        #v(1.75cm)
      ],
    ),
  ),
  _heading: (
    main: heading_parms,
    before_main: (
      ..heading_parms,
      numbering: none,
      outlined: false,
    ),
    tail: (
      ..heading_parms,
      numbering: none,
    ),
  ),
  _block: (
    main: basic_block_parms,
    hdr1: (
      ..basic_block_parms,
      // inset: (y: 15.6pt - 0.5em),
      inset: 0pt,
      // stroke: 1pt,
    ),
    hdr2: (
      ..basic_block_parms,
      // inset: (y: 15.6pt - 0.5em),
      inset: 0pt,
      // stroke: 1pt,
    ),
    hdr3: (
      ..basic_block_parms,
      // inset: (y: par_common_skip / 2),
      inset: 0pt,
      // stroke: 1pt,
    ),
    math: (
      ..basic_block_parms,
      breakable: true,
      // derived from x1.5 spacing
      inset: (y: (23.4pt - 1em) / 2),
      // stroke: 0.51pt,
    ),
  ),
  _equation: equation_parms,
  _figure: figure_parms,
  _caption: figure_caption,
  _caption_pos: (table: top, image: bottom),
  _table: table_parms,
  _image: image_parms,
  _align: (hdr1: center, hdr2: left, hdr3: left),
  i_heading: it => {
    if it.level == 1 {
      align(center, text(
        ..basic_text_parms,
        top-edge: (1em + 15.6pt * 1.25) / 2,
        bottom-edge: (1em - 15.6pt * 1.25) / 2,
        fill: rgb(255, 0, 0),
        [*（空 2 行，小四号，下同）*],
      ))
      it
      align(center, text(
        ..basic_text_parms,
        top-edge: (1em + 15.6pt * 1.25) / 2,
        bottom-edge: (1em - 15.6pt * 1.25) / 2,
        fill: rgb(255, 0, 0),
        [*（空 1 行）*],
      ))
    } else {
      it
    }
  },
  i_figure: it => {
    if it.kind == table {
      align(center, text(
        ..basic_text_parms,
        top-edge: (1em + 15.6pt * 1.25) / 2,
        bottom-edge: (1em - 15.6pt * 1.25) / 2,
        fill: rgb(255, 0, 0),
        [*（表格标题五号黑体，表中内容五号宋体，居中，按章标号）*],
      ))
      it
      align(center, text(
        ..basic_text_parms,
        top-edge: (1em + 15.6pt * 1.25) / 2,
        bottom-edge: (1em - 15.6pt * 1.25) / 2,
        fill: rgb(255, 0, 0),
        [*（表前、后各空 1 行）*],
      ))
    } else if it.kind == image {
      align(center, text(
        ..basic_text_parms,
        top-edge: (1em + 15.6pt * 1.25) / 2,
        bottom-edge: (1em - 15.6pt * 1.25) / 2,
        fill: rgb(255, 0, 0),
        [*（图题及图内文字为五号字体，按章标号，单位格式见图）*],
      ))
      it
      align(center, text(
        ..basic_text_parms,
        top-edge: (1em + 15.6pt * 1.25) / 2,
        bottom-edge: (1em - 15.6pt * 1.25) / 2,
        fill: rgb(255, 0, 0),
        [*（图前、后各空 1 行）*],
      ))
    } else {
      it
    }
  },
  i_ref: it => {
    let elem = it.element
    if elem == none {
      it // this is the deafult behavior?
    } else if elem.func() == figure {
      link(elem.location(), box(
        // stroke: 0.5pt,
        baseline: 0em,
        if elem.kind == table {
          (
            "表"
              + " "
              + str(counter(heading).at(elem.location()).at(0))
              + "-"
              + str(counter(figure.where(kind: table)).at(elem.location()).at(0))
          )
        } else if elem.kind == image {
          (
            "图"
              + " "
              + str(counter(heading).at(elem.location()).at(0))
              + "-"
              + str(counter(figure.where(kind: image)).at(elem.location()).at(0))
          )
        } else if elem.kind == grid {
          (
            "图表"
              + " "
              + str(counter(heading).at(elem.location()).at(0))
              + "-"
              + str(counter(figure.where(kind: grid)).at(elem.location()).at(0))
          )
        } else {
          "unknown-figure"
        },
      ))
    } else if elem.func() == math.equation {
      (
        link(elem.location(), box(
          baseline: 0em,
          (
            "公式"
              + " "
              + str(counter(math.equation).at(elem.location()).at(0))
              + "-"
              + str(counter(math.equation).at(elem.location()).at(0))
          ),
        ))
      )
    } else {
      it
    }
  },
  i_bibliography: source => {
    pagebreak(weak: true)
    heading("参考文献", level: 1)
    show bibliography: set text(
      ..basic_text_parms,
      // 2026.8 bib spacing is currently x1
      top-edge: (1em + 15.6pt) / 2,
      bottom-edge: (1em - 15.6pt) / 2,
    )
    bibliography(source, full: true, style: "gb-7714-2015-numeric", title: none)
    pagebreak(weak: true)
  },
  i_outline: () => {
    set outline(..outline_parms)
    set par(first-line-indent: 0pt)
    show outline.entry: outline_entry
    outline()
  },
  i_equation_inline: it => box(baseline: -5% + 0.1pt, it, stroke: 0pt),
)

#let get_thesis_from_parms(parms) = {
  let common_style(body) = {
    show: show-cn-fakebold
    set text(..parms._text.main)
    set par(..parms._par.main)

    show math.equation: set text(..parms._text.math)
    show math.equation.where(block: true): set par(..parms._par.math)
    show math.equation.where(block: true): set block(..parms._block.math)
    show math.equation.where(block: false): parms.i_equation_inline
    set math.equation(..parms._equation)

    set figure(..parms._figure)
    show figure.caption: parms._caption
    show figure.where(kind: table): set figure.caption(position: parms._caption_pos.table)
    show figure.where(kind: image): set figure.caption(position: parms._caption_pos.image)
    set table(..parms._table)
    show table: set text(..parms._text.table)
    set image(..parms._image)

    show cite: set text(..parms._text.cite)

    show heading.where(level: 1): set block(..parms._block.hdr1)
    show heading.where(level: 2): set block(..parms._block.hdr2)
    show heading.where(level: 3): set block(..parms._block.hdr3)
    show heading.where(level: 1): set text(..parms._text.hdr1)
    show heading.where(level: 2): set text(..parms._text.hdr2)
    show heading.where(level: 3): set text(..parms._text.hdr3)
    show heading.where(level: 1): set align(parms._align.hdr1)
    show heading.where(level: 2): set align(parms._align.hdr2)
    show heading.where(level: 3): set align(parms._align.hdr3)

    body
  }
  let begin_thesis(body) = {
    show: common_style

    show heading: parms.i_heading
    show figure: parms.i_figure
    show ref: parms.i_ref

    body
  }
  let main_body(body) = {
    show: common_style

    set page(..parms._page.main)
    set heading(..parms._heading.main)

    counter(page).update(1)

    body
  }
  let before_main(..args, body) = {
    show: common_style

    set page(..parms._page.before_main)
    set heading(..parms._heading.before_main)

    body
  }
  let contents_table() = {
    show: common_style
    pagebreak(weak: true)
    heading(level: 1, underline(
      // docx to pdf conversion problem.
      offset: 0.72pt, // should be this, but pdf renders wrong
      stroke: 1.44pt,
      text(
        weight: "bold",
        " " * 24 + "目  录" + " " * 24,
      ),
    ))
    (parms.i_outline)()
    pagebreak(weak: true)
  }
  let tailof_main(..args, body) = {
    show: common_style
    set heading(..parms._heading.tail)
    body
  }
  let thesis = (
    begin: begin_thesis,
    main_body: main_body,
    before_main: before_main,
    contents_table: contents_table,
    tailof_main: tailof_main,
    bib: parms.i_bibliography,
  )
  return thesis
}

#let get_thesis_by_name(name) = {
  if name == "nwpu.undergraduate.debug" {
    get_thesis_from_parms(default_parms)
  } else if name == "nwpu.undergraduate.release" {
    let default_space = v(15.6pt * 1.25)
    let release_parms = (
      ..default_parms,
      i_heading: it => {
        if it.level == 1 {
          default_space
          it
          default_space
        } else { it }
      },
      i_figure: it => {
        if it.kind == table or it.kind == image {
          default_space
          it
          default_space
        } else { it }
      },
    )
    // get_thesis_from_parms(default_parms)
    get_thesis_from_parms(release_parms)
  } else {
    panic("thesis template not provided" + str(name))
  }
}

/// @todo: empty line after figure may cross pages
