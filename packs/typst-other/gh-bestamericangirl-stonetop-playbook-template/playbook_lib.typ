// Simple line starting with checkbox:
#import "stonetop_style.typ": style_options

#let check(body, hspace: 0.75em, checked: false, count: 1, inline: false) = [
  #show math.equation: set text(size: 12pt)
  #box[
    #for i in range(count) {
      if i > 0 {" "}
        box(width: 6pt, height: 6pt, radius: (rest: 1.5pt), stroke: 0.5pt)[#if checked {
        place(center + horizon, text(size: 12pt)[$#sym.checkmark.heavy$], dy: -2pt, dx: 1pt)
      }]
    }
    #if not inline {h(hspace)}
    #body
  ]
]

#let new_move(body: "", name: "", checked: false, num_checkboxes: 1, stock: 0, requires: "", children: none) = (
    name: name,
    checked: checked,
    num_checkboxes: num_checkboxes,
    stock: stock,
    requires: requires,
    children: children,
    body: body,
  )

#let inv = $diamond.stroked$

#let invs(n) = for i in range(n) {inv}

#let uses(count) = $#(for i in range(count) {
  sym.circle.stroked
})$

#let tags(..args) = [(_#(args.pos().join(", "))_)]

#let checklist(body, checked: false, condense: false) = [
  #set list(marker: check(hspace: 0em, checked: checked)[])
  #if not condense {v(0.5em)}
  #if body.fields().at("children", default: ()).len() == 0 { return }
  #for child in body.fields().children {
    block(breakable: false, spacing: 0.25em)[#child]
  }
]

#let movelist(body) = [
  #set list(
    marker: "➤"
  )
  #pad(left: 1em)[#body]
]

#let choose_one_each_line(..option_lines) = for option_line in option_lines.pos() {
  box(width: 120%)[
    #for option in option_line {
      check(option + " ", hspace: 0em)
    }
  ]
  linebreak()
}

// Two column checklist for checklists with very short items
#let two_columns_checklist(body, condense: false, padX: 0pt, gutter: 1em) = columns(2, gutter: gutter)[
  #let items = body.fields().children
  #let first_half = int((items.len() + 1) / 2)
  #pad(x: padX)[
	  #checklist(condense: condense)[#items.slice(0, first_half).join()]
	  #colbreak()
	  #checklist(condense: condense)[#items.slice(first_half).join()]
  ]
]

// To give space for players to write
#let blank = v(1.1em)
#let fill_in_the_blank = box(width: 1fr)[#line(length: 100%, stroke: (thickness: 0.2pt, dash: "densely-dotted"))]
#let fill_in_the_blanks(n) = for i in range(n) {
  set text(size: 14pt)
  [~#fill_in_the_blank\ ]
}

// Unique grunge based on position of element on the page
#let grunge = context {
  place(left + top, [#image("img/grunged.svg", height: page.width, width: page.height)], dx: -here().position().at("x"), dy: -here().position().at("y"))
}

// Heading with normal text after it
#let choose_heading(body, desc: "(Choose 1)") = context[
  #let body-style = (font: text.font, size: text.size, weight: text.weight)
  = #body #text(..body-style)[#desc]
]

#let thin_line = line(length: 100%, stroke: 0.4pt)
#let dotted_line = line(length: 100%, stroke: (thickness: 0.4pt, dash: "densely-dotted"))

// Line above, checkbox, heading, and body
#let checkblock(body, checked: false, count: 1, condense: false, is_child: false, num_uses: 0, skip_line: false) = block(breakable: false)[
  #show heading.where(level: 2): it => {
    set text(..style_options.heading2)
    check([#upper[#it.body] #h(1fr) #if num_uses > 0 {
      place(bottom+right)[#uses(num_uses)]
    }], checked: checked, count: count)
    if not condense {parbreak()} else {linebreak()}
  }
  #let child_aware_line = if not is_child {thin_line} else {line(length: 100%, stroke: (thickness: 0.4pt, dash: "densely-dotted"))}
  #if not skip_line {
    context {
      let hydaelyn = query(selector(<hydaelyn>).before(here())).last(default: none)
      let line_color = black

      if hydaelyn != none and here().position().y - hydaelyn.location().position().y < 12pt {
        line_color = white
      }
      set line(stroke: line_color)
      child_aware_line
    }
  }
  #body
]

#let format_move(move, is_child: false, skip_line: false) = block(breakable: false, inset: if is_child {(left: 1em)} else {0em})[
  #checkblock(checked: move.checked, count: move.num_checkboxes, condense: true, is_child: is_child, num_uses: move.stock, skip_line: skip_line)[
    == #move.name
  ]<move>
  #if move.requires != "" {[(Requires #move.requires)#linebreak()]}
  #move.body
  #if move.children != none {
    for child in move.children {
      format_move(child, is_child: true)
    }
  }
]

// Big line with grunge
#let big_line(vspace: 0em) = [#block(width: 100%, height: 0.25em, clip: true, fill: black, grunge) #v(vspace)]

#let medium_line(vspace: 0em) = [#block(width: 100%, height: 0.05em, clip: true, fill: black, grunge) #v(vspace)]

// Same but it stretches across the sheet
#let biggest_line(vspace: 0em, multiplier: 1, marginY: 0.25in) = context[#block(width: (page.height - marginY * 3) * multiplier, height: 0.25em, clip: true, fill: black, grunge) #v(vspace)]

// Better for something you want in both spread and booklet form
#let biggest_line_left(vspace: 0em, marginY: 0.25in) = context[
  #block(width: (page.height - marginY * 3) / 2, height: 0.25em, clip: true, fill: black, grunge) #v(vspace)
]
#let biggest_line_right(vspace: 0em, marginY: 0.25in) = context[
  #set align(right)
  #block(width: (page.height - marginY * 3) / 2, height: 0.25em, clip: true, fill: black, grunge) #v(vspace)
]

#let grungebox(body, ..args) = block(outset: 0.5em, clip: true, box(..args.named())[
  #grunge

  #body
])

#let grungetext(body) = block(outset: 1em, clip: true)[
  #body
  #grunge
]

// end is inclusive
#let range_checklist(start, end) = checklist[
  #for i in range(start, end + 1) {
    [- #if i >= 0 {"+" + str(i)} else {i}]
}]

// For laying stuff across pages
#let edge_and_count_aware(idx, lab, body, stop_state: none, also_add_label: true, marginX: 0.25in) = context {
  let count = counter(label(lab)).get().at(0)
  let didnt_do_yet = idx >= count
  let wont_go_off_edge = not here().position().at("y") + measure(body).height > (page.width - marginX)
  let stopped = stop_state != none and stop_state.get()
  if didnt_do_yet and not stopped {
    if wont_go_off_edge {
      [#body #if also_add_label {label(lab)}]
    } else {
      if stop_state != none {stop_state.update(true)}
    }
  }
}

#let questions(body) = [
  #set list(
    marker: box(height: 0.7em)[#align(horizon)[#image("img/question.svg")]]
  )
  #body
]

#let circle_list(body) = [
  #set list(
    marker: box(height: 0.7em)[#align(horizon)[#sym.circle.stroked.big]]
  )
  #body
]

// Roll Tables
#let roll_table(die_roll, table_name, ..args) = table(
  columns: (auto, 1fr),
  column-gutter: 0.5em,
  align: horizon,
  stroke: none,
  table.header(
    [*#die_roll*], [#set text(font: style_options.font_heading, size: 0.7em); #upper([*#table_name*])],
  ),
  table.hline(stroke: (thickness: 0.2pt, dash: "densely-dotted")),
  ..args,
)

/** Character Playbook Specific Stuff Below **/
#let statbox(body, above: "", below: "", ..args) = grungebox(radius: (rest: 8pt), stroke: (black + 2pt), width: 100%, height: 5em, inset: 5pt, ..args)[
  #set text(weight: "bold", size: 7.5pt)
  #grunge
  // #block(height: 110%, clip: true, vgrunge)
  #if above != "" {place(top + center, box(fill: white, outset: (left: 1.5pt, right: 1.5pt))[#above], dy: -1em)}

  #align(center + horizon)[#set text(font: style_options.font_handwriting, size: 18pt); #body]

  #if below != "" {place(bottom + center, box(fill: white, outset: 1.5pt)[#below], dy: 1em)}
]

#let debility(body) = [
  #show math.equation: set text(size: 11pt)
  $ underbrace(#box(width: 100%, height: 1em)[#place(bottom + center, circle(radius: 2pt, fill: white, stroke: black), dy: 4pt)], italic(body)) $
]

#let show_footnote(page, footnotes) = {
  if page in footnotes {
    v(1fr)
    text(size: 8pt)[
      #footnotes.at(page)
    ]
  }
}

#let make_playbook(
  info: none,
  stats: none,
  backgrounds: none,
  instincts: none,
  appearances: none,
  origins_and_names: none,
  default_special_possessions: none,
  special_possessions: none,
  moves: none,
  character_question_sections: none,
  introductions: none,
  footnotes: (),
  marginX: 0.25in,
  marginY: 0.25in,
  playbook_advice: none,
) = {
  import "@preview/bookletic:0.3.2"
  let page1 = [
    /* Headers */
    #grid(
      columns: (6.2fr, 1fr),
      rows: (auto, auto),
      row-gutter: 1em,
      align: top,
      gutter: (0pt),
      block(clip: true, outset: 1em, [#title[#info.title] #grunge]),
      grid.cell(rowspan: 2, block(clip: true, [#image(info.image_path, width: 100%,) #grunge])),
      text[_ #info.description _],
    )

    #big_line()

    #grid(
      columns: (1fr, 1fr),
      column-gutter: 1em,
      [
        /* Backgrounds */
        #choose_heading[Background]
        #for background in backgrounds {
          checkblock(background, condense: true)
        }
      ],
      /* Instincts */
      [
        #choose_heading[Instinct]
        #for instinct in instincts {
          checkblock(instinct, condense: true)
        }

        #big_line(vspace: -1em)
        = Appearance
        Choose 1 on each line, or make something up:

        #choose_one_each_line(..appearances)

        #big_line(vspace: -1em)
        = Place of origin and name
        #if "place_of_origin" in info { info.place_of_origin } else [
         #info.steading_name is your home, or close enough, but where are you (or your family) from originally? Pick 1 and a name to match (or make up something similar).
        ]

        #checklist[#origins_and_names]

        #block(clip: true, outset: 0.5em, box(radius: (rest: 4pt), stroke: (black + 2pt), width: 100%, inset: 5pt)[
          #grunge
          I am\
          called...
        ])
      ]
    )
    #show_footnote("1", footnotes)
  ]

  let stop_state = state("stop", false)

  let format_moves() = {
    for (idx, move) in moves.enumerate() {
      context {
        //let skip_line = not is_higher_than_previous_label("move", here())
        edge_and_count_aware(idx, "root_move", [#format_move(move, skip_line: false)], stop_state: stop_state, marginX: marginX)
      }
    }
    stop_state.update(false)
  }

  let page2 = [
    #big_line(vspace: -1em)
    #choose_heading(desc: [Assign these scores: #info.stat_scores. When a debility is marked, you roll with disadvantage.])[Stats]

    #grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      rows: (auto, auto),
      column-gutter: 0.5em,
      ..stats.pairs().map(((stat, st)) => statbox(above: stat, below: st)[]),
      grid.cell(colspan: 2)[#debility("weakened")],
      grid.cell(colspan: 2)[#debility("dazed")],
      grid.cell(colspan: 2)[#debility("miserable")]
    )
    #grid(
      columns: (1fr, 2fr, 1fr, 2fr, 1fr),
      column-gutter: 0.5em,
      statbox(below: "Damage")[#info.damage_die],
      statbox(below: [HP (max #info.max_hp)])[],
      statbox(below: "Armor")[],
      statbox(below: "XP")[],
      statbox(below: "Level")[]
    )

    #v(1em)
    #biggest_line(vspace: -1em, marginY: marginY)

    #choose_heading(desc: [You start with #info.starting_moves.])[Moves]
    #thin_line <hydaelyn>
    #columns(2, gutter: 1em)[
      #set text(size: 8pt)
      #format_moves()
    ]
    #show_footnote("2", footnotes)
  ]

  let page3 = [
    #set text(size: 8pt)
    #stack(dir: ttb,
    block(height: 25.6%)[#big_line(vspace: -1em)
    #choose_heading(desc: [(#info.num_special_possessions)])[Special Possessions]

    #thin_line
    /* Special Possessions */
    #columns(2, gutter: 1em)[
      #if default_special_possessions != none {
        checklist(default_special_possessions, checked: true, condense: true)
      }
      #checklist(special_possessions, condense: true)
    ]
    ],
    v(1em),
    columns(2, gutter: 1em)[
      #format_moves()
    ])
    #show_footnote("3", footnotes)
  ]

  let intro_step(num, introductions: introductions, body) = block()[
    #if num in introductions {
      body = introductions.at(num)
    }
    #if body != none [
      #place(top + left, thin_line)
      #stack(dir: ltr, spacing: 0.5em,
        box[ #image("img/intro_bg.svg") #place(top + center, text(fill: white)[= #num], dy: 2pt)],
        pad(top: 0.75em, body)
      )
    ]
  ]

  let page4 = [
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 1em,
      [
        #for section in character_question_sections {
          big_line(vspace: -1em)
          section
        }
      ],
      [
        #set block(spacing: 0.75em)
        #big_line(vspace: -1em)
        = Introductions
        Wait here for everyone else. When everyone's ready, take turns introducing your characters. When *_someone reveals something and you want to know more_*, ask them about it. When *_someone asks you a question_*, answer it truthfully.

        #intro_step("1")[On your first turn, *introduce yourself* by name, pronouns, background, origin, and appearance.]

        #intro_step("2")[On your second turn, *describe your special possessions* and how you contribute to the village (beyond working the fields).]
        #intro_step("3")[]
        #intro_step("4")[]
        #intro_step("5")[Go around again. Answer another question from 4, or pass. When everyone has passed, go on.]
        #intro_step("6")[]
        #intro_step("7")[Go around again. Ask another question from 6, or pass. When everyone has passed, go on.]
        #intro_step("8")[
          Add your home to the steading playbook.\
          When everyone is done, let spring break forth!
        ]
      ]
    )
    #show_footnote("4", footnotes)
  ]

  let contents = (
    page1,
    page2,
    page3,
    page4,
  )

  set page(flipped: true, paper: "us-letter", margin: (top: marginY, bottom: marginY, left: marginX, right: marginX))
  bookletic.sig(
    page-margin-binding: 0.25in,
    page-border: none,
    draft: false,
    pad-content: 10pt,
    contents: contents,
  )
  if playbook_advice != none {

    show heading.where(level: 2): it => {
        set text(..style_options.heading2)
        [#it.body]
    }
    show: questions

    columns(4, gutter: 2 * marginX)[

      = GM questions for #info.title
      #intro_step("1", introductions: ())[
        #playbook_advice.at("1", default: none)
        #v(0.5em)
        #for background in playbook_advice.backgrounds {
          block(breakable: false)[
            #thin_line
            #background
          ]
        }
      ]
      #intro_step("2", introductions: playbook_advice)[]
      #intro_step("3", introductions: playbook_advice)[]
      #intro_step("4", introductions: playbook_advice)[]
      #intro_step("5", introductions: playbook_advice)[]
      #intro_step("6", introductions: playbook_advice)[]
      #intro_step("7", introductions: playbook_advice)[]
      #intro_step("8", introductions: playbook_advice)[]
      #if "moves" in playbook_advice [
        #colbreak(weak: true)
        #set list(
          marker: box(height: 0.7em)[#align(horizon)[#image("img/swirl.svg")]]
        )

        = Advice for moves
        #thin_line

        #playbook_advice.moves
      ]
    ]

  }
}

