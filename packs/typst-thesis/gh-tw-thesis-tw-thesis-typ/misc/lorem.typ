// Filler text, so a draft can be paginated before the real text exists.
// Both give five paragraphs unless told otherwise.
//
//   #zh-lorem()             // five paragraphs of Chinese filler
//   #en-lorem()             // five paragraphs of latin filler
//   #zh-lorem(count: 2)     // fewer paragraphs
//
// Chinese comes from kouhu's traditional sample (itself taken from the
// zhlipsum LaTeX package), latin from ipsum.

#import "@preview/kouhu:0.2.0": kouhu
#import "@preview/ipsum:0.1.0": ipsum

#let zh-lorem(count: 5) = kouhu(builtin-text: "trad", indices: range(1, count + 1))

#let en-lorem(count: 5) = ipsum(pars: count)
