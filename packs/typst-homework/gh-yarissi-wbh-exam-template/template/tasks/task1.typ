#import "../../src/lib.typ": solution, task

#task(points: 10, title: "Compiler vs. Interpreter")[
  *Erklären Sie den Unterschied zwischen Compiler und Interpreter. Nennen Sie jeweils zwei Vor- und Nachteile.*
]

#solution[
  Ein *Compiler* übersetzt den gesamten Quellcode vor der Ausführung in Maschinencode (vgl. @gnd01[Kap.~2.1]).
  - *Vorteil:* Schnellere Ausführung des resultierenden Programms.
  - *Vorteil:* Compiler können globale Optimierungen durchführen.
  - *Nachteil:* Der Kompilierungsschritt braucht Zeit.
  - *Nachteil:* Fehler werden erst beim Kompilieren (nicht zur Laufzeit) sichtbar.

  Ein *Interpreter* führt den Quellcode Zeile für Zeile direkt aus (vgl. @gnd01[Kap.~2.2]).
  - *Vorteil:* Einfacheres Debugging und Testen ("REPL").
  - *Vorteil:* Plattformunabhängigkeit (sofern der Interpreter verfügbar ist).
  - *Nachteil:* Langsamere Ausführung.
  - *Nachteil:* Fehler treten erst zur Laufzeit auf.
]
