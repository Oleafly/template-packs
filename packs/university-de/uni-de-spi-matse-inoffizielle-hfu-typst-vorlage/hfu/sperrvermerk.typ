// Optionaler Sperrvermerk für vertrauliche Arbeiten.
//
// Er steht unmittelbar nach dem Titelblatt und vor allen weiteren Bestandteilen.
// Die Seite hat weder Kopfzeile noch Seitenzahl und die Überschrift erscheint nicht im Inhaltsverzeichnis.
// Nur die Überschrift wird zentriert; der eigentliche Text bleibt wie der übrige Fließtext im Blocksatz.

#let sperrvermerk(titel, firma, variante: "bericht") = page(
  header: none,
  footer: none,
  numbering: none,
  {
    align(center, heading(
      level: 1,
      numbering: none,
      outlined: false,
      [Sperrvermerk],
    ))

    if variante == "bericht" {
      [
        Der vorgelegte Bericht mit dem Titel „#titel“ beinhaltet vertrauliche Informationen und Daten des Unternehmens #firma.

        Dieser Bericht darf nur von mit der Begutachtung der Prüfungsleistung beauftragten Personen sowie berechtigten Mitgliedern des Prüfungsausschusses eingesehen werden.
        Eine Vervielfältigung und Veröffentlichung des Berichts ist auch auszugsweise nicht erlaubt.

        Dritten darf dieser Bericht nur mit der ausdrücklichen Genehmigung des Verfassers und des Unternehmens zugänglich gemacht werden.

        Die Sperrfrist beträgt 5 Jahre, sie beginnt mit dem Tag der Abgabe des Berichts.
      ]
    } else if variante == "bachelorarbeit" {
      [
        Die vorgelegte Bachelorarbeit mit dem Titel „#titel“ beinhaltet vertrauliche Informationen und Daten des Unternehmens #firma.

        Diese Bachelorarbeit darf nur vom Erst- und Zweitgutachter sowie berechtigten Mitgliedern des Prüfungsausschusses eingesehen werden.
        Eine Vervielfältigung und Veröffentlichung der Bachelorarbeit ist auch auszugsweise nicht erlaubt.

        Dritten darf diese Arbeit nur mit der ausdrücklichen Genehmigung des Verfassers und des Unternehmens zugänglich gemacht werden.

        Die Sperrfrist beträgt 5 Jahre, sie beginnt mit dem Tag der Abgabe der Arbeit.
      ]
    } else {
      panic(
        "hfu-vorlage: Unbekannte Sperrvermerk-Variante `" + variante
          + "`; erlaubt sind `bericht` und `bachelorarbeit`.",
      )
    }
  },
)
