#import "theme.typ": THEME, theme

#let size_tag_list = ("tiny", "small", "medium", "large", "huge", "gargantuan")
#let alignement_tag_list = ("lg", "ng", "cg", "ln", "n", "cn", "le", "ne", "ce")
#let rarity_tag_list = ("uncommon", "rare", "unique")

#let a = box(image("imgs/single_action.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let aa = box(image("imgs/double_action.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let aaa = box(image("imgs/triple_action.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let r = box(image("imgs/reaction.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let f = box(image("imgs/free_action.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let L = 0.1
#let null = [---]

#let Proficiencies = (
  untrained: "Untrained",
  trained: "Trained",
  expert: "Expert",
  master: "Master",
  legendary: "Legendary",
  mythic: "Mythic",
)

#let Damages = (
  piercing: "Piercing",
  slashing: "Slashing",
  bludgeoning: "Bludgeoning",
  force: "Force",
  acid: "Acid",
  cold: "Cold",
  electricity: "Electricity",
  fire: "Fire",
  sonic: "Sonic",
  spirit: "Spirit",
  void: "Void",
  vitality: "Vitality",
  mental: "Mental",
  poison: "Poison",
  bleed: "Bleed",
  precision: "Precision",
)

#let Saves = (
  fortitude: "Fortitude",
  reflex: "Reflex",
  will: "Will",
)

#let Skills = (
  acrobatics: "Acrobatics",
  arcana: "Arcana",
  athletics: "Athletics",
  crafting: "Crafting",
  deception: "Deception",
  diplomacy: "Diplomacy",
  intimidation: "Intimidation",
  lore: "Lore",
  medicine: "Medicine",
  nature: "Nature",
  occultism: "Occultism",
  performance: "Performance",
  religion: "Religion",
  society: "Society",
  stealth: "Stealth",
  survival: "Survival",
  thievery: "Thievery",
)

#let Results = (
  critical_success: "Critical Success",
  success: "Success",
  failure: "Failure",
  critical_failure: "Critical Failure",
)

#let hr(fill: black) = {
  set block(above: 5pt, below: 5pt)
  line(length: 100%, stroke: fill)
}
#let vr(fill: black) = {
  line(start: (50%, 0%), end: (50%, 100%), stroke: fill)
}
#let floating(..body) = {
  place(auto, float: true, ..body)
}
#let full(..body) = place(auto, float: true, scope: "parent", block(width: 100%, ..body))
#let col(body) = columns(2, body)
#let exists(var) = {
  var != none and var != "" and var != [] and var != () and var != (:) and not (type(var) == str and var.trim() == "")
}
#let mark(h) = {
  set heading(outlined: true)
  h
}

#let split_args(..args, f: a => a) = {
  args
    .pos()
    .flatten()
    .filter(e => type(e) == str)
    .map(s => s.split(",").filter(it => it != none and it != ""))
    .flatten()
    .map(s => f(s.trim()))
}

#let straight(body) = {
  set par(hanging-indent: 0em)
  body
}
#let hang(body) = {
  set par(hanging-indent: 1em)
  body
}

// create the colored box around the tag ant typeset the name of the tag
#let print_trait(name, theme: THEME) = {
  if name == none {
    return none
  }
  set text(
    fill: theme.tag_text_color,
    font: theme.block_heading_font,
    weight: "bold",
    size: theme.trait_font_size,
  )
  let tg = lower(name)
  let fill = if tg == "uncommon" { theme.uncommon_tag_color } else if tg == "rare" { theme.rare_tag_color } else if (
    tg == "unique"
  ) { theme.unique_tag_color } else if tg in size_tag_list { theme.size_tag_color } else if tg in alignement_tag_list {
    theme.alignement_tag_color
  } else { theme.tag_color }
  box(rect(
    height: auto,
    width: auto,
    fill: fill,
    stroke: (
      x: 3pt + theme.tag_border_color,
      y: 2pt + theme.tag_border_color,
    ),
    inset: (
      x: 0% + 6pt,
      y: 0% + 3pt,
    ),
  )[#tg])
}
#let trait_sorting_key(name) = {
  if name in rarity_tag_list {
    0
  } else if name in size_tag_list {
    1
  } else if name in alignement_tag_list {
    2
  } else {
    3
  }
}
#let split_traits(..strings) = {
  split_args(..strings, f: lower)
}
#let clean_list(list) = {
  let new_list = ()
  for it in list {
    let it2 = lower(it)
    if it2 not in new_list {
      new_list.push(it2)
    }
  }
  return new_list
}
// show a line of tags from a comma separated string or list of string
#let print_traits(..args, theme: THEME) = {
  let str_array = split_traits(..args).sorted(key: trait_sorting_key)

  str_array.map(s => print_trait(s, theme: theme)).join()
}

