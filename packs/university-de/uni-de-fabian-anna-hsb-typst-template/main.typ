#import "template.typ": *

#show: project.with(
  title: "Haupttitel",
  subtitle: "Sekundärer Titel",
  company: "Hochschule Bremen",
  department: "Fakultät 4: - Elektrotechnik und Informatik",
  studyProgram: "Masterstudiengang Informatik (M.Sc.)",
  course: "Modulname",
  docType: "Dokumententyp",
  authors: (
    "Vorname Nachname (Matrikelnummer)", //Können auch mehrere sein
  ),
  bibliography-file: "refs.bib",
  logo: "img/HSB_Logo_Farbe_sRGB.svg"
)

//Ab hier kann man in Markdown alles runterschreiben und nach Bedarf Typst Funktionen nutzen

= Überschrift
<label_zur_überschrift>

== Texte formatieren
Inhalt kann man einfach in Markdown Syntax schreiben. Hier ein Beispiel: \
Normaler *fetter* _kursiver_ Text. 

== Listen und Aufzählungen
Eine Liste: \
- Erster Punkt
- Zweiter Punkt
  - Unterpunkt

== Bilder und Tabellen
Bilder kann man auch einfügen:
#figure(
  image("img/HSB_Logo_Farbe_sRGB.svg"),
  caption: "Bildbeschriftung",
) <label_zum_bild> // Das hier ist ein Label auf das man Referenzieren kann

Tabellen auch:
#figure(
  table(
    columns: 2,
    table.header( [Spalte 1], [Spalte 2] ), //Spaltentitel
    // Zeilen danach einfach durch Kommas trennen, der Umbruch erfolgt anhand der Spaltenanzahl
    [Zeile 1, Spalte 1], [Zeile 1, Spalte 2],
    [Zeile 2, Spalte 1], [Zeile 2, Spalte 2],
  ),
  caption: "Tabellenbeschriftung"
) <tab:label>

Bilder oder Tabellen kann man einfach per label referenzieren: \
Siehe @label_zum_bild, @tab:label oder @label_zur_überschrift.

== Zitieren und Verlinkungen
Genauso kann man übrigens auch Zitieren aus Quellen aus der Bibliography, siehe @wikipedia.

Das korrekte Format wird hierbei automatisch hergeleitet bei multiplen Quellen @wikipedia @wikipediaZitierregeln2025.

Alternativ kann man die Zitierung auch manuell über den `cite`-Befehl anpassen \ 
#cite(<wikipediaZitierregeln2025>, form: "full").

Das Zitierformat kann in `template.typ` mithilfe des Befehls 
```typst
set bibliography(style: "<Zitierstyle>")
```
angepasst werden. Typst unterstützt eine #link("https://typst.app/docs/reference/model/bibliography/#parameters-style")[Vielzahl an Zitierstylen] mittels offizieller CSLs. Bei Bedarf könnte man diese natürlich auch forken und anpassen.

== Links und Weiteres
Weiteren Schnickschnack kann man ansonsten in der #link("https://typst.app/docs/reference/")[Typst-Online-Dokumentation] nachlesen.

== Nutzung
Typst unterstützt einen kostenlosen Online-Editor wie Overleaf auf #link("https://typst.app/")[typst.app]. Auf diesem kann man sehr einfach zusammenarbeiten und das Dokument in Echtzeit bearbeiten.

Wer will, kann das ganze aber natürlich auch lokal über beispielsweise VSCode editieren mithilfe von #link("https://github.com/Myriad-Dreamin/tinymist")[Tinymist]. Eine Versionskontrolle kann dann z.B. über Github realisiert werden.