#import "../config/input.typ": *

#set page(numbering: none)
#set par(spacing: 1em, leading: 1em)
#set align(center)

#show <h1>: set text(weight: "bold")
#show <h1>: it => upper(it)

#figure(
  image(
    "../assets/image/unindra-logo.png",
    height: 4cm,
    width: 4cm
  ),
  numbering: none
)
\
\
\
#thesis-title <h1>
\
\
\
\
SKRIPSI \
diajukan untuk melengkapi \
persyaratan mencapai \
gelar sarjana \
\
\
\
\
#grid(
  columns: (10pt, auto, auto, auto),
  row-gutter: 1em,
  column-gutter: 1em,
  align: (auto, left, center, left),
  [],[#strong[Nama]],[#strong[:]],[#strong[#upper(name)]],
  [],[#strong[NPM]],[#strong[:]],[#strong[#npm]],
)
\
\
\
\
#study-program<h1>\
#faculty<h1>\
universitas indrapratsa pgri<h1>\
#datetime.today(offset: +7).display("[year]")<h1>

#pagebreak()