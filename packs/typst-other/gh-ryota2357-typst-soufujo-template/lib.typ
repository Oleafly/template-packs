#let soufujo(
  日付: auto,
  宛先: (
    会社名: none,
    部署: none,
    氏名: none,
  ),
  差出人: (
    郵便番号: none,
    住所: none,
    会社名: none,
    部署: none,
    氏名: [],
    電話: none,
    E-mail: none,
  ),
  件名: none,
  頭語: [拝啓],
  結語: [敬具],
  同封物: (),
  備考: none,
  body,
) = {
  set document(title: "送付状")
  set page(paper: "a4", numbering: none, margin: (x: 25mm, y: 25mm))
  set text(font: "Harano Aji Mincho", size: 10.5pt, lang: "ja")
  set par(leading: 0.9em, spacing: 1.8em)

  if 日付 == auto {
    日付 = datetime.today()
  }

  align(right, 日付.display("[year]年[month padding:none]月[day padding:none]日"))

  v(1em)

  // 個人名があれば「様」、なければ組織宛として「御中」を付ける
  // 宛先が none または全項目 none の場合は宛先なしとして何も出力しない
  {
    let 宛先 = if 宛先 in (none, ()) { (:) } else { 宛先 }
    let 会社名 = 宛先.at("会社名", default: none)
    let 部署 = 宛先.at("部署", default: none)
    let 氏名 = 宛先.at("氏名", default: none)
    let 行 = ()
    if 会社名 != none { 行.push(会社名) }
    if 氏名 != none {
      行.push(((部署, 氏名).filter(x => x != none).join(h(1em)), [様]).join(h(1em)))
    } else if 部署 != none {
      行.push([#部署#h(1em)御中])
    } else if 行.len() > 0 {
      行.push([#行.pop()#h(1em)御中])
    }
    if 行.len() > 0 { block(行.join(linebreak())) }
  }

  {
    let 差出人 = if 差出人 in (none, ()) { (:) } else { 差出人 }
    let 項目 = (
      ("郵便番号", x => [〒#x]),
      ("住所", x => x),
      ("会社名", x => x),
      ("部署", x => x),
      ("氏名", x => x),
      ("電話", x => [電話番号：#x]),
      ("E-mail", x => [e-mail：#x]),
    )
    align(right, 項目
      .filter(((key, _)) => 差出人.at(key, default: none) != none)
      .map(((key, fmt)) => fmt(差出人.at(key)))
      .join(linebreak()))
  }

  if 件名 != none {
    block(above: 3em, width: 100%, align(center, text(size: 1.4em, 件名)))
  }

  // 頭語を本文の書き出しと同じ行に置くため、本文冒頭の空白・段落区切りを取り除く
  let 本文 = if body.func() == [].func() {
    let children = body.children
    while children.len() > 0 and children.first().func() in (parbreak, [ ].func()) {
      children = children.slice(1)
    }
    children.join()
  } else {
    body
  }
  block(above: 3em, below: 0.9em, if 頭語 != none [#頭語　#本文] else { 本文 })
  if 結語 != none { align(right, 結語) }

  if 同封物.len() > 0 {
    v(1em)
    align(center, [記])
    block(同封物.map(項目 => {
      let (名前, 数量) = if type(項目) == array { 項目 } else { (項目, none) }
      [・#名前]
      if 数量 != none { h(1em); [#数量] }
    }).join(linebreak()))
    align(right, [以上])
  }

  if 備考 != none {
    v(1em)
    block(width: 100%, stroke: 0.5pt, inset: 1em, [
      *備考* \
      #備考
    ])
  }
}
