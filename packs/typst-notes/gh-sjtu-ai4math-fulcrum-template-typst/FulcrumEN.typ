// FulcrumEN.typ
//
// English-side CNL implementation for the Fulcrum template.
//
// All English entry blocks (`entryEN`-based: definition/theorem/lemma/.../
// instance_block/variable_block/remark/example/structure), all CNL declare
// clauses (`declare/structure_declare/theorem_declare/instance_declare/
// structure_instance_declare`), the `_meta` keyword styler, the `doc_remark`
// helper, and the short bilingual-title aliases (`axm/dfn/thm/...`) live here.
//
// This file relies on shared infrastructure (the generic `entry` factory and
// state objects) being defined in `Fulcrum.typ`. It must be imported from
// `Fulcrum.typ` (not directly by user docs); user docs continue to write
//   #import "../../Fulcrum-Template-Typst/Fulcrum.typ": *
// and pick up everything via re-export.


// ============================================================
// Required upstream infrastructure (state + generic entry factory)
// ============================================================

#import "FulcrumCore.typ": (
  // generic entry factory (for short bilingual aliases below)
  entry,
  // state objects used by entry blocks
  WarningMessage,
  counterList,
  // also ensure remark visibility state is available transitively
  remark_visible,
)


// ============================================================
// English entry factory
// ============================================================

/// English-side block factory.
///
/// Unlike the CN `entry`, this uses a single `title` (no dual-language),
/// and an `authors` list (default empty, no rendering yet).
#let entryEN(
  env: "Entry",
  counter_name: "",
  color_stroke: rgb("#000000"),
  color_fill: rgb("#DDDDDD"),
  style: "full",
) = {
  if (counter_name == "") { counter_name = env }
  let envCounter = counter(counter_name)

  (
    uuid: "",
    title,
    body,
    authors: (),
    count: none,
    isExtension: false,
    lean_name: "",
    url: "",
  ) => {
    set par(first-line-indent: 0em)
    counterList.update(prev => {
      if ((prev == none) or (not counter_name in prev)) { prev + (counter_name,) }
    })
    if (count != none and type(count) == int) { envCounter.update(count - 1) }
    if (not isExtension) { envCounter.step() } else { v(-1em) }
    let cnt = context envCounter.get().at(0)

    block(
      fill: color_fill,
      inset: (x: 12pt, y: 8pt),
      stroke: (left: 3pt + color_stroke),
      width: 100%,
      spacing: 1em,
      {
        strong({
          if (not isExtension) {
            env
            [ ]
            cnt
            [: ]
          } else { v(-5pt); line(length: 100%, stroke: 0.5pt + color_stroke); v(-5pt); env + ": " }
          [#title#if (uuid != "") { label(uuid) }]
            if lean_name != "" { [ (#raw(lean_name))] }
            if url != "" { [ #link(url)[↗]] }
        })
        v(-5pt)
        line(length: 100%, stroke: 0.5pt + color_stroke)
        v(-5pt)
        body
        // authors: reserved for future rendering
        place(bottom + right)[
          #show link: set text(fill: white)
          #text(fill: white, authors.join(", "))
        ]
      },
    )
  }
}


// ============================================================
// CNL clause implementations (English)
// ============================================================

/// Meta-language keyword styling (deep green).
#let _meta(body) = text(fill: rgb("#007030"), body)


/// Render a CNL `declare` block inside a definition entry.
/// Output format:
///
///   Let <h1>, <h2>, ...[, <name> : <type>] define "<name>" as:
///     <body>
///   [Denoted by <notation>.]
///
/// Parameters:
///   hypotheses : array of content  (default: ())
///   type       : content           (default: none — omitted if none)
///   name       : content           (positional #1, the object being defined)
///   body       : content           (positional #2, the definiens)
///   notation   : content           (default: none — omitted if none)
///   isPredicate: bool              (default: false)
///   bstyle     : "inline"|"display" (default: "display")
#let declare(
  hypotheses: (),
  type: none,
  notation: none,
  isPredicate: false,
  bstyle: "display",
  name,
  body,
) = {
  // --- hypothesis + intro line ---
  let q = sym.quote.double.l  // use proper quote char
  let hyp_parts = ()
  for h in hypotheses { hyp_parts.push(h) }

  // The introduced symbol with its (optional) type annotation:
  //   non-predicate + type   -> "name : type"  (inside the parenthesis after `define`)
  //   predicate              -> just "name"    (the `iff` already signals it is a proposition)
  //   non-predicate, no type -> just "name"
  let intro = if (type != none and not isPredicate) {
    [#name #_meta([:]) #type]
  } else {
    name
  }

  if (hyp_parts.len() > 0) {
    _meta([Let ])
    hyp_parts.join(", ")
    if isPredicate {
      _meta([, define (])
      intro
      _meta([) iff:])
    } else {
      _meta([, define (])
      intro
      _meta([) as:])
    }
  } else {
    if isPredicate {
      _meta([Define (])
      intro
      _meta([) iff:])
    } else {
      _meta([Define (])
      intro
      _meta([) as:])
    }
  }

  // --- body ---
  if (bstyle == "display") {
    block(inset: (left: 1.5em, y: 0.4em), body)
  } else {
    [ ] + body
  }

  // --- notation ---
  if (notation != none) {
    _meta([Denoted by ])
    notation
    [.]
  }
}


/// Render a CNL `structure_declare` block for a Lean `structure`.
/// Output format:
///
///   [Let <h1>, ...,] define (<Name>) to be a type consisting of the following data:
///   1. <Field name> (`lean_name`) : Type
///   2. ...
///
/// Parameters:
///   hypotheses : array of content   (default: ())
///   fields     : array of 3-tuples  (natural_name, lean_name, type_content)
///   name       : content            (positional #1, the structure being defined)
#let structure_declare(
  hypotheses: (),
  fields: (),
  name,
) = {
  // --- intro line ---
  let hyp_parts = ()
  for h in hypotheses { hyp_parts.push(h) }

  if (hyp_parts.len() > 0) {
    _meta([Let ])
    hyp_parts.join(", ")
    _meta([, define (])
    name
    _meta([) to be a type consisting of the following data:])
  } else {
    _meta([Define (])
    name
    _meta([) to be a type consisting of the following data:])
  }

  // --- field list ---
  enum(
    ..fields.map(((nat_name, lean_name, field_type)) => [
      *#nat_name* (#raw(lean_name)) : #field_type
    ])
  )
}


// English entry block instances ----------------------------------------------

#let definition = entryEN(
  env: "Definition",
  counter_name: "definition",
  color_stroke: rgb("#009C27"),
  color_fill: rgb("#D6FEE0"),
)
#let theorem = entryEN(
  env: "Theorem",
  counter_name: "theorem",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
)
#let lemma = entryEN(
  env: "Lemma",
  counter_name: "theorem",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
)
#let proposition = entryEN(
  env: "Proposition",
  counter_name: "theorem",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
)
#let structure = entryEN(
  env: "Structure",
  counter_name: "definition",
  color_stroke: rgb("#E07B00"),
  color_fill: rgb("#FFF3E0"),
)
#let example = entryEN(
  env: "Example",
  counter_name: "example",
  color_stroke: rgb("#7700E4"),
  color_fill: rgb("#EFDFFF"),
)
#let remark = entryEN(
  env: "Remark",
  counter_name: "remark",
  color_stroke: rgb("#888888"),
  color_fill: rgb("#00000000"),
  style: "remark",
)


