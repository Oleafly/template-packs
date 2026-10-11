#import "../hfu/lib.typ": *

= Einleitung

Dieses Kapitel zeigt, wie mit der Vorlage gearbeitet wird.
Sie eignet sich für Arbeiten an der #ac("HFU") und unterstützt unter anderem den Zitierstil des #ac("IEEE").
Bei weiteren Verwendungen wie #ac("HFU") erscheint nur noch die Kurzform.
Der eigene Text ersetzt den Beispieltext; die Formatierung ist bereits eingestellt und muss nicht angefasst werden.

Absätze werden durch eine Leerzeile getrennt und erhalten automatisch den Absatzabstand, den die Richtlinie in §1.2.6 verlangt.
Der Zeilenabstand ist 1,5-zeilig und die Vorlage verwendet standardmäßig Blocksatz.

== Aufbau von Unterkapiteln

Überschriften entstehen über `=`, `==` und `===`.
Die Nummerierung vergibt die Vorlage.
Das Inhaltsverzeichnis führt maximal drei Ebenen, wie es Tabelle 6 der Richtlinie vorgibt.

=== Dritte Gliederungsebene

Laut §3.8 darf ein Gliederungspunkt nie allein stehen: Wo es ein Kapitel 1.1.1 gibt, muss es auch ein Kapitel 1.1.2 geben.

=== Zitieren im Text

Quellen werden mit `@schlüssel` zitiert und landen automatisch im Literaturverzeichnis @knuth1984.
Mehrere Quellen lassen sich hintereinander angeben @weinberger2021 @hfu2024.
Im Literaturverzeichnis erscheinen laut §2.9.5 ausschließlich Quellen, die auch im Text verwendet wurden.

Direkte Zitate sind laut §3.6 sparsam einzusetzen.
Sie stehen in Anführungszeichen und werden bei mehr als zwei Zeilen zusätzlich eingerückt:

#quote(block: true, quotes: true, attribution: [@hfu2024[S. 10]])[
  Ein wörtliches Zitat erfolgt immer ohne jegliche Veränderung, im exakten Wortlaut und in der Originalsprache.
  Wörtliche Zitate sind in Anführungszeichen zu setzten.
]

== Fußnoten

Fußnoten werden mit `#footnote[…]` gesetzt.#footnote[Laut §3.9 sollte auf Fußnoten grundsätzlich verzichtet werden.]
Sie erscheinen automatisch in 10 pt.
