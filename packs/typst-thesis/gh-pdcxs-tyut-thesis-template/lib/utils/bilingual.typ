#import "@preview/gb7714-bilingual:0.2.3": gb7714-bibliography
#import "@preview/pointless-size:0.1.2": zh

#let bibliography(
  font: ("New Times Roman", "SimSun"),
  font-size: zh(5),
  prose-offset: -0.08em,
  ..args,
) = gb7714-bibliography(
  title: [#heading(level: 1, numbering: none)[#text(size: zh(-4))[参考文献]]],
  full-control: entries => {
    context {
      if entries.len() == 0 {
        return
      }

      let max-width = measure([\[#{ entries.len() }\]]).width

      let spacing = 0.5em
      let uniform-hanging = max-width + spacing

      for e in entries {
        let num-content = [#box(baseline: prose-offset)[\[#e.order\]]]
        let num-width = measure(num-content).width
        par(
          hanging-indent: uniform-hanging,
          first-line-indent: 0pt,
        )[
          #set text(size: font-size, font: font)
          #box(width: max-width)[#align(right)[#num-content]]#h(spacing)#e.labeled-rendered
        ]
        v(0.2em)
      }
    }
  },
  ..args,
)
