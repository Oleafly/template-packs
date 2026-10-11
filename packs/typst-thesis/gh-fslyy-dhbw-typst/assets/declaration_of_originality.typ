// The declaration of originality is always in German per DHBW requirement.

// Workaround: Typst cannot yet format month names natively.
#let __month-names = (
  "Januar", "Februar", "März",     "April",   "Mai",      "Juni",
  "Juli",   "August",  "September", "Oktober", "November", "Dezember",
)

#let declarationOfOriginalityWith(
  title_long:      none,
  firstname:       none,
  lastname:        none,
  signature_place: "Karlsruhe",
  type:            "Bachelor Thesis",
) = [
  #align(center)[
    #heading(outlined: false, numbering: none)[Ehrenwörtliche Erklärung]
  ]

  Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe und diese Arbeit bei keiner anderen Prüfung mit gleichem oder vergleichbarem Inhalt vorgelegt habe und diese bislang nicht veröffentlich wurde.

  #v(0.8cm)

  #let month = __month-names.at(datetime.today().month() - 1)

  #align(center)[#grid(
  columns: (auto, 7cm),
  align: (left, center),
  gutter: 1cm,
  // LEFT: location + date
  [#signature_place, #(str(datetime.today().day()) + ". " + month + " " + str(datetime.today().year()))],
  // RIGHT: signature line + name
  [
    #v(3mm)
    #line(length: 100%)
    #align(center)[*#firstname #lastname*]
  ],
  )
  ]
]
