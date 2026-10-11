// #import "@preview/acrostiche:0.7.0": *
#import "../utils/tables.typ":*
#import "../utils/helpers.typ":*

= Temp <kap:Temp>
== Tabelle <kap:tab>
lorem ipsum
lorem ipsum


#fmt_table(kind: tbl.normal, caption:"Text", columns:3, ..(
  "Object", "Raw", "Display",
  "Acronyme", `#short("TUD")`, short("TUD"),
  [Zitat],`@Krom`,[@Krom],
  "Querverweis",`@kap:Temp`,[@kap:Temp],
  "Bold",`*Bold*`,[*Bold*],
  "Debug Typst",`panic(repr(fkk.fields()))`, ".!.!.! > Console"
))<tab:text>

@tab:text

== Bild <kap:bild>
=== Diagramm <kap:dia>
lorem ipsum

#include "../images/datenfluss.typ"

=== Picture <kap:picture>
lorem ipsum
#figure(
  image("../images/schät1.png", height: 50%), 
  caption: [ein PNG]
)<fig:png>

= neues kapitel
lorem ipsum bla bla


