#let minitoc(title: "Contents") = context [
  // the core logic for the minitoc
  #let outline_target = selector(
    heading
  ).after(here()).before(
    query(
      selector(heading).after(here())
    ).filter(
      it => it.level == 1
    ).first().location(),
    inclusive: false
  )

  // if empty, don't display minitoc
  #if query(outline_target).len() == 0 {return}

  #place(left, text(size: 13pt, weight: "semibold", title))
  #v(5mm)
  #show outline.entry.where(
    level: 2
  ): it => text(it, weight: "semibold")
  #line(length: 100%, stroke: 0.5pt)
  // experimentally chosen formatting style for minitoc contents
  #h(8%) #box(width: 83%, inset: -2mm,
    outline(
      title: none,
      target: outline_target
    )
  )
  #line(length: 100%, stroke: 0.5pt)
  #v(1cm)
]

/* `target` explanation

Select all headings after this location, but before the next chapter heading

Next chapter heading is computed by, again, selecting all headings after here,
then making a query to return all the values as an array of heading content

filter this array by only keeping the chapter headings

grab the location of the first one (since this will be the first after here)

back to the first "before the next" statement, exclude the endpoint,
since that's part of the next chapter

P.S. if you can simplify this unnecessarily complex selection, pls lmk
*/