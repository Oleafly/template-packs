#import "/Daten.typ": *

#let selbstständigkeitserklärung() = {
  set page(numbering: none)
  
  align(center, text(size: 16pt, font: Font, weight: "regular", "Eigenständigkeitserklärung"))
  v(10pt)
  align(center, text(size: 14pt, font: Font, weight: "regular", 
  "für nicht unter Aufsicht erbrachte schriftliche Prüfungsleistungen an der Dualen Hochschule Gera-Eisenach"))
  v(30pt)
  set text(size: 12pt, font: Font)
  v(10pt)
  enum(
    tight: false,
    spacing: 2em,

    [Hiermit versichere ich, dass ich die vorliegende Arbeit "#Titel" in allen Teilen selbstständig angefertigt und keine anderen als die in der Arbeit angegebenen Quellen und Hilfsmittel benutzt habe. Die aus fremden Quellen (oder auch aus eigenen, älteren Quellen) wörtlich oder sinngemäß übernommenen Textstellen, Gedankengänge, Konzepte, Grafiken etc. in meinen Ausführungen habe ich als solche eindeutig gekennzeichnet und mit vollständigen Verweisen auf die jeweilige Quelle versehen.],

    [Ich bin mir bewusst, dass meine Eigenständigkeitserklärung sich auch auf generierende KI-Anwendungen (nachfolgend „generative KI“) bezieht. Die umseitigen *„Vorgaben für die Studierenden der Dualen Hochschule Gera-Eisenach bei Nutzung von generativer KI für die Erstellung nicht beaufsichtigter schriftlicher Prüfungsleistungen“* habe ich zur Kenntnis genommen und bei der Erstellung der Arbeit im Falle der Nutzung generativer KI eingehalten.],
    
    [Ich versichere des Weiteren, dass ich die vorliegende Arbeit bei keiner anderen Prüfung vorgelegt habe.],

    [Mir ist bekannt, dass ein Verstoß gegen die vorgenannten Punkte prüfungsrechtliche Konsequenzen haben und insbesondere dazu führen kann, dass meine Prüfungsleistung als Täuschungsversuch und damit als „nicht bestanden“ bewertet wird.]
  )
  
  linebreak()
  v(10pt)

  pad(
    top: 1.5cm,

    grid(
      columns: (1fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      stack(
        spacing: 0.5em,
        line(length: 80%),
        "Ort, Datum"
      ),
      stack(
        spacing: 0.5em,
        line(length: 80%),
        "Unterschrift"
      ),
    )
  )
  pagebreak()
  align(center, par(spacing: 10pt, leading: 5pt, text(size: 12pt, font: Font, weight: "bold", "Vorgaben für die Studierenden der Dualen Hochschule Gera-Eisenach bei Nutzung generativer KI für die Erstellung nicht beaufsichtigter schriftlicher Prüfungsleistungen")))
  v(10pt)
  //align(left, text(weight: "bold", size: 12pt, "1. Grundsätzliches"))
  set par(leading: 5pt, spacing: 5pt)
  [
  *1. Grundlegendes*
  #v(5pt)
  Grundlegende Zielsetzung des dualen Studiums an der DHGE ist die Vermittlung der Fähigkeit zu selbstständiger Anwendung wissenschaftlicher Erkenntnisse und Methoden in der Berufspraxis (§ 111 Abs. 2 Nr. 1 ThürHG). Vor diesem Hintergrund ist die Befähigung der Absolventinnen und Absolventen zur eigenständigen Erstellung von wissenschaftlichen Arbeiten ein zentrales Ziel der Kompetenzvermittlung. Ohne Aufsicht zu erstellende schriftliche Prüfungsleistungen (wie schriftliche Seminararbeiten, Projektarbeiten, Studienarbeiten, Bachelorarbeiten, Programmentwürfe, Konstruktionsentwürfe u.Ä.) sind daher integraler Bestandteil des Studiums. Sie dienen nicht nur dem Zweck, dass die Studierenden ihren jeweiligen Entwicklungsstand im Hinblick auf die Befähigung zur Erstellung wissenschaftlicher Texte dokumentieren. Die eigenständige Erstellung dieser Arbeiten ist darüber hinaus von wesentlicher didaktischer Bedeutung für die betreffende Kompetenzentwicklung selbst.

]

  [#v(10pt)
  *2. Prüfungsrechtlich nicht erlaubte und erlaubte Nutzungen generativer KI-Tools*
  #v(5pt)
  Vor dem o.g. Hintergrund gelten an der Dualen Hochschule Gera-Eisenach folgende prüfungsrechtliche Regelungen für die *Nutzung von generativen KI-Tools (wie z.B. ChatGPT, deepL/write u.Ä.) bei der Erstellung von nicht beaufsichtigten schriftlichen Prüfungsleistungen* durch die Studierenden: \ *#underline[Nicht] erlaubt ist die Nutzung von generativen KI-Tools für*\
  - die Generierung von als Eigenleistung dargestellten fachlichen Inhalten,
  - die sprachliche Optimierung von eigenen Textpassagen.
  *Erlaubt ist die Nutzung von generativen KI-Tools für*
  - Übersetzungen von fremdsprachlichen Textpassagen externer Quellen, sofern die Übersetzung selbst #underline[nicht] Teil der in der Arbeit zu erbringenden Eigenleistung ist,
  - Brainstorming / Ideenfindung,
  - Literaturrecherchen,
  - Erzeugung von Bildern, Grafiken u.Ä., sofern deren Inhalte #underline[nicht] für die fachliche Bewertung der betreffenden Arbeit relevant sind,
  - KI-Anwendungen, die selbst Teil der Aufgabenstellung der betreffenden Arbeit sind.]

  [#v(10pt)
  *3. Eigenständigkeitserklärung und Transparenzpflichten*
  #v(5pt)
  Rechtsgrundlage § 6 Abs. 4 DHGEPrüfO: Besteht die Prüfungsleistung aus einer selbstständig und ohne Aufsicht zu erstellenden schriftlichen Ausarbeitung, Bearbeitung oder Dokumentation hat der/die Studierende in der betreffenden Arbeit zu versichern, dass er/sie die Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt hat. Soweit generative KI-Tools bei der Erstellung der betreffenden Arbeit genutzt wurden, stellen diese selbst Hilfsmittel dar, die und deren Nutzung durch die/den Studierende/n detailliert nach den folgenden Vorgaben in der betreffenden Arbeit zu dokumentieren sind:
  - Kennzeichnung aller mit Hilfe generativer KI erzeugten Teile der Arbeit (analog zu Verweisen auf fremde Quellen)
  - Auflistung aller verwendeten KI-Tools und deren jeweilige Nutzungszwecke,
  - Angabe der bei der Nutzung verwendeten Prompts (Anweisungen und Fragen an das jeweilige KI-Tool) und Dokumentation der vom jeweiligen KI-Tool zurückgegebenen Ergebnisse, soweit diese in der Endfassung der Arbeit Berücksichtigung gefunden haben.]
}

#let freigabeerklärung() = {
  set page(numbering: none)
  
  align(center, text(size: 16pt, font: Font, weight: "regular", "Freigabeerklärung zur Bachelorarbeit"))
  v(50pt)

  set text(size: 12pt,)
  table(
    columns: (2fr, 1fr, 1fr),
    stroke: none,
    align: left,
    row-gutter: 15pt,

    [_Name, Vorname Student/-in:_],   [_Matrikel-Nr._],   [_Kurs:_],
    [#Author],                        [#Matrikelnummer],  [#Kurs]
  )
  v(20pt)
  table(
    columns: (1fr),
    stroke: none,
    align: left,
    row-gutter: 15pt,

    [_Ausbildungsstätte:_],
    [#Ausbildungsstätte \ #StraßeHausnrAusbilder \ #PLZOrtAusbilder]
  )
  v(30pt)
  [Mit der Möglichkeit zur öffentlichen Einsichtnahme der Bachelorarbeit unseres Studenten, Herr #Author, in der Bibliothek der Dualen Hochschule Gera-Eisenach erklären wir uns:]
  v(10pt)
  table(
    columns: (20mm, 10mm, auto),
    stroke: none,
    align: horizon,
    row-gutter: 5pt,
    
    [ ], [#rect(width: 5mm, height: 5mm, stroke: black, align(center + horizon,text("", size: 15pt, ))) ], [einverstanden.],
    [ ], [#rect(width: 5mm, height: 5mm, stroke: black, align(center + horizon,text("✓", size: 15pt, ))) ], [nicht einverstanden.]
  )
  v(20pt)
  [Thema der Bachelorarbeit: \ ]
  [#Titel]
  v(100pt)
  set text(size: 11pt)
  table(
    columns: (5fr, 4fr),
    stroke: none,
    align: top + left,
    row-gutter: 0pt,
    column-gutter: 10pt,
    
    [#line(length: 100%)], [#line(length: 100%)],
    [_Datum, Stempel, Unterschrift Firma/Einrichtung_], [_Datum, Unterschrift Student/-in_]
  )
}

#let abgabeerklärung() = {
  align(center, text(size: 16pt, font: Font, weight: "regular", "Erklärung zur Abgabe eines gebundenen Exemplars der Bachelorarbeit beim Praxispartner"))
  v(50pt)

  set text(size: 12pt,)
  table(
    columns: (2fr, 1fr, 1fr),
    stroke: none,
    align: left,
    row-gutter: 15pt,

    [_Name, Vorname Student/-in:_],   [_Matrikel-Nr._],   [_Kurs:_],
    [#Author],                        [#Matrikelnummer],  [#Kurs]
  )
  v(20pt)
  table(
    columns: (1fr),
    stroke: none,
    align: left,
    row-gutter: 15pt,

    [_Ausbildungsstätte:_],
    [#Ausbildungsstätte \ #StraßeHausnrAusbilder \ #PLZOrtAusbilder]
  )
  v(30pt)
  [Hiermit bestätigen wir die fristgerechte direkte Abgabe von einem der drei gebundenen Exemplare beim Betreuer des Praxispartners (Ausbildungsstätte) nach § 19 Abs. 3 der Prüfungsordnung für die Bachelorstudiengänge der Dualen Hochschule Gera-Eisenach (DHGEPrüfO).]
  v(30pt)
  [Thema der Bachelorarbeit: \ ]
  [#Titel]
  v(100pt)
  set text(size: 11pt)
  table(
    columns: (5fr, 4fr),
    stroke: none,
    align: top + left,
    row-gutter: 0pt,
    column-gutter: 10pt,
    
    [#line(length: 100%)], [#line(length: 100%)],
    [_Datum, Stempel, Unterschrift Firma/Einrichtung_], [_Datum, Unterschrift Student/-in_]
  )
}