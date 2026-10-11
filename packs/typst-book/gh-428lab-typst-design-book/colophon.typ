#let db = yaml("book.yaml")
#let of-role = (role) => {
  db.contributers.filter(it => it.roles.contains(role)).map(it => it.name).dedup().join(" ／ ")
}

#let str-to-date(date-str) = {
  let parts = date-str.split("-")
  let year = int(parts.at(0))
  let month = int(parts.at(1))
  let day = int(parts.at(2))
  datetime(year: year, month: month, day: day)
}

#let create_colophon(ebook) = {
  set page(numbering: none, header: none, footer: none)
  v(8%)
  block(
    inset: 1em,
    stroke: 3pt,
  )[
    #grid(
      columns: (auto, 1fr),
      image("/other/QR_605575.png", height: 8em),
      align(bottom)[
        #pad(
          left: 2em,
          bottom: 2em,
          [
            #text(size: 1.7em, weight: 700, "四谷ラボ BOOKS") \
            https://books.428lab.net
          ]
        )
      ]
    )
    #line(length: 100%)
    #text(size: 0.9em, "書籍掲載のリンクについては、上記のQRコード、またはURLよりアクセスできるWebページにまとめて掲載しています。本誌とあわせてご覧ください。")
  ]
  v(1em)
  // text(size: 2.5em, [#set par(leading: 0.5em);*#title*], )
  if ebook {
    stack(dir: ltr, spacing: 0.5em, [
      #image("/other/hello_Nostr_Yo_Bluesky_logo_1c_mono.png", width: 80%)
    ], align(bottom, )[
      #text("[電子版]", size: 1.2em, weight: 700)
      #v(1.5em)
    ])
  } else {
    image("/other/hello_Nostr_Yo_Bluesky_logo_1c_mono.png", width: 80%)
  }
  set par(first-line-indent: 0pt)
  if ebook {
    text([#str-to-date(db.date).display("[year]年[month padding:none]月[day padding:none]日") 電子版 発行])
  } else {
    text([#str-to-date(db.date).display("[year]年[month padding:none]月[day padding:none]日") 発行])
  }
  v(1em)
  line(length: 100%)
  v(1em)
  text(size: 0.9em, [
    #text(weight: 700, "ライター") \
    Shino3（しのさん） ／ darashi
    #v(0.3em)
    #text(weight: 700, "イラストレーター") \
    #of-role("イラストレーター") \
    #v(0.3em)
    #text(weight: 700, "デザイン") \
    よそいち \
    #v(0.3em)
    #text(weight: 700, "DTP") \
    #of-role("DTP") \
    #v(0.3em)
    #text(weight: 700, "発行") \
    四谷ラボ https://428lab.net \
    #v(0.3em)
    #text(weight: 700, "印刷") \
    有限会社ねこのしっぽ \
  ])
}
