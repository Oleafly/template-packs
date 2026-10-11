= Tabellen

Als Beispiel wird in der Tabelle 1 die Entwicklung der Einwohnerzahl mit Hauptwohnsitz in der Stadt Leipzig angegeben.

#figure(
  caption: "Bevölkerungsentwicklung der Stadt Leipzig (Stadt Leipzig, Amt für Statistik und Wahlen, 2023).",
  table(
    columns: (auto, 1fr),
    inset: 10pt,
    table.header([Jahr], [Einwohner mit Hauptwohnsitz in Leipzig]),
    [2018], [596.517],
    [2019], [601.668],
    [2020], [605.407],
    [2021], [609.869],
  )
)

Alle Tabellen sind mit einer Überschrift zu versehen. Quellen sind in der Überschrift zu
vermerken.

= Abbildungen 

Alle Abbildungen sind mit einer Unterschrift zu versehen. Quellen sind in der Unterschrift zu vermerken:

- Direkte Übernahme einer Abbildung: (Autor, Jahr).
- Teilweise Übernahme (Abbildung nach Vorlage erstellt): nach (Autor, Jahr).
- Eigene Abbildungen sind nicht zu kennzeichnen

#figure(
  caption: "Schweben im Ultraschall (Siegmund, 2023).",
  image("../img/example-image.png", height: 6cm)
)

= Code Listings
Quellcode ist als Text einzufügen, Screenshots dürfen nicht verwendet werden. Die Verwendung von Syntaxhervorhebung (Syntax Highlighting) verbessert die Lesbarkeit, siehe Listing 1. Falls die verwendete Entwicklungsumgebung den Export von formatiertem Code nicht unterstützt, kann man Notepad++ verwenden (Ho, 2023).


#figure(
  caption: "Das Hello-World Programm in C (Kernighan und Ritchie, 2015).",
  ```c
  #include <stdio.h>
  int main(void)
  {
    printf("Hello, World!\n");
  }
  ```
)

In den Textteil gehören nur wichtige Ausschnitte. Längere Listings von Quellcode sind in
den Anhang aufzunehmen oder auf einem Datenträger mitzugeben. 

= Abkürzungen 

Abkürzungen sind im Text einzuführen und im Abkürzungsverzeichnis aufzuführen. Im Duden aufgeführte Abkürzungen müssen nicht eingeführt werden und sind nicht im Verzeichnis aufzuführen. Die Umgangssprache kennt den sogenannten Abkürzungsfimmel (Aküfi). Im Text der Arbeit selten verwendete Abkürzungen sollte man vermeiden, da die Lesbarkeit der Arbeit unter dem Aküfi leidet.

= Quellen


Die Programmiersprache Python stellt mit der Funktion `ord()` ein Werkzeug zur Verfügung, um den Unicode-Codepunkt eines einzelnen Zeichens zu ermitteln. Dies ermöglicht es, Zeichen programmgesteuert zu vergleichen oder zu sortieren. So liefert etwa der Ausdruck `ord('A')` den Wert `65`, was dem Unicode-Wert des Großbuchstabens „A“ entspricht. Diese Funktion gehört zu den sogenannten Built-in Functions von Python und ist standardmäßig verfügbar @ordDoc.