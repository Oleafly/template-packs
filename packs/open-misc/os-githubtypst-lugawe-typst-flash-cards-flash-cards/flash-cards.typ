#let counter-card-number = counter("card-number")
#let state-card-front = state("card-front")
#let state-card-back = state("card-back")
#let state-card-info-left = state("card-info-left")
#let state-card-info-right = state("card-info-right")
#let state-card-scale = state("card-scale")

#let card(front, back, info-left: [], info-right: [], scale: false) = [
  #counter-card-number.step()
  #state-card-front.update(front)
  #state-card-back.update(back)
  #state-card-info-left.update(info-left)
  #state-card-info-right.update(info-right)
  #state-card-scale.update(scale)
  <card>
]

#let create-card-front(
  group,
  rel-number,
  card-content,
  info-left,
  info-right,
  scale,
  width,
  height,
) = box(
  width: width,
  height: height,
  clip: true,
  inset: 1em,
  [
    #place(top + left, [
      #group
      <card-group>
    ])
    #place(top + right, [
      #rel-number
      <card-rel-number>
    ])
    #place(horizon + center, [
      #card-content
      <card-content-front>
    ])
    #place(bottom + left, [
      #info-left
      <card-info-left>
    ])
    #place(bottom + right, [
      #info-right
      <card-info-right>
    ])
  ],
)

#let create-card-back(
  group,
  rel-number,
  card-content,
  info-left,
  info-right,
  scale,
  width,
  height,
) = box(
  width: width,
  height: height,
  clip: true,
  inset: 1em,
  [
    #place(top + right, [
      #rel-number
      <card-rel-number>
    ])
    #place(horizon + center, [
      #card-content
      <card-content-back>
    ])
  ],
)

#let create-empty(width, height) = box(
  width: width,
  height: height,
  clip: true,
  inset: 1em,
  [],
)

#let create-grid(card-fronts, card-backs, cell-count, columns, rows) = {
  let chunked-card-fronts = card-fronts.chunks(cell-count)
  let chunked-card-backs = card-backs
    .chunks(cell-count)
    .map(e => e.chunks(columns).map(e2 => e2.rev()))

  let items = chunked-card-fronts.zip(chunked-card-backs).flatten()

  grid(
    columns: columns,
    rows: rows,
    stroke: (
      paint: luma(90%),
      dash: "dashed",
    ),
    ..items
  )
}

#let cards-design(body) = {
  show <card-group>: it => text(fill: luma(30%), smallcaps(it))
  show <card-rel-number>: it => text(fill: luma(30%), it)
  show <card-content-front>: it => it
  show <card-content-back>: it => it
  show <card-info-left>: it => text(fill: luma(30%), it)
  show <card-info-right>: it => text(fill: luma(30%), it)
  body
}

#let cards(columns: 2, rows: 4, body) = {
  assert(columns > 0, message: "columns")
  assert(rows > 0, message: "rows")

  set page(margin: 0em)

  /*set heading(bookmarked: false, outlined: false)
  show heading: it => []*/

  context {
    let dimensions = (
      columns: columns,
      rows: rows,
      card-width: page.width / columns,
      card-height: page.height / rows,
    )

    let card-fronts = ()
    let card-backs = ()

    let cards = query(<card>)
    for card in cards {
      let l = card.location()

      let headings = query(selector(heading).before(l))
      let group = if (headings.len() > 0) {
        headings.last().body
      } else {
        ""
      }

      let number = counter-card-number.at(l).first()
      let total-number = counter-card-number.final().first()
      let front = state-card-front.at(l)
      let back = state-card-back.at(l)
      let info-left = state-card-info-left.at(l)
      let info-right = state-card-info-right.at(l)
      let scale = state-card-scale.at(l)

      card-fronts.push(create-card-front(
        group,
        [#number/#total-number],
        front,
        info-left,
        info-right,
        scale,
        dimensions.card-width,
        dimensions.card-height,
      ))

      card-backs.push(create-card-back(
        group,
        [#number/#total-number],
        back,
        info-left,
        info-right,
        scale,
        dimensions.card-width,
        dimensions.card-height,
      ))
    }

    let cell-count = dimensions.columns * dimensions.rows

    let remainder = calc.rem(card-fronts.len(), cell-count)
    if (remainder != 0) {
      for i in range(cell-count - remainder) {
        card-fronts.push(create-empty(
          dimensions.card-width,
          dimensions.card-height,
        ))
        card-backs.push(create-empty(
          dimensions.card-width,
          dimensions.card-height,
        ))
      }
    }

    create-grid(
      card-fronts,
      card-backs,
      cell-count,
      dimensions.columns,
      dimensions.rows,
    )
  }

  body
}
