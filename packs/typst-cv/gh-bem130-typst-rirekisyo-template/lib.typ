// typst-rirekisyo-template
// エントリポイント。公開 API は render-resume()。

#import "components/left-half.typ": left-half
#import "components/right-half.typ": right-half

// ストローク定数
#let _stroke-outer = 0.65pt
#let _stroke-inner = 0.30pt
#let _stroke-dash  = (paint: black, thickness: 0.30pt, dash: "dashed")

// 列幅・行高定数
#let _year-col-w   = 19.05mm
#let _month-col-w  = 9.102mm
#let _header-row-h = 8.255mm
#let _body-row-h   = 9.948mm

#let render-resume(
  date: datetime.today(),

  name: (),

  birth-year: "",
  birth-month: "",
  birth-day: "",
  age: "",
  sex: "",

  furigana-address: "",
  address: [],
  phone-current: "",

  furigana-contact: "",
  contact: [同上],
  phone-contact: "",

  photo: none,

  history-left: (),
  history-right: (),
  licenses: (),

  motivation: [],
  hope: [],
) = {
  set page(paper: "a3", flipped: true, margin: 0mm)
  set text(font: "MS PMincho")
  set par(justify: false, spacing: 0pt)
  set block(spacing: 0pt)

  grid(
    columns: (1fr, 1fr),
    gutter: 0mm,

    block(
      height: 297mm,
      breakable: false,
      clip: true,
      inset: (x: 20.757mm, y: 10mm),
      spacing: 0pt,
    )[
      #left-half(
        date,
        name: name,
        birth-year: birth-year,
        birth-month: birth-month,
        birth-day: birth-day,
        age: age,
        sex: sex,
        furigana-address: furigana-address,
        address: address,
        phone-current: phone-current,
        furigana-contact: furigana-contact,
        contact: contact,
        phone-contact: phone-contact,
        photo: photo,
        history-left: history-left,
        year-col-w: _year-col-w,
        month-col-w: _month-col-w,
        header-row-h: _header-row-h,
        body-row-h: _body-row-h,
        stroke-outer: _stroke-outer,
        stroke-inner: _stroke-inner,
      )
    ],

    block(
      height: 297mm,
      breakable: false,
      clip: true,
      inset: (x: 20.757mm, y: 10mm),
      spacing: 0pt,
    )[
      #right-half(
        history-right: history-right,
        licenses: licenses,
        motivation: motivation,
        hope: hope,
        year-col-w: _year-col-w,
        month-col-w: _month-col-w,
        header-row-h: _header-row-h,
        body-row-h: _body-row-h,
        stroke-outer: _stroke-outer,
        stroke-inner: _stroke-inner,
      )
    ],
  )
}
