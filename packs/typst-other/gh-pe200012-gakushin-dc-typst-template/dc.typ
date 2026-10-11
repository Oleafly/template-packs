// JSPS 特別研究員（DC）申請書 Typst テンプレート（LaTeX 版 1:1 移植）
//
// Credits:
// - Original LaTeX template (KakenhiLaTeX / 科研費LaTeX): Taku Yamanaka (Osaka Univ.)
//   http://osksn2.hep.sci.osaka-u.ac.jp/~taku/kakenhiLaTeX/
//
// 本ファイル（dc.typ）だけ編集すれば申請書本文を作成できます。

// ======================
// 基本信息（请修改）
// ======================
#let kenkyu_kadai = "象の卵"
#let shinseisha_name = "湯川秀樹"

// ======================
// 版面常量（来自 LaTeX 参考 PDF 的 bbox）
// ======================
#let page_offset = 2
#let a4_width = 595.28pt
#let a4_height = 841.89pt
#let page_center_x = 297.64pt

// LaTeX 版面（dc_utf_single/pieces/form01_dcpd_header.tex）
#let body_left_margin = 50.082pt
#let body_text_width = 496pt
#let body_right_margin = a4_width - body_left_margin - body_text_width
#let body_top_margin = 20mm
#let body_text_height = 254mm
#let body_bottom_margin = a4_height - body_top_margin - body_text_height

// 页脚（右侧栏位 + 姓名）
#let footer_x_label = 344.885pt
#let footer_x_name = 502.242pt
#let footer_x_right = 544.230pt
#let footer_y_text = 798.225pt
#let footer_y_line = 808.722pt

// 续页页眉（“（…の続き）”）
#let cont_x = 50.082pt
#let cont_y = 45.033pt

// 第1页右上角の追加ヘッダ（原 LaTeX 出力から文字 bbox ぴったりで切り出した画像を使用）
#let first_page_header_exact_x = 420.12pt
#let first_page_header_exact_y = 40.32pt
#let first_page_header_exact_w = 128.16pt

// ======================
// 工具函数
// ======================
#let zenkaku(s) = (
  s
    .replace("0", "０")
    .replace("1", "１")
    .replace("2", "２")
    .replace("3", "３")
    .replace("4", "４")
    .replace("5", "５")
    .replace("6", "６")
    .replace("7", "７")
    .replace("8", "８")
    .replace("9", "９")
)

#let disp_page() = counter(page).get().first() + page_offset

#let header_strip(id) = {
  // 全宽表头条带：左移使其对齐页面左边缘。
  // 另外将 PDF 本体略微上移，使第一页右上角 header 与 LaTeX 输出逐点对齐。
  move(dx: -body_left_margin, dy: -1.113pt)[
    #image("subject_headers/dc_header_" + id + ".pdf", width: 210mm)
  ]
  // LaTeX 版のヘッダ直後にはわずかな余白があるため、Typst 側では詰めすぎない
  v(-0.9mm)
}

#let include_fullwidth_pdf(path) = {
  move(dx: -body_left_margin)[#image(path, width: 210mm)]
}

#let JSPSInstructions() = {
  set text(fill: red)
  [(
    #raw("\\JSPSInstructions")
    をコメントアウトしてください。
  )]
  set text(fill: black)
  include_fullwidth_pdf("subject_headers/inst_general.pdf")
}

#let SelfReviewInstructions() = {
  set text(fill: red)
  [(
    #raw("\\SelfReviewInstructions")
    をコメントアウトしてください。
  )]
  set text(fill: black)
  include_fullwidth_pdf("subject_headers/inst_self_review.pdf")
}

// 固定页数栏目：超页报错、不足补页
// 注意：不能在同一个 `context { ... }` 内用 counter(page).get() 计算前后页差，
// 因为 context 绑定到单一位置。这里用 `here()` 捕获起止 location，再用 counter.at 做“时间旅行”。
// 结束位置不能作为独立块级 `context` 放在 `body` 后面；否则 Typst 可能把它推到下一页，
// 导致明明还在当前页的内容被误判为超页。这里改用行内 0pt box 记录结束位置。
#let subject(id, name, max_pages, last: false, body) = {
  let start_loc = state("dc-subject-" + id + "-start", none)
  let end_loc = state("dc-subject-" + id + "-end", none)

  // 捕获栏目开始位置
  context { start_loc.update(here()); none }

  [
    #header_strip(id)
    #body
    #box(width: 0pt, height: 0pt)[
      #context { end_loc.update(here()); none }
    ]
  ]

  // 计算实际占用页数，并补足到固定页数
  context {
    let start = counter(page).at(start_loc.get()).first()
    let end = counter(page).at(end_loc.get()).first()
    let used = end - start + 1

    if used > max_pages {
      panic("「" + name + "」は " + str(max_pages) + " ページ以内で書いてください。")
    }

    for _ in range(max_pages - used) {
      pagebreak()
    }

    pagebreak(weak: last)
  }
}

