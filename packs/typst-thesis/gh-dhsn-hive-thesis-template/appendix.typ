#pagebreak()
#counter(page).update(1)
#set page(numbering: "I")

#set heading(numbering: none)

= Verzeichnisse und Anlagen

== Quellenverzeichnis

#bibliography("references.bib", style: "ieee", title: none)
//#bibliography("references.yaml", style: "ieee", title: none)

#pagebreak()

== Selbständigkeitserklärung

\ \ \ \

Ich versichere, dass ich die vorliegende Projektarbeit/Studienarbeit/Bachelorthesis ohne
fremde Hilfe selbständig verfasst und nur die angegebenen Quellen und Hilfsmittel
benutzt habe. Wörtlich oder dem Sinn nach aus anderen Werken entnommene Stellen
sind unter Angabe der Quellen kenntlich gemacht. Bestandteile der Arbeit, die mittels
Künstlicher Intelligenz entstanden sind, wurden ausdrücklich gekennzeichnet. Die
Arbeit wurde bisher in gleicher oder ähnlicher Form weder veröffentlicht noch einer
anderen Prüfungsbehörde vorgelegt.

\ \ \ \

#table(
  columns: (1fr, 1fr,), 
  stroke: none,
  [#align(left + bottom)[Leipzig, den #datetime.today().display(
  "[day].[month].[year]")]],
  [
    #table(columns: (auto), 
    stroke: none, 
    align: center + bottom, 
    inset: 0pt,
    [#image("img/signature.png", height: 30pt)#line(length: 120pt) #block()],
    [{Vorname Nachname}]
  )
  ]
)