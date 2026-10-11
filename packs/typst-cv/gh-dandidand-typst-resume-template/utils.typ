#import "config.typ": lang

#let translate = (dict) => if lang == "es" { dict.es } else { dict.en }

#let chiline = () => {v(-3pt); line(length: 100%, stroke: 0.2pt); v(-5pt)}

#let title = (text) => [
  == #text
  #chiline()
]