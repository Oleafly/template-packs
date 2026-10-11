#import "emo.typ": setup-emo
#show: setup-emo

#let contributor-box = (person) => {
  let avatar = person.at("avatar", default: none)
  let avatar-image = if avatar != none {
    align(center, image("contributor-avatars/" + avatar))
  } else {
    none
  }

  let roles = person.at("roles", default: ()).map(role => {
    text(size: 0.8em, weight: 500, role)
  })

  let links = person.at("links", default: ())

  box(
    width: 100%,
    height: 100%,
    [
      // アバターと役割、名前
      #grid(
        columns: (auto, 1fr),
        gutter: 6pt,
        align: bottom,
        [
          #box(stroke: .25pt, radius: 4pt, height: 32pt, width: 32pt, clip: true, avatar-image)
        ],
        [
          #roles.join(", ")
          #block(text(size: 1.1em, weight: 700, person.name))
          #v(3pt)
        ],
      )

      // 自己紹介文
      #v(-0.5em)
      #line(stroke: 0.5pt, length: 100%)
      #text(size: 0.75em, person.at("bio", default: ""))

      // リンク
      #text(7pt,
        for l in links {
          [- \[#l.at(0)\] #l.at(1)]
        }
      )
    ]
  )
}

#let contributors = (db) => {
  grid(
    columns: 2,
    gutter: 1em,
    rows: 11em,

    ..db.map(it => contributor-box(it))
  )
}

#pagebreak()
= 関係者一覧
#v(1.5em)
#contributors(yaml("contributors.yaml"))