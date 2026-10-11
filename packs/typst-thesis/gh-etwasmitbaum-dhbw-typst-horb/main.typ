#import "clean-dhbw/lib.typ": *
#import "acronyms.typ": acronyms
#import "glossary.typ": glossary
#import "abstract.typ": abstract, abstract-second-language
#import "appendix.typ": appendix

#show: clean-dhbw.with(
  title: "Mustertitel",
  authors: (
    (
      name: "Max Mustermann",
      student-id: "7654321",
      course: "TINF22B2",
      course-of-studies: "Elektrotechnik",
      specialization: "Automation",
      work-weeks: "KW XX - KW XX",
      company: (name: "ABC GmbH", post-code: "76131", city: "Karlsruhe"),
    ),
    (
      name: "Juan Pérez",
      student-id: "1234567",
      course: "TIM21",
      course-of-studies: "Mobile Computer Science",
      specialization: "Automation",
      work-weeks: "KW XX - KW XX",
      company: (name: "ABC S.L.", post-code: "08005", city: "Barcelona", country: "Spain"),
    ),
  ),
  //city: "Suttgart",
  type-of-thesis: "Bachelorarbeit",
  acronyms: acronyms, // displays the acronyms defined in the acronyms dictionary
  abstract: abstract,
  abstract-second-language: abstract-second-language,
  second-language-for-abstract: "en",
  at-university: false, // if true the company name on the title page and the confidentiality statement are hidden
  bibliography: bibliography("sources.bib"),
  date: datetime.today(),
  //glossary: glossary, // displays the glossary terms defined in the glossary dictionary
  appendix: appendix, // displays the appendix w#ith the text in the appendix.typ file
  language: "de", // en, de
  supervisor: (company: "John Appleseed", university: "Prof. Dr. Daniel Düsentrieb"),
  university: "Dualen Hochschule Baden-Württemberg",
  university-location: "Stuttgart Campus Horb",
  university-short: "DHBW",
  confidentiality-marker: (display: true),
  // for more options check the package documentation (https://typst.app/universe/package/clean-dhbw)
)

#cite(<Madje_Typst>, form: none)

// Edit this content to your liking

= Einleitung

#todo("Hier kann man ein ToDo nutzen") \
Dieses Projekt wurde mit @Madje_Typst erstellt. \
#lorem(100)

#lorem(80)

#lorem(120)

= Erläuterungen

Im folgenden werden einige nützliche Elemente und Funktionen zum Erstellen von Typst-Dokumenten mit diesem Template erläutert.

== Mathe
Eine Gleichung mit Caption einfügen:
#equation(caption: "Meine Gleichung 1", label: <gleichung1>, $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $)

Ohne Caption kann die Gleichung direkt verwendet werden:
$
  7.32 beta +
  (i=0)^nabla Q_i / 2 + 1 / 2
$

Die Gleichung kann auch im Formelverzeichnis auftauchen und ein Label erhalten, siehe:
#equation(
  caption: "Meine Gleichung 4",
  label: <meineTolleGleichung>,
  $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $,
)

Ohne Caption und mit Label geht auch:
#equation(
  label: <meineTolleGleichung2>,
  $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $,
)
#equation($ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $)

== Abkürzungen

Verwende die `acr`-Funktion und deren Geschwister `acrpl`, `acrs` und `acrspl`, um Abkürzungen aus dem Abkürzungsverzeichnis einzufügen. Beispiele dafür sind:

- #ac("HTTP") – `ac`: Singular mit Erläuterung
  - #ac("HTTP") – `ac`: aber die Erläuterung wird nur bei der ersten Verwendung angezeigt
- #aclp("API") – `acpl`: Plural mit Erläuterung
- #acs("REST") - `acs`: Singular ohne Erläuterung
- #acsp("API") – `acspl`: Plural ohne Erläuterung

Alle Möglichkeiten, wie Acronyme definiert und aufgerufen werden können:
- Normal call: #ac("REST")
- Normal call: #ac("REST")
- Plural: #acp("REST")
- Short: #acs("REST")
- Short Plural: #acsp("REST")
- Long: #acl("REST")
- Long Plural: #aclp("REST")
- Normal call: #ac("HTTP")
- Plural: #acp("HTTP")
- Short: #acs("HTTP")
- Short Plural: #acsp("HTTP")
- Long: #acl("HTTP")
- Long Plural: #aclp("HTTP")
- Normal call: #ac("SPS")
- Normal call: #ac("SPS")
- Plural: #acp("SPS")
- Short: #acs("SPS")
- Short Plural: #acsp("SPS")
- Long: #acl("SPS")
- Long Plural: #aclp("SPS")

== Listen

Es gibt Aufzählungslisten oder nummerierte Listen:

- Dies
- ist eine
- Aufzählungsliste

+ Und
+ hier wird
+ alles nummeriert.

== Abbildungen und Tabellen

Abbildungen und Tabellen (mit entsprechenden Beschriftungen) werden wie folgt erstellt.

=== Abbildungen

#figure(caption: "Eine Abbildung", image(width: 4cm, "assets/ts.svg"))
#figure(caption: "Eine Abbildung", image(width: 4cm, "assets/ts.svg"))

=== Tabellen

#figure(
  caption: "Eine Tabelle",
  table(
    columns: (1fr, 50%, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [],
      [*Area*],
      [*Parameters*],
    ),

    text("cylinder.svg"),
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    text("tetrahedron.svg"), $ sqrt(2) / 12 a^3 $, [$a$: edge length],
  ),
)<table>

== Programm Quellcode

Quellcode mit entsprechender Formatierung wird wie folgt eingefügt:

#figure(
  caption: "Ein Stück Quellcode 1",
  sourcecode[```ts
    const ReactComponent = () => {
      return (
        <div>
          <h1>Hello World</h1>
        </div>
      );
    };

    export default ReactComponent;
    ```],
)

Das `supplement` Argument überschreibt, als was die `figure` in der Caption bezeichnet wird.
Der Default ist hier gezeigt:
#figure(
  caption: "Ein Stück Quellcode 2",
  sourcecode[```ts
    const ReactComponent = () => {
      return (
        <div>
          <h1>Hello World</h1>
        </div>
      );
    };

    export default ReactComponent;
    ```],
)

== Verweise

Für Literaturverweise verwendet man die `cite`-Funktion oder die Kurzschreibweise mit dem \@-Zeichen:
- `#cite(form: "prose", <iso18004>)` ergibt: \ #cite(form: "prose", <iso18004>)
- Mit `@iso18004` erhält man: @iso18004
- Seitenangabe ist mit @iso18004[S.~17] möglich

Tabellen, Abbildungen und andere Elemente können mit einem Label in spitzen Klammern gekennzeichnet werden (die Tabelle oben hat z.B. das Label `<table>`). Sie kann dann mit `@table` referenziert werden. Das ergibt im konkreten Fall: @table

Ein Verweis auf @anhang:secondAppendix.

= Fazit

#lorem(50)

#lorem(120)

#lorem(80)

= Wiederholungen um Numbering zu testen

== Code
#figure(
  caption: "Ein Stück Quellcode 3",
  sourcecode[```ts
    const ReactComponent = () => {
      return (
        <div>
          <h1>Hello World</h1>
        </div>
      );
    };

    export default ReactComponent;
    ```],
)

== Gleichungen
#equation(
  caption: "Meine Gleichung",
  label: <mitternachtsformel>,
  $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $,
)

#equation(
  caption: "Meine Gleichung",
  label: <gleichungUnten2>,
  $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $,
)

$ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $
$ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $

#equation(
  caption: "Meine Gleichung",
  label: <gleichungUnten5>,
  $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $,
)

In @mitternachtsformel ist die Mitternachtsformel zu sehen.

== Tabelle
#figure(
  caption: "Eine Tabelle",
  table(
    columns: (1fr, 50%, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [],
      [*Area*],
      [*Parameters*],
    ),

    text("cylinder.svg"),
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    text("tetrahedron.svg"), $ sqrt(2) / 12 a^3 $, [$a$: edge length],
  ),
)

== Bilder
#figure(caption: "Eine Abbildung mit sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr sehr langer Caption", image(width: 4cm, "assets/ts.svg"))
#figure(caption: "Eine Abbildung", image(width: 4cm, "assets/ts.svg"))
