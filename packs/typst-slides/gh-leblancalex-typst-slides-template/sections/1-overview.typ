#import "../core/preamble.typ": *
= Overview <sec-overview>

// toc-slide: each section entry has section name, subsections (optional), label (optional).
// `active: 0` = no dimming; set to 1, 2, ... to highlight one section.
#toc-slide(
  label: [Outline],
  group: [], // [Quantum Information Research Group],
  university: [], //[Your University · 2026],
  active: 0,
  sections: (
    (section: [Layouts], subsections: [Composer, Grid, Figures], label: <sec-layouts>),
    (section: [Content], subsections: [Text & boxes, Math & code], label: <sec-content>),
    (section: [Animations], subsections: [pause / uncover, alternatives], label: <sec-animations>),
    (section: [Other section], subsections: [part 1 / 2, finish], label: <sec-test>),
  ),
)