#let make_unbreakable_blocks(..args) = {
  for item in args.pos() [
    #block(breakable: false)[#item]
  ]
}

#let make_minor_arcanum(front: true, name: lorem(3), arcanum_tags: [#inv, magical], decoration: sym.dot.op, img: none, body) = [
  #set par(leading: 0.65em, spacing: 0.95em, justify: false)
  #set block(spacing: 1em)
  #set text(size: 10pt)

  #show heading.where(level: 1): set align(center)
  #show heading.where(level: 1): set text(size: 14pt)

  #let decoration = [#set text(font: "Noto Emoji", size: 4pt, baseline: -0.25em); #decoration]

  #set par(leading: 0.55em, spacing: 0.9em, justify: false)
  #set block(spacing: 1em)


  #place(center+horizon, image("arcana/minor_arcana_frame.png", width: 100%))
  #place(top+center,
    box(fill: white, outset: 0.5em)[#set text(size: 7pt, font: "Avara")
    #decoration MINOR ARCANUM #decoration
    ],
    dy: 0.5em,
  )

  #place(bottom+center, circle(fill: white, radius: 1em, stroke: black+0.5pt)[])
  #place(bottom+center, [#set text(size: 5pt, font: "Avara"); #if front {[FRONT]} else {[BACK]}], dy: -2.5em)

  #block(width: 100%, inset: (top: 3em, rest: 2.5em))[
    #align(center)[#pad(x: 0.3em)[
        = #name
        #if not arcanum_tags == none {[_#(arcanum_tags)_]}
      ]
    ]

    #if not img == none {align(center)[#image(img, width: 100%)]}

    #body
  ]
]

#let make_item(icon: "icons/arcana.png", name: [Lorem], item_tags: [#inv, magical], body) = block(breakable: false)[
  #stack(dir: ltr, spacing: 0.5em, image(icon, height: 2.5em), [#text(font: "Avara")[#name]\
   _#(item_tags)_])
  #body
]

#let make_statblock(HP: none, armor: none, damage: none, instinct: none, special_qualities: none) = [
  #if HP != none [*HP* #HP\;] #if armor != none [*Armor* #armor] #if HP != none or armor != none [\ ]
  #if damage != none [*Damage* #damage\ ]
  #if special_qualities != none [*Special Qualities* #special_qualities\ ]
  #if instinct != none [*Instinct* #instinct\ ]
]

#let make_npc(body, icon: "icons/beast.png", name: "Jimothy", img: none, tags: [Solitary, group, horde]) = [
  #big_line()

  #if img != none [
    #align(center)[#img]

    #thin_line
  ]
  #make_item(icon: icon, name: name, item_tags: tags)[
    #body
  ]
]
