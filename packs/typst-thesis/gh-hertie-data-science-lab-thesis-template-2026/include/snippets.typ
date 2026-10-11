#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

/////////////////////////////////////////////////////////////////////////
//  HELPER FUNCTIONS
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////


// Shortcuts
#let citep(label,..args) = {cite(label,form:"prose",..args)}
#let indent(content) = pad(left: 2em)[#content]

#let spc = h(1em)
#let hspc = h(.4em)
#let tspc = h(.2em)
#let mspc = h(.15em)

#let bm(input) = {$bold(#input)$}
#let mathbf(input) = {$upright(bold(#input))$}
#let mathbb(input) = {$bb(#input)$}
#let scr(it) = text(features: ("ss01",),box($cal(it)$),)


// Additional spacing between figures and the text
#let figurespace(figure_spacing : 0, body) = {
  show figure: it => {
    if it.placement == none {
      block(it, spacing: figure_spacing)
    } else if it.placement == top {
      place(
        it.placement,
        float: true,
        block(width: 100%, below: figure_spacing, align(center, it))
        //block(width: 100%, inset: (bottom: figure_spacing), align(center, it))
      )
    } else if it.placement == bottom {
      place(
        it.placement,
        float: true,
        block(width: 100%, above: figure_spacing, inset: (bottom: 1.5em), align(center, it))
      )
    }
  }
  body
}

// Horizon figure
#let hfigure(label: <none>, ..args) = {
    page[
      #set align(center + horizon)
      #block(width: 100%, inset: (bottom: 1.5em), align(center+horizon, [#figure(..args) #label]))
    ]
}


// Resize stuff, e.g. cetz plots
#let scale-to-width(body, width:100%) = layout(page-size => {
  let size = measure(body, ..page-size)
  let target-width = if type(width) == ratio {
    page-size.width * width
  } else if type(width) == relative {
    page-size.width * width.ratio + width.length
  } else {
    width
  }
  let multiplier = target-width.to-absolute() / size.width
  scale(reflow: true, multiplier * 100%, body)
})