#let itembox(
  name,
  body,
  actions: none,
  kind: none,
  level: none,
  traits: none,
  size: 100%,
  breakable: false,
  theme: THEME,
  hanging: false,
  url: none,
) = block(
  width: size,
  inset: (y: 0.3em),
  above: 1.2em,
  breakable: breakable,
  // heading
  {
    set par(
      justify: true,
      spacing: 0.7em,
      //first-line-indent: 1em,
    )
    show ":a:": a
    show ":aa:": aa
    show ":aaa:": aaa
    show ":r:": r
    show ":f:": f

    block(
      below: 0.5em,
      {
        show heading: it => {
          set text(
            font: theme.block_heading_font,
            size: theme.bloc_heading_font_size,
            fill: black,
            bottom-edge: 0.3em,
            top-edge: 0.3em,
          )
          set align(bottom)
          it
        }
        grid(
          columns: (auto, 1fr, auto),
          rows: (auto,),
          heading(
            depth: 1,
            bookmarked: false,
            outlined: false,
          )[#if exists(url) { link(url, name) } else { name } #actions],
          [],
          heading(
            depth: 1,
            bookmarked: false,
            outlined: false,
          )[#kind #level],
        )
        hr()
        print_traits(traits, theme: theme)
      },
      breakable: false,
    )
    set text(font: theme.block_font, size: theme.block_font_size)
    set terms(tight: true)
    //set block(spacing: 0em)
    //set par(spacing: 0.6em)
    if hanging { hang(body) } else { straight(body) }
  },
)

#let feature(name, right, theme: THEME, actions: none) = {
  set par(justify: true)
  block(
    below: 0.5em,
    {
      show heading: it => {
        set text(
          font: theme.block_heading_font,
          size: theme.bloc_heading_font_size,
          fill: black,
          bottom-edge: 0.3em,
          top-edge: 0.3em,
        )
        set align(bottom)
        it
      }
      grid(
        columns: (auto, 1fr, auto),
        rows: (auto,),
        heading(
          depth: 1,
          bookmarked: false,
          outlined: false,
        )[#name #actions],
        [],
        heading(depth: 1, bookmarked: false, outlined: false, [#right]),
      )
    },
    breakable: false,
  )
}

#let notebox(body, size: 100%, theme: THEME) = block(
  width: size,
  fill: theme.notebox_background_color,
  inset: 12pt,
  breakable: false,
  stroke: theme.accent,
  {
    set heading(bookmarked: false, outlined: false, offset: 0)
    show heading: head => {
      set text(font: theme.small_heading_font, weight: "black", fill: black)
      align(center)[#{ if head.level == 1 { upper(head) } else { head } }]
    }
    set text(font: theme.block_font, size: theme.block_font_size)
    set align(left)
    body
  },
)

#let infobox(..body, size: 100%, theme: THEME) = block(
  width: size,
  fill: theme.infobox_color,
  inset: 12pt,
  breakable: false,
  {
    set heading(bookmarked: false, outlined: false, offset: 0)
    set text(fill: white)
    show heading: head => {
      set text(font: theme.small_heading_font, weight: "black", fill: white)
      align(left)[#{ if head.level == 1 { upper(head) } else { head } }]
    }
    show heading.where(level: 2): set text(top-edge: 0pt)
    set text(font: theme.block_font, size: theme.block_font_size)
    set align(left)
    let cols = ()
    let cont = ()
    let l = body.pos().len()
    for (i, c) in body.pos().enumerate() {
      cols.push(1fr)
      cont.push(c)
      if i != l - 1 {
        cont.push(grid.vline(stroke: 2pt + white))
      }
    }
    grid(columns: cols, column-gutter: 0.8em, inset: 0.8em, ..cont)
  },
)

#let rulebox(body, size: 100%, theme: THEME) = block(
  width: size,
  fill: theme.rulebox_background_color,
  inset: 12pt,
  breakable: false,
  {
    set heading(bookmarked: false, outlined: false, offset: 0)
    set text(fill: black)
    show heading: head => {
      set text(font: theme.small_heading_font, weight: "black", fill: black)
      align(center)[#head]
    }
    show heading.where(level: 2): set text(top-edge: 0pt)
    set text(font: theme.block_font, size: theme.block_font_size)
    set align(left)
    body
  },
)

#let banner(body, theme: THEME /*page_break: true*/) = {
  //if page_break {pagebreak()}
  place(top, float: true, scope: "parent", block(
    width: 100%,
    fill: theme.notebox_background_color,
    inset: 12pt,
    breakable: false,
    stroke: (bottom: theme.accent + 2pt),
    {
      set heading(offset: 0)
      //show heading.where(level: 3).or(heading.where(level: 4)): set heading(outlined: false)
      set text(
        font: theme.main_text_font,
        style: "italic",
        weight: "black",
        fill: theme.first_level_heading_color,
        size: theme.title_text_font_size,
      )
      show heading: head => {
        set text(fill: theme.first_level_heading_color, font: theme.big_heading_font)
        set block(spacing: 4pt)
        align(if calc.odd(head.level) { center } else { left })[#head]
      }
      show heading.where(level: 1): it => {
        set text(size: theme.title_font_size)
        it
      }
      show heading.where(level: 1, outlined: false): it => {
        heading(depth: 1, outlined: true, it)
      }
      show heading.where(level: 2): it => {
        set text(size: theme.title_font_size)
        it
      }
      show heading.where(level: 2, outlined: false): it => {
        heading(depth: 2, outlined: true, it)
      }
      show heading.where(level: 3): set text(size: theme.subtitle_font_size)
      show heading.where(level: 4): set text(size: theme.subtitle_font_size)
      set align(left)
      body
    },
  ))
}

#let sidebar_body(body, theme: THEME) = {
  set text(fill: theme.second_level_heading_color, font: theme.block_font, size: theme.block_font_size)
  set par(leading: 0.4em)
  //show par: it => block(inset: (left: 0.6em), it)
  set heading(outlined: false, bookmarked: false)
  set align(left)
  show heading: set text(font: theme.block_heading_font, fill: theme.second_level_heading_color)
  body
}
#let sidebar(body, bar_body) = {
  grid(
    columns: (2fr, 1fr),
    rows: 1,
    body,
    inset: 0.8em,
    grid.vline(),
    sidebar_body(bar_body),
  )
}

#let th(body) = {
  body
}

#let result(
  success: none,
  failure: none,
  critical_success: none,
  critical_failure: none,
  order: (Results.critical_failure, Results.failure, Results.success, Results.critical_success),
) = {
  let res = (:)
  if exists(critical_failure) { res.insert(Results.critical_failure)[*Critical Failure* #critical_failure] }
  if exists(failure) { res.insert(Results.failure)[*Failure* #failure] }
  if exists(success) { res.insert(Results.success)[*Success* #success] }
  if exists(critical_success) { res.insert(Results.critical_success)[*Critical Success* #critical_success] }
  let bloc = ()
  for cat in order {
    if cat in res {
      bloc.push(res.at(cat))
    }
  }
  if bloc.len() > 0 { linebreak() }
  bloc.join(linebreak())
}

#let capitalize(str) = {
  str
    .split(regex("\s+"))
    .map(word => {
      if word.len() > 0 {
        upper(word.at(0)) + lower(word.slice(1))
      } else {
        word
      }
    })
    .join(" ")
}