/// Render a CNL theorem/proposition clause.
/// Format (with hypotheses):   Let <h1>, ..., then <conclusion>.
/// Format (without):            <conclusion>.
#let theorem_declare(
  hypotheses: (),
  conclusion,
) = {
  let hyp_parts = ()
  for h in hypotheses { hyp_parts.push(h) }
  if (hyp_parts.len() > 0) {
    _meta([Let ])
    hyp_parts.join(", ")
    _meta([, then ])
    conclusion
    [.]
  } else {
    conclusion
    [.]
  }
}


/// `#doc_remark` — unnumbered grey block for Lean doc-string commentary.
/// Use after a structure/definition block to add the Mathlib doc string
/// in natural language. No title, no number, same grey as variable_block.
/// Usage: #doc_remark[...]
#let doc_remark = (body) => block(
  fill: rgb("#F5F5F5"),
  inset: (x: 12pt, y: 8pt),
  stroke: (left: 3pt + rgb("#888888")),
  width: 100%,
  spacing: 1em,
  body
)


/// `#variable_block` — entry block for a section's implicit variables.
/// Rendered with a light grey background to distinguish from mathematical content.
#let variable_block = entryEN(
  env: "Variables",
  counter_name: "variable_block",
  color_stroke: rgb("#888888"),
  color_fill: rgb("#F5F5F5"),
)


/// `#instance_block` — entry block for a Lean typeclass instance.
/// Use the `instance_declare` clause inside. Rendered in teal to make
/// the typeclass-instance flavor visually distinct from plain definitions.
#let instance_block = entryEN(
  env: "Instance",
  counter_name: "definition",
  color_stroke: rgb("#00807A"),
  color_fill: rgb("#D6F5F2"),
)


