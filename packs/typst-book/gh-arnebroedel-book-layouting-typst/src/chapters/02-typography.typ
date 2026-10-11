// chapters/02-typography.typ — Typographie

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": blockquote, callout, key-concept, pull-quote
#import "../components/inline.typ": highlight-text
#import "../components/layouts.typ": comparison-layout
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Typografie und Lesbarkeit],
  lead: [Die unsichtbare Kunst, die darüber entscheidet, ob medizinisches
    Wissen vermittelt oder übersehen wird.],
)

#pull-quote(attribution: "Emil Ruder, Typograf")[
  Typografie hat einen Zweck: die Mitteilung von Information.
  Keine Ausrede kann daran etwas ändern.
]

== Die Bedeutung der Lesbarkeit

Medizinische Texte stellen besondere Anforderungen an die Lesbarkeit#index[Lesbarkeit].
Fachbegriffe wie #highlight-text[Acetylsalicylsäure],
#highlight-text[Glomerulonephritis] oder
#highlight-text[Thrombozytenaggregationshemmer] können bis zu dreißig
Zeichen umfassen. Eine Schrift, die bei solchen Wortlängen die Leserlichkeit
bewahrt, muss sorgfältig gewählt werden.

Die Forschung zur Leseergonomie zeigt drei entscheidende Faktoren:

+ *Zeilenlänge*#index[Zeilenlänge]: Ideal sind 60–75 Zeichen pro Zeile. Zu kurze Zeilen
  erzeugen hektisches Springen; zu lange Zeilen führen dazu, dass das Auge
  den Zeilenanfang verliert.

+ *Zeilenabstand (Leading)*#index[Zeilenabstand]: Ein Abstand von 120–145% der Schriftgröße
  erleichtert die Rückführung des Blicks an den Zeilenanfang. Bei dichtem
  Fachtext ist ein großzügigerer Abstand vorzuziehen.

+ *Kontrast*#index[Kontrast]: Schwarzer Text auf weißem Grund bietet den höchsten Kontrast,
  aber ein leicht abgedunkeltes Schwarz (#highlight-text[z. B. #333333])
  reduziert Ermüdung bei längerer Lektüre.

#section-break()

== Schriftwahl für klinische Materialien

Die Entscheidung zwischen Serifen- und serifenloser Schrift ist keine
rein ästhetische Frage. Serifenschriften#index[Serifenschrift] wie die hier verwendete
_Libertinus Serif_ eignen sich hervorragend für längere Fließtexte, weil
die Serifen als subtile horizontale Führung für das Auge dienen.

Serifenlose Schriften eignen sich dort, wo schnelle Erfassung zählt:
Überschriften, Tabellenbeschriftungen, Bildlegenden. Dieses Buch
bindet keine Sans ein: Überschriften nutzen dieselbe Libertinus-Familie
wie der Fließtext. Hierarchie entsteht über Größe, Gewicht und Farbe,
nicht über einen zweiten Schnitt. Eine Systemschrift wie Calibri würde
den Satz auf jedem Rechner anders aussehen lassen.

#comparison-layout(
  left-title: [Serifen (Fließtext)],
  right-title: [Eine Familie, klare Stufen],
  [
    Die Serife — der kleine Querstrich am Ende eines Buchstabenstrichs —
    erzeugt eine optische Grundlinie, der das Auge folgt. In Druckwerken
    mit langen Textpassagen ist dies messbar von Vorteil.
  ],
  [
    Ohne eingebettete Sans tragen Überschriften dieselbe Familie.
    Fett, größere Grade und die Primärfarbe trennen die Ebenen
    zuverlässig — reproduzierbar auf jedem Rechner.
  ],
)

== Typografische Hierarchie

#key-concept(term: "Typografische Hierarchie")[
  Ein visuelles System abgestufter Schriftgrößen, -gewichte und -farben,
  das dem Leser ohne bewusstes Nachdenken signalisiert, welche Information
  Hauptaussage, Nebenaussage oder Erläuterung ist.
]

Eine gut gestaltete Hierarchie#index[Typografische Hierarchie] nutzt mindestens drei und höchstens fünf
Ebenen. Jede Ebene unterscheidet sich deutlich genug von der vorherigen,
um sofort erkennbar zu sein, aber nicht so stark, dass der Gesamteindruck
unruhig wird.

In diesem Buch verwenden wir fünf Ebenen:

- *Ebene 1*: Kapitelüberschriften — groß, farbig, fett
- *Ebene 2*: Abschnitte — mittelgroß, dunkel, fett
- *Ebene 3*: Unterabschnitte — Standardgröße, fett
- *Ebene 4*: Nebenüberschriften — kompakt, fett
- *Ebene 5*: Einlaufende Überschriften — kursiv, dezent

#blockquote(attribution: "Robert Bringhurst, The Elements of Typographic Style")[
  Typografie existiert, um der Sprache zu dienen. Sie ist nicht Selbstzweck,
  sondern Mittel zur Vermittlung von Bedeutung.
]

== Mikrotypografie

Die feinen Details — Ligaturen#index[Ligaturen], Kerning#index[Kerning], optischer Randausgleich und
korrekte Anführungszeichen — machen den Unterschied zwischen einem
professionellen Druckerzeugnis und einem Entwurf. Typst beherrscht viele
dieser Details automatisch, doch ein aufmerksamer Autor achtet auf:

#callout(title: "Praxis-Tipp", tone: "success")[
  Verwenden Sie stets die korrekten typografischen Zeichen: Gedankenstriche
  (—) statt Bindestriche (-), deutsche Anführungszeichen („...") statt
  gerade Zeichen ("..."), und geschützte Leerzeichen vor Einheiten
  (120~mmHg statt 120 mmHg).
]

=== Zahlen und Einheiten

In medizinischen Texten kommt den Zahlen besondere Bedeutung zu.
Laborbefunde, Dosierungen und Messwerte müssen sofort korrekt
erfasst werden können. Tabellenziffern#index[Tabellenziffern] — Ziffern mit einheitlicher
Breite — sorgen dafür, dass Zahlenspalten sauber untereinander stehen.
Typst verwendet standardmäßig Proportionalziffern für Fließtext und
kann bei Bedarf auf Tabellenziffern umschalten.

#key-concept(term: "Medianstrich vs. Gedankenstrich")[
  Der Medianstrich (Halbgeviertstrich, –) dient als Bis-Strich in
  Bereichen (Seiten 12–24, Dosis 5–10~mg). Der Gedankenstrich
  (Geviertstrich, —) markiert Einschübe und Parenthesen im Satzfluss.
  Beide dürfen nicht mit dem Bindestrich (-) verwechselt werden.
]

#section-break()

== Barrierefreiheit und Lesbarkeit

Gute Typografie ist inklusiv. Die Beachtung grundlegender
Barrierefreiheitsstandards#index[Barrierefreiheit] verbessert die Lesbarkeit nicht nur für
Menschen mit Einschränkungen, sondern für alle Leser:

- *Kontrastverhältnis*: Mindestens 4.5:1 für Fließtext (WCAG AA)
- *Schriftgröße*: Nicht unter 9~pt für Fließtext, nicht unter 7~pt
  für Fußnoten
- *Farbunabhängigkeit*: Informationen werden nie ausschließlich über
  Farbe vermittelt — zusätzliche Symbole oder Textmarker sind obligat
- *Zeilenabstand*: Mindestens 1.5-fach für Leser mit Dyslexie

#callout(title: "WCAG-Konformität", tone: "warning")[
  Farbige Hervorhebungen in Diagrammen und Tabellen müssen auch
  im Schwarz-Weiß-Druck unterscheidbar sein. Ergänzen Sie farbcodierte
  Informationen stets durch Muster, Symbole oder Beschriftungen.
]
