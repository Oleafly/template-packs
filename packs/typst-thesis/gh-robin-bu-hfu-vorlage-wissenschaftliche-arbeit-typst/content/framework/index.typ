#import "../../template.typ": unnumbered-chapter

// ##################################################
// Stichwortverzeichnis
//
// Manuell gepflegtes Verzeichnis: je Eintrag ein fett gesetztes Stichwort,
// darunter eine um 0,5 cm eingerückte Beschreibung. Einträge mit #stichwort(...)
// ergänzen.
//
// Aus dem Text mit #sw("Begriff") auf den passenden Eintrag verlinken
// (klickbarer Verweis, springt ins Stichwortverzeichnis).
// ##################################################

// Label eines Stichwort-Eintrags (Sprungziel der Verweise)
#let _sw-label(begriff) = label("sw-" + begriff)

// Ein Eintrag: fettes Stichwort (mit Label) + eingerückte Beschreibung
#let stichwort(begriff, beschreibung) = {
  text(weight: "bold")[#begriff#_sw-label(begriff)]
  pad(left: 0.5cm)[#beschreibung]
}

// Verweis im Text auf einen Stichwort-Eintrag; display: anzuzeigender Text
#let sw(begriff, display: auto) = link(
  _sw-label(begriff),
  if display == auto { begriff } else { display },
)

#let index = {
  unnumbered-chapter("Stichwortverzeichnis")

  stichwort("Stichwort", "Beschreibung des Stichworts.")
  stichwort("Weiteres Stichwort", "Beschreibung des weiteren Stichworts.")
}
