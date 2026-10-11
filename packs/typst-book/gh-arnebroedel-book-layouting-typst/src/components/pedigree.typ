// components/pedigree.typ — Genetics pedigree (genogram) charts
//
// No suitable @preview package exists, so this is a CeTZ build with an
// explicit-coordinate API: the caller places individuals on a (col,row)
// grid and declares mating/child links. Squares = male, circles =
// female, filled = affected, diagonal stroke = deceased.

#import "../styles/theme.typ": fonts, palette, type-scale
#import "@preview/cetz:0.5.2": canvas, draw

// nodes: array of dicts (id, col, row, sex: "m"|"f", affected: bool,
//        label: content|none, deceased: bool)
// links: array of dicts
//   (type: "mate", a: id, b: id)
//   (type: "child", parents: (id, id), child: id)
#let pedigree(
  nodes,
  links,
  affected-color: palette.primary,
  size: 0.5,
  gap-x: 1.6,
  gap-y: 1.7,
) = {
  let posmap = (:)
  for nd in nodes {
    posmap.insert(nd.id, (nd.col * gap-x, -nd.row * gap-y))
  }
  canvas(length: 1cm, {
    // connecting lines (drawn under symbols)
    for lk in links {
      if lk.type == "mate" {
        draw.line(posmap.at(lk.a), posmap.at(lk.b), stroke: 0.8pt + palette.text-muted)
      } else if lk.type == "child" {
        let p1 = posmap.at(lk.parents.at(0))
        let p2 = posmap.at(lk.parents.at(1))
        let mid = ((p1.at(0) + p2.at(0)) / 2, (p1.at(1) + p2.at(1)) / 2)
        let c = posmap.at(lk.child)
        let bus-y = c.at(1) + size + 0.45
        draw.line(mid, (mid.at(0), bus-y), stroke: 0.8pt + palette.text-muted)
        draw.line((mid.at(0), bus-y), (c.at(0), bus-y), stroke: 0.8pt + palette.text-muted)
        draw.line((c.at(0), bus-y), (c.at(0), c.at(1) + size), stroke: 0.8pt + palette.text-muted)
      }
    }
    // symbols
    for nd in nodes {
      let p = posmap.at(nd.id)
      let fill = if nd.at("affected", default: false) { affected-color } else { white }
      let stroke = 1pt + palette.text-body
      if nd.sex == "m" {
        draw.rect((p.at(0) - size, p.at(1) - size), (p.at(0) + size, p.at(1) + size), fill: fill, stroke: stroke)
      } else {
        draw.circle(p, radius: size, fill: fill, stroke: stroke)
      }
      if nd.at("deceased", default: false) {
        draw.line(
          (p.at(0) - size * 1.35, p.at(1) - size * 1.35),
          (p.at(0) + size * 1.35, p.at(1) + size * 1.35),
          stroke: 0.8pt + palette.text-body,
        )
      }
      let lbl = nd.at("label", default: none)
      if lbl != none {
        draw.content((p.at(0), p.at(1) - size - 0.08), anchor: "north", text(size: type-scale.micro, fill: palette.text-muted, lbl))
      }
    }
  })
}
