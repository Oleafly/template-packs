#import "../_functions.typ": *
#show: codly-init.with()
#import "../_style.typ": *
#show: main // chapter spezifische Formatierung

= Tutorial

== Beispiel für Anwendung der in \_functions.typ definierten Funktionen

Beispiel um zu referenzieren: das ist code im anhang: @code_anhang
und das ist Code im Text: @code_text

Und hier verwende ich das Glossar: #gls("api")

Das in typst ( \` \` \` )  ohne die Leerzeichen dazwischen.

#codefigure(
    caption: "Code beispiel im Anhang",
    codeblock: [
    ```typc
    #import "../_functions.typ": *
    #show: codly-init.with()

    #codefigure(
        caption: "Code beispiel im Text",
        codeblock: [
            ` ` `rust
            pub fn main() {
                println!("Hello, world!");
            }
            ` ` `
        ]
    )
    ```
    ]
)

Ergibt das:

#codefigure(
    caption: "Code beispiel im Text",
    codeblock: [
    ```rust
    pub fn main() {
        println!("Hello, world!");
    }
    ```
    ]
) <code_text>

Beispiel für ein Bild:

#codefigure(
    caption: "Beispielbild",
    codeblock: [
    ```typc
    #import "../_functions.typ": *

    #imagefigure(
        caption: "beispielbild - dhsn logo",
        src: "figures/Logo_DHSN.png",
        height: 50pt
    )
    ```
    ]
)

ergibt das:

#imagefigure(
    caption: "beispielbild - dhsn logo",
    src: "figures/Logo_DHSN.png",
    height: 50pt
)

Beispiel für zwei Bilder nebeneinander:

#codefigure(
    caption: "Beispielbild",
    codeblock: [
    ```typc
    #import "../_functions.typ": *

    #twoimagesfigure(
        caption1: "Bild 1",
        caption2: "Bild 2",
        src1: "figures/Logo_DHSN.png",
        src2: "figures/Logo_DHSN.png",
        height: 50pt,
        width1: 30%,
        width2: 30%
    )
    ```
    ]
)

ergibt das:

#twoimagesfigure(
    caption1: "Bild 1",
    caption2: "Bild 2",
    src1: "figures/Logo_DHSN.png",
    src2: "figures/Logo_DHSN.png",
    height: 50pt,
    width1: 30%,
    width2: 30%
)

#pagebreak()

== Styling

Alle Stylings sind in der Datei \_style.typ definiert. Diese Datei wird in thesis.typ importiert und angewendet. Um die Kapitelspezifischen Stile anzuwenden, muss pro Kapitel.typ am Anfang stehen:
#codefigure(
    caption: "Kapitel spezifische Formatierung",
    codeblock: [
    ```typc
    #show: chapter
    ```
    ]
)

== Weitere Funktionalitäten

Alle weiteren Funktionalitäten von Typst sind hier zu finden: https://typst.app/docs/

== Beispiel Zitat

Das ist aus Harry Potter @harry
