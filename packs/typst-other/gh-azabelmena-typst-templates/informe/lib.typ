#let day = datetime.today().display("[day padding:none]")
#let month = datetime.today().display("[month repr:long]")
#let year = datetime.today().display("[year repr:full]")


#let informe(
  title: "",
  organization: none,
  committee: none,
  institution: none,
  faculty: none,
  type: "",
  logo_left: none,
  logo_right: none,
  agenda: true,
  date: [#day #month #year],
  doc
) = {
  set page(
    paper: "a4",
    margin: ( x: 1in, y: 1.5in ),
    columns: 1,
    header-ascent: 0%,
    header: {
      v(10pt)
      grid(
        columns: (1fr, 4fr, 1fr),
        align: center+bottom,
        if( logo_left != none ){
          align( left, image( logo_left ) )
        },
        stack(dir: ttb, spacing: 0.5em,
          text( 14pt, weight: "bold", organization ),
          text( 12pt, committee ),
          text( 12pt, institution ),
          text( 12pt, faculty),v(0.5em),
          smallcaps(text( 12pt, weight: "semibold", type)),
          text( 12pt, date)
        ),
        if( logo_right != none ){
          align( right, image( logo_right ) )
        },
      )
      grid(
        columns: (1fr),
        align: center+horizon,
        line( length: 100%, stroke: 0.5pt ),
      )
      v(0.5em)
    },
    footer-descent: 0%
)
set par(
  justify: false,
  first-line-indent: 0em,
  spacing: 1em
)
set text(
  lang: "es",
  font: "Spectral",
  size: 12pt
)

v(15pt)
align( center, text( 24pt, title ) )

set heading(
  numbering: "1."
)
show heading: set text(20pt, weight: "semibold")

if( agenda != false ){
  outline( title: [Agenda] )
}

doc
}

#let signature(
  name: "Name",
  degree: "Degree(optional)",
  position: "Position"
) = {
  grid(
    columns: (1fr),
    align: bottom,
    v(10em),
    line( length: 35%, stroke: 0.5pt ),
    v(0.5em),
    stack(dir: ttb, spacing: 0.5em,
      if( degree != none ){
        text( 12pt, name+", "+degree )
      }else{
        text( 12pt, name )
      },
      text( 12pt, position )
    )
  )
}

#let appendix(body) = {
  set heading(numbering: "A.1", supplement: [Appendix], outlined: false)
  counter(heading).update(0)
  show heading: it => {
    v(1em)
    [#it.supplement #counter(heading).display():]
    h(0.3em)
    it.body
  }
  body
}

#let errata(body) = {
  set heading(supplement: [], outlined: false)
  show heading: it => {
    v(1em)
    [#it.supplement]
    it.body
  }
  body
}