/// Render a CNL `instance_declare` clause.
/// Two styles are supported via the `style` argument:
///
///   * `"carries"` (default) — generic typeclass instance. With hypotheses:
///       "Let <h1>, ..., then <type_term> carries <typeclass> structure, where: <body>."
///     Without hypotheses:
///       "<type_term> carries <typeclass> structure, where: <body>."
///
///   * `"action"` — group/monoid action instance:
///       "Let <h1>, ..., <typeclass> acts on <type_term> by: <body>."
///
///   * `"is"` — the body itself is a NL phrase "is X" already (e.g.
///     a CommRing predicate); produces "Let ..., <type_term> <body>."
///     Useful when the natural reading does not match the carries/action
///     templates.
///
/// `body` is free-form CNL: describe the structural operation on a
/// generic element (e.g. "σ · T is the tableau whose entry at cell c
/// is σ(T.entry c)").
#let instance_declare(
  typeclass,
  type_term,
  body,
  hypotheses: (),
  style: "carries",
) = {
  let hyp_parts = ()
  for h in hypotheses { hyp_parts.push(h) }
  if (hyp_parts.len() > 0) {
    _meta([Let ])
    hyp_parts.join(", ")
    _meta([, ])
  }
  if style == "action" {
    typeclass
    _meta([ acts on ])
    type_term
    _meta([ by: ])
    body
    [.]
  } else if style == "is" {
    type_term
    [ ]
    body
    [.]
  } else {
    type_term
    _meta([ is endowed with ])
    typeclass
    _meta([, where: ])
    body
    [.]
  }
}


/// Render a CNL `structure_instance_declare` block — used when a Lean term
/// is itself an instance of a structure (e.g. the canonical map from a
/// `StandardYoungTableau` to a `SemistandardYoungTableau` produces a value of
/// the latter structure type).
///
/// Output format:
///
///   [Let <h1>, ...,] define (<name> : <type>) where:
///   1. <field-1>
///   2. <field-2>
///   ...
///
/// Parameters:
///   hypotheses : array of content   (default: ())
///   type       : content            (the structure type the term inhabits)
///   fields     : array of content   (one per structure field, free-form CNL)
///   name       : content            (positional #1, the term being defined)
#let structure_instance_declare(
  hypotheses: (),
  type: none,
  fields: (),
  name,
) = {
  let hyp_parts = ()
  for h in hypotheses { hyp_parts.push(h) }

  let intro = if (type != none) {
    [#name #_meta([:]) #type]
  } else { name }

  if (hyp_parts.len() > 0) {
    _meta([Let ])
    hyp_parts.join(", ")
    _meta([, define (])
    intro
    _meta([) where:])
  } else {
    _meta([Define (])
    intro
    _meta([) where:])
  }

  enum(..fields.map(f => [#f]))
}


// Short bilingual-title aliases (use generic `entry` factory so callers
// can pass dual titles in CN/EN; env strings rendered in English).
#let axm = entry(
  env: "Axiom",
  counter_name: "axiom",
  color_stroke: rgb("#C1C103"),
  color_fill: rgb("#FFFFAC"),
)
#let rule = entry(
  env: "Rule",
  counter_name: "axiom",
  color_stroke: rgb("#C1C103"),
  color_fill: rgb("#FFFFAC"),
)
#let dfn = entry(
  env: "Definition",
  counter_name: "definition",
  color_stroke: rgb("#009C27"),
  color_fill: rgb("#D6FEE0"),
)
#let struct = entry(
  env: "Structure",
  counter_name: "definition",
  color_stroke: rgb("#009C27"),
  color_fill: rgb("#D6FEE0"),
)
#let ppt = entry(
  env: "Property",
  counter_name: "property",
  color_stroke: rgb("#AC00AF"),
  color_fill: rgb("#FFEDFF"),
)
#let thm = entry(
  env: "Theorem",
  counter_name: "theorem",
  color_stroke: rgb("#005B9C"),
  color_fill: rgb("#DAF0FF"),
)
#let xmp = entry(
  env: "Example",
  counter_name: "example",
  color_stroke: rgb("#7700E4"),
  color_fill: rgb("#EFDFFF"),
)
#let rmk = entry(
  env: "Remark",
  counter_name: "remark",
  color_stroke: rgb("#E07B00"),
  color_fill: rgb("#FFEBD2"),
  style: "remark",
)
