#import "@preview/lovelace:0.3.0": *

#let get_element_numbering(counter, numbered: false) = {
  if numbered {
    counter.step()
    [#context counter.display("1")]
  }
}

#let exemple_counter = counter(<ex>)
#let prop_counter = counter(<prop>)
#let lemma_counter = counter(<lemma>)
#let remarque_counter = counter(<rem>)
#let algo_counter = counter(<algo>)

#let boxed(offset: none, it) = box(stroke: black+1pt, outset: 6pt, it)

#let doc(
  title: "Titre",
  subtitle : none,
  date: "1er janvier 1970",
  name: "name", body) = {

  set heading(numbering: (..nums) => {
    let lis = nums.pos()
    if (lis.len() == 1) {
      exemple_counter.update(0)
      lemma_counter.update(0)
      remarque_counter.update(0)
      numbering("I -", ..lis)
    } else if (lis.len() == 2) {
      numbering("1 )", lis.at(1))
    } else if (lis.len() == 3) {
      numbering("a )", lis.at(2))
    }
  })
  
  line(length: 100%)
  
  stack(
    dir: ltr,
    spacing: 1fr,
    text(12pt)[#name],
    text(12pt)[#date]
  )
  
  align(center)[
  #text(20pt, weight: "bold")[#title]\
  #text(16pt, weight: "bold")[#subtitle]
  ]
  line(length: 100%)
  body
}



#let title_box(
  title: "Title",
  subtitle: none,
  main_color,
  title_bg_color,
  title_color,
  outset,
  border
) = {
  [
    #context {
      let title = text(smallcaps(title), fill: title_color)
      let title_size = measure(title)
      let poly = polygon(
        fill: title_bg_color,
        stroke: main_color + border,
        (0pt - outset.left, 0pt - outset.top),
        (title_size.width + title_size.height + outset.right, 0pt - outset.top),
        (title_size.width + outset.right, title_size.height + outset.bottom),
        (0pt - outset.left, title_size.height + outset.bottom),
      )
        block(
          outset: outset,
          width: 100%,
        )[
          #place(
            top+left,
            poly
          )
        #title
        #h(13pt)
        #subtitle
        ]
    }
  ]
}

#let basic_box(
  breakable: true,
  title: "Title",
  subtitle: none,
  main_color: gray,
  title_bg_color: gray.lighten(30%),
  title_color: black,
  bg_color: gray.lighten(80%),
  border: 1.5pt,
  inset: (left : 5pt, right: 5pt, top: 5pt, bottom:5pt),
  body: none,
) = {
  [
    #context (
      block(
        breakable: breakable,
        fill: bg_color,
        stroke: main_color + border,
        inset : inset,
        [
          #title_box(title: title, subtitle: subtitle, main_color, title_bg_color, title_color, (left : 5pt, right: 5pt, top: 5pt, bottom:5pt), border)
          #body
        ]
      )
    )
  ]
}

#let def(title: none, body) = {
  basic_box(title: [Définition], subtitle: title,
  main_color: olive, title_bg_color: olive.lighten(30%), title_color: black, bg_color: olive.lighten(80%), body: body
  )
}

#let ex(title: none, body, numbered: false) = {
  basic_box(title: [Exemple #get_element_numbering(exemple_counter, numbered: numbered)], subtitle: title,
  main_color: black.lighten(15%), title_bg_color: black.lighten(50%), title_color: white, bg_color: black.lighten(80%), body:body
  )
}

#let prop(title: none, numbered: true, body) = {
  basic_box(title: [Proposition #get_element_numbering(prop_counter, numbered: numbered)], subtitle: title,
  main_color: maroon, title_bg_color: maroon.lighten(30%), title_color: white, bg_color: maroon.lighten(80%), body:body
  )
}

#let lemme(title: none, numbered: true, body,) = {
  basic_box(title: [Lemme #get_element_numbering(lemma_counter, numbered: numbered)], subtitle: title,
  main_color: maroon.lighten(15%), title_bg_color: maroon.lighten(50%), title_color: black, bg_color: maroon.lighten(90%), body:body
  )
}

#let preuve(title: none, body) = {
  basic_box(title: [Preuve], subtitle: title,
  main_color: maroon, title_bg_color: maroon.lighten(30%), title_color: white, bg_color: white, body:body
  )
}

#let rem(title: none, numbered: false, body) = {
  basic_box(title: [Remarque #get_element_numbering(remarque_counter, numbered: numbered)], subtitle: title,
  main_color: black.lighten(15%), title_bg_color: black.lighten(50%), title_color: white, bg_color: black.lighten(80%), body:body
  )
}

#let algo(title: none, numbered: true, name: "Title", params: (), body) = {
  basic_box(breakable: false, title: [Algorithme #get_element_numbering(algo_counter, numbered: numbered)], subtitle: title, inset: (left : 5pt, right: 5pt, top: 5pt, bottom:0pt),
  main_color: eastern, title_bg_color: eastern.lighten(30%), title_color: black, bg_color: white,
  body:
  [
    #pseudocode-list(booktabs: true, booktabs-stroke: eastern.lighten(30%) + 1pt,
    title: [#smallcaps(name) (#for param in params [#if (param != params.at(-1)) {[#param, ]} else  {param}])]
    )[#body]
  ]
  )
}



