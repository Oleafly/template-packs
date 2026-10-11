// Get Polylux from the official package repository
#import "@preview/touying:0.5.5": *
#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [下垂体偶発腫について],
    subtitle: [なんで頭部CT撮ってんだよ！],
    author: [Nozomi Niimi],
    date: datetime.today(),
    institution: [東京医療センター総合内科],
    // logo: emoji.school,
  ),
)

// for tall slide
#let tall-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(
    width: 33.867cm,
    height: 33.867cm,
  ))
  touying-slide(self: self, body)
})


// == PEGの倫理的適応

// #tall-slide[
//   #figure(
//   image("figure/PEG_rirni_tekiou.jpeg", height: 70%)
// )
// ]


#show link: underline

#set heading(numbering: numbly("{1}.", default: "1.1"))

#import fletcher.shapes: diamond


// Make the paper dimensions fit for a presentation and the text larger
#set footnote.entry(clearance: 0.1em, gap: 0.2em)
#show heading:set align(start + top)
#show heading: set text(size: 28pt)
#set align(horizon)

#let lb = linebreak(justify: false)

// 大まかなゲシュタルトとして若年者の #lb 「繰り返す発熱と腹痛(+高CRP)」を忘れない  使用例

#let refs(body) = {
  set text(size: 8pt)
  align(right, body)
}

// #refs("Dysphagia. 2024;39(5):837-845.") 使用例

#set list(marker: ([•], [◦], [🗸]))
#let list-counter = counter("list")

#show list: set text(14pt)
#show list: it => {
  list-counter.step()

  context {
    set text(24pt) if list-counter.get().first() == 1
    set text(20pt) if list-counter.get().first() == 2
    set text(16pt) if list-counter.get().first() >= 3
    it
  }
  list-counter.update(i => i - 1)
}

// for main text
#set text(
    lang: "ja",  // 英語しか使わない文書では"en"とする（もしくは指定しない）
    font: ("Calibri", "Noto Sans CJK JP"),
    // font: (日本語文字を含まないフォント, 日本語文字を含むフォント),  となっている
)

// Use #polylux-slide to create a slide and style it using your favourite Typst functions

#title-slide(authors: ([Nozomi Niimi]))

== 症例 

- 79歳女性、自宅内転倒で救急搬送
- 頭部CTで下垂体腺腫を指摘される
- 依頼文にて、「偶発的に下垂体腺腫が指摘されておりそちらの精査もお願いします」と

// #link((page: 1, x: 0pt, y: 0pt))[
//   Go to top
// ]
