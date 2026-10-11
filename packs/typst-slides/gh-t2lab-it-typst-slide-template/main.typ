//#import "typst_slide_template/lib.typ": *
#import "lib.typ": *
#show: set-init.with(font: gothic)
#show: bib-init

// --------------------------------------------------
// テーマの設定
// --------------------------------------------------

#import metropolis: *
#show: theme-setting.with(
  title: [タイトル],
  subtitle: [サブタイトル],
  author: [名前],
  date: nowdate_slash,// nowdate_slash: 2024/10/2  nowdate_jp: 2024年10月2日
  institution: [所属],
  handout: false,// false: 通常スライド true: 資料スライド
)
// ==================================================

#title-slide()

== スライドタイトル
#slide[
  #description([スライドの補足説明])
  スライドテキスト
]

// ==================================================

 == 参考文献
#slide[
  #bibliography-list(
    title: none,
  ..bib-file(read("ref.bib"))
  )
]

// ==================================================
#show: appendix