// ======================
// 全局页面设置
// ======================
#set text(font: "Yu Mincho", size: 11pt)

// 本文段落の字下げ（LaTeX 版の \parindent ≒ 1zw に合わせる）
#let par_indent = 10.5pt
#set par(first-line-indent: (amount: par_indent, all: true))

// \noindent 相当
#let noindent(body) = par(first-line-indent: 0pt)[#body]

// LaTeX 模板中 \section 不显示，这里默认隐藏 1 级标题（= ...）
#show heading.where(level: 1): it => []

#set page(
  paper: "a4",
  margin: (
    left: body_left_margin,
    right: body_right_margin,
    top: body_top_margin,
    bottom: body_bottom_margin,
  ),
  // 使用 background 做绝对定位，复刻 fancyhdr 的页脚与续页页眉
  background: context {
    // -------- 页脚（中心页码 + 右侧姓名栏） --------
    set text(font: "Yu Mincho", size: 11pt)

    // 右侧：申請者登録名 + 下划线 + 姓名
    place(top + left, dx: footer_x_label, dy: footer_y_text)[申請者登録名]
    place(top + left, dx: footer_x_label, dy: footer_y_line)[
      #line(length: footer_x_right - footer_x_label, stroke: 0.8pt)
    ]
    place(top + left, dx: footer_x_name, dy: footer_y_text)[#shinseisha_name]

    // 中心：– ３ –（显示页码从 3 开始；数字全角）
    let p = disp_page()
    let center = [– #(zenkaku(str(p))) –]
    let w = measure(center).width
    place(top + left, dx: page_center_x - w / 2, dy: footer_y_text)[#center]

    // -------- 续页页眉（仅固定页号出现） --------
    set text(font: "Yu Mincho", size: 8pt)
    let phys = counter(page).get().first()

    if phys == 3 {
      place(top + left, dx: cont_x, dy: cont_y)[(【２】研究計画（２）研究目的・内容等の続き)]
    }

    if phys == 6 {
      place(top + left, dx: cont_x, dy: cont_y)[(【４】研究遂行力の自己分析の続き)]
    }
  },
  // 第1页右上角の `(DC 申請内容ファイル)` は foreground で上からかぶせ、
  // 下層の header PDF 上の文字との差異を完全に消す。
  foreground: context {
    let phys = counter(page).get().first()
    if phys == 1 {
      place(top + left, dx: first_page_header_exact_x, dy: first_page_header_exact_y)[
        #image("subject_headers/page1_header_exact.png", width: first_page_header_exact_w)
      ]
    }
  },
)

// ======================
// 正文（请在各栏目内填写）
// ======================
#subject("01", "研究の概要と位置づけ", 1)[
  #noindent[#underline([*研究課題名：#kenkyu_kadai*])]

  象の卵の研究の目的は．．．
  象の卵の研究計画と方法は．．．

  風呂で巨大な温泉卵について考えていて、ふと思いついた。
  準備はしようとしている。
  唯一無二。
]

#subject("02", "【２】研究計画（２）研究目的・内容等", 2)[
  #JSPSInstructions()

  *＊＊＊ 以下は、あくまで例です。真似しないでください。＊＊＊*

  象の卵の研究計画は．．．

  #v(8mm)
  *参考文献*
  + 寺村輝夫、「ぼくは王様 - ぞうのたまごのたまごやき」.
]

#subject("03", "人権の保護及び法令等の遵守への対応", 1)[
  象の卵のES細胞の培養、象のクローンの生成などは行わない。
]

#subject("04", "【４】研究遂行力の自己分析", 2, last: true)[
  #SelfReviewInstructions()

  #noindent[*(1) 研究に関する自身の強み*]

  応募者は過去20年間、研究を遂行してきた強靭な能力を有する。

  + ``Search for whale eggs'', H. Yukawa et al., Rev. Oceanic Mysteries (2017).
  + ``Theory of Elephant Eggs'', H. Yukawa et al., Phys. Rev. Lett. (2005).

  #v(5mm)
  #noindent[*(2) 今後研究者として更なる発展のため必要と考えている要素*]

  研究費を獲得する術。
]
