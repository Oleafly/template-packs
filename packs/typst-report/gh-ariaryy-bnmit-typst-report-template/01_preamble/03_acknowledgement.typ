#import "../template.typ": fit-page, plate, section-title

// ===========================================================================
// EDIT THE PROSE BELOW. It is meant to be changed.
//
// This page is the one part of the report whose wording is not standard: who
// you thank, in what order, and how warmly is yours to decide. The names of
// the college's office holders are written out here rather than pulled from
// config.typ, because they are prose, not data, and burying eight names and
// their honorifics in a config file makes both files worse.
//
// What does come from config.typ is anything already recorded there: the
// subject, your guide, your department and its head, and the author list at
// the bottom. Change those in config.typ, not here.
//
// One thing to watch: the sentences below treat `subject.name` as the name of
// a course, in the first paragraph, the one thanking the head of department,
// and the last one. If your subject is already a project rather than a course,
// a final year Project Phase I for instance, those read as "the completion of
// the Project Phase I project". Reword them; that is what this file is for.
//
// Each paragraph is wrapped in `thanks[...]`, which adds the gap after it.
// Add, remove or reorder those freely. The page shrinks itself to stay on one
// sheet, so a few extra paragraphs will not push it onto a second.
// ===========================================================================

// `k` is the fit-page scale factor; see `fit-page` in template.typ.
#let acknowledgement-body(config, k) = [
  #set text(
    size: config.style.text-size.body * k,
    font: config.style.fonts.body,
  )
  #set par(justify: true, leading: config.style.leading)

  // Top-aligned and sharing the front matter title treatment, so a shortened
  // or rewritten acknowledgement keeps the same first line position instead of
  // drifting up the page the way vertical centring would.
  #section-title(config, [Acknowledgement], k: k, drop: config.style.plate-title-drop)

  #let thanks(body) = { body; parbreak(); v(config.style.acknowledgement-gap) }

  #thanks[We consider it a privilege to express through the pages of this report, a few
    words of gratitude to all those distinguished personalities who guided and inspired
    us in the completion of this project as a part of *#config.subject.name* course.]

  #thanks[We would like to thank *Shri. Narayan Rao R Maanay*, Secretary, BNMEI,
    Bengaluru for providing an excellent academic environment in college.]

  #thanks[We would like to thank *Prof. T J Rama Murthy*, Director, BNMIT, Bengaluru
    for having extended his support and encouragement during the course of work.]

  #thanks[We would like to thank *Dr. S Y Kulkarni*, Principal and Additional Director,
    BNMIT, Bengaluru for his extended support and encouragement during the course of work.]

  #thanks[We would like to express our gratitude to *Prof. Eishwar N Maanay*, Dean,
    BNMIT, Bengaluru for his relentless support, guidance, and encouragement.]

  #thanks[We would like to thank *Dr. Krishnamurthy G N*, Deputy Director, BNMIT,
    Bengaluru for his constant encouragement.]

  #thanks[We would like to thank *#config.department.hod.name*,
    #config.department.hod.designation in the Department of
    #config.department.name, BNMIT, Bengaluru, for the support and
    encouragement towards the completion of the #config.subject.name project.]

  #thanks[We would like to express our gratitude to our guide *#config.guide.name*,
    #config.guide.designation in the Department of #config.guide.department.name,
    BNMIT, Bengaluru, who has given us all the support and guidance in completing the
    project work as a part of the #config.subject.name course
    successfully.]

  #v(1.5em)
  #align(
    right,
    table(
      row-gutter: -2pt,
      stroke: none,
      columns: 2,
      inset: (x: 3pt, y: 3pt),
      ..config.authors.map(a => ([*#a.name*], [*(#a.usn)*])).flatten(),
    ),
  )
]

#let acknowledgement(config) = plate(
  config,
  fit-page(k => acknowledgement-body(config, k), min-scale: 0.8),
  alignment: left + top,
)
