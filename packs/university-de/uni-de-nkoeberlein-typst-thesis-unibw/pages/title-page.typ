// =============================================================
// title-page.typ – Titelseite
// =============================================================

#import "../metadata.typ": *
#import "../lib/colors.typ": *

#set page(
  header: none,
  footer: none,
  margin: (left: 25mm, right: 25mm, top: 22mm, bottom: 22mm),
  numbering: none,
)

// === Universitäts-Header ===
#align(center)[
  #image("../resources/Signet_UniBw.pdf", width: 80%)

  #v(5mm)

  #text(size: 12pt, style: "normal", fill: secondary)[
    #smallcaps[#myfaculty]
  ]
]

#v(1fr)

// ── Titelblock ─────────────────────────────────────────────────
#align(center)[

  // Seminarthema/Themenbereich – nur anzeigen wenn myseminar nicht leer
  #if myseminar != "" [
    #text(size: 9pt, fill: secondary, tracking: 1.5pt)[
      #upper[#if mytype == "Seminararbeit" [Seminar] else [Themenbereich]]
    ]
    #v(3mm)

    #block(width: 80%)[
      #text(size: 19pt, weight: "bold", fill: primary)[
        #myseminar
      ]
    ]

    #v(7mm)
    #line(length: 55%, stroke: 1.5pt + accent)
    #v(7mm)
  ]

  // Arbeitstyp und Titel
  #text(size: 11pt, fill: secondary, tracking: 0.5pt)[
    #upper[#mytype] #h(4pt) #sym.bar.v #h(4pt) Thema
  ]
  #v(3mm)
  #text(size: 26pt, weight: "bold", fill: primary)[#mytitle]

  #v(10mm)
  #line(length: 40%, stroke: 0.4pt + lightgray)
  #v(10mm)

  // Autor
  #text(size: 9.5pt, fill: secondary, tracking: 1pt)[#upper[vorgelegt von]]
  #v(3mm)
  #text(size: 15pt, weight: "bold")[#myname]
  #v(2mm)
  #text(size: 10pt, fill: secondary)[Matrikelnummer: #matricle]
]

#v(1fr)

// ── Betreuungs-Informationen ───────────────────────────────────
// Felder mit "" in metadata.typ werden automatisch ausgeblendet.
#align(center)[
  #grid(
    columns: (130pt, auto),
    row-gutter: 6pt,
    column-gutter: 8pt,
    align: (right, left),
    text(fill: secondary)[Aufgabensteller:], strong[#reviewerone],
    ..(if reviewertwo != "" {
      (text(fill: secondary)[Zweitgutachter:], strong[#reviewertwo])
    } else { () }),
    ..(if advisor != "" {
      (text(fill: secondary)[Betreuer:], strong[#advisor])
    } else { () }),
    [], [],
    text(fill: secondary)[Eingereicht am:], strong[#timeend.display("[day]. [month repr:long] [year]"), #myplace],
  )
]

// Nummerierung wiederherstellen (wurde für die Titelseite deaktiviert)
#set page(numbering: "I")
#pagebreak()
