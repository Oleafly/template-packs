#import "../lib/styles.typ": tbl, definition, beispiel, satz, lemma, note, tip, important

= Grundlagen
<chap-grundlagen>

Dieses Kapitel legt das theoretische Fundament und demonstriert erweiterte Typst-Features:
Tabellen mit Quellenangabe, mathematische Definitionen und die vier Theorem-Umgebungen
der Vorlage. Alle Abkürzungen — etwa @ki oder @pdf — werden beim ersten Auftreten
automatisch ausgeschrieben.

== Begriffsdefinitionen

Bevor wir fortfahren, werden zentrale Begriffe formal definiert.

#definition(title: [Wissenschaftliche Arbeit])[
  Eine wissenschaftliche Arbeit ist ein systematisch strukturierter Text, der ein definiertes
  Forschungsproblem bearbeitet, kritisch reflektiert und auf einer fundierten Quellenlage
  basiert. Sie gliedert sich typischerweise in Einleitung, Grundlagen, Hauptteil und Schluss.
]

#definition(title: [Typesetting])[
  Typesetting (auch Schriftsatz) bezeichnet den Prozess der Gestaltung und Anordnung von
  Text, Bildern und Symbolen auf einer Seite. Ziel ist die optimale Lesbarkeit und Ästhetik
  des Dokuments. Ergebnis ist üblicherweise ein @pdf.
]

#definition(title: [Markup-Sprache])[
  Eine Markup-Sprache ist eine formale Sprache, in der Text mit Steuerzeichen oder
  Schlüsselwörtern annotiert wird, um Struktur, Formatierung oder Bedeutung auszudrücken.
  Typst, LaTeX und HTML sind Markup-Sprachen.
]

=== Unterschied: LaTeX vs. Typst

Die Wahl des Textsatzsystems ist entscheidend für den Workflow. Tabelle @tab-vergleich
zeigt einen direkten Vergleich der beiden Systeme.

#tbl(
  table(
    columns: (2fr, 2fr, 2fr),
    align: left,
    [Kriterium], [LaTeX], [Typst],
    [Einstiegshürde], [Hoch (komplexe Syntax)], [Niedrig (Markdown-ähnlich)],
    [Kompiliergeschwindigkeit], [Langsam (Sekunden)], [Sehr schnell (Millisekunden)],
    [Fehlermeldungen], [Kryptisch], [Verständlich],
    [Mathematik], [Hervorragend], [Sehr gut],
    [Paketverwaltung], [Makros, komplex], [Eingebaut, modular],
    [Entwicklungsumgebung], [Overleaf, TeXstudio], [@ide wie VS Code],
  ),
  caption: [Vergleich der Textsatzsysteme LaTeX und Typst],
  source: [@doe2024],
) <tab-vergleich>

#note[
  *Hinweis zur `#tbl()`-Funktion:* Tabellen solltest du immer in `#tbl(table(...), caption:
  [...], source: [...])` einbetten. Das erzeugt einen einheitlichen Tabellenstil, fügt die
  Tabellenunterschrift an und sorgt für den Eintrag im Tabellenverzeichnis.
]

== Theoretische Einordnung

=== Ein Satz über Dokumente

#satz(title: [Eindeutige Seitenzuordnung])[
  In einem wissenschaftlichen Dokument mit römischer und arabischer Seitenzählung existiert
  zu jeder physischen Seite genau eine logische Seitenzahl. Die Nummerierungssysteme sind
  dabei disjunkt: jede Seite gehört entweder zum Frontmatter (römisch) oder zum Hauptteil
  (arabisch).
]

=== Ein Lemma zur Lesbarkeit

#lemma(title: [Optimaler Zeilenabstand])[
  Sei $l$ die Zeilenlänge in Buchstaben und $s$ der Schriftgrad in Punkt. Dann ist der
  optimale Zeilenabstand $d$ gegeben durch:

  $
    d = 1.2 dot s dot sqrt(l / 66)
  $

  Für einen Schriftgrad von 11pt und eine typische Zeilenlänge von $l = 66$ ergibt sich
  somit ein Zeilenabstand von ca. 1.2em.
]

=== Ein Beispiel aus der Praxis

#beispiel(title: [Anwendung der Vorlage])[
  Eine Studentin schreibt ihre Bachelorarbeit über @ml im Gesundheitswesen. Sie nutzt die
  Typst-Vorlage mit folgenden Schritten:

  + Öffnet `metadata.typ` und trägt Namen, Matrikelnummer und Titel ein.
  + Fügt ihre Quellen in `bibliography/references.bib` ein.
  + Schreibt Kapitel in `chapters/` und bindet sie in `main.typ` ein.
  + Definiert Abkürzungen wie @ki und @api in `glossary-entries.typ`.
  + Verwendet `#definition()`, `#satz()` und `#lemma()` für formale Umgebungen.
  + Kompiliert mit `make build` und prüft das @pdf.

  Das Ergebnis ist ein professionell gesetztes @pdf ohne manuelle Formatierungsarbeit.
]

== Mathematische Formeln

Mathematische Ausdrücke sind ein Kernfeature von Typst. Die Syntax ist LaTeX-ähnlich,
aber schlanker. Hier einige typische Beispiele:

*Inline-Formel:* Die Normalverteilung hat die Dichte $f(x) = 1\/(sigma sqrt(2 pi))
dot e^(-1\/2 ((x-mu)\/sigma)^2)$ mit Erwartungswert $mu$ und Varianz $sigma^2$.

*Abgesetzte Formel — bestimmtes Integral:*

$
  integral_a^b f(x) dif x = F(b) - F(a)
$

*Summenformel* für die ersten $n$ natürlichen Zahlen:

$
  sum_(i=1)^n i = n(n+1) / 2
$

*Matrix* mit `mat(...)`:

$
  A = mat(
    1, 2, 3;
    4, 5, 6;
    7, 8, 9;
  )
$

*Gleichungssystem* mit `cases(...)`:

$
  cases(
    2x + 3y = 5,
    x - y = 1
  )
$

#tip[
  *Nummerierte Gleichungen* — wenn du auf eine Formel mit `@eq-name` verweisen möchtest,
  wickle sie in `#figure($ ... $, caption: [...], supplement: [Gleichung]) <eq-name>` ein.
  Ein Beispiel dafür findet sich in Kapitel @chap-hauptteil.
]

== Abkürzungen und Glossar

Wissenschaftliche Arbeiten verwenden häufig Abkürzungen. Die Vorlage verwaltet diese
intelligent: Die erste Nennung von @ki wird automatisch als
"Künstliche Intelligenz (KI)" ausgeschrieben, spätere Nennungen zeigen nur noch "KI".

Weitere Beispiele aus dem Glossar dieser Vorlage:

- @api — Schnittstelle zwischen Softwarekomponenten
- @ml — Teilgebiet der @ki, das aus Daten lernt
- @pdf — das Ausgabeformat dieser Vorlage
- @url und @uri — Ressourcenadressen im Web
- @ide — Werkzeug zum Schreiben von Code
- @os — Betriebssystem, auf dem Typst läuft

Das Glossar im Anhang listet alle definierten Abkürzungen auf — inklusive automatischer
Rückverweise auf die Textstellen, an denen sie verwendet wurden.

== Stand der Forschung

Die Entwicklung von Textsatzsystemen hat sich in den letzten Jahrzehnten massiv
weiterentwickelt. Während LaTeX seit den 1980er Jahren der Goldstandard in der Wissenschaft
ist, zeigen neuere Untersuchungen wie @doe2024, dass moderne Alternativen bei der
Benutzerfreundlichkeit deutliche Vorteile bieten, ohne an typografischer Qualität
einzubüßen.

#important[
  *Wichtiger Hinweis für Studierende:* Auch wenn diese Vorlage viel Formatierungsarbeit
  abnimmt, bleibt die inhaltliche Qualität deiner Arbeit deine Verantwortung. Die Vorlage
  kümmert sich um das Layout — du musst dich um den Inhalt kümmern.
]
