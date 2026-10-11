#import "../../globals.typ": lightblue, lighterblue, mainblue
#import "../../utils/code.typ": code, code_cpp, code_py, code_yaml
#import "../../utils/analysis.typ": analyse_attribute_table, analyse_function_table
#import "../../utils/todo.typ": TODO

= Typst-Referenz für diese Vorlage <chap:kandidat2>

Dieses Kapitel demonstriert weitere Möglichkeiten der Vorlage.
Es dient als Nachschlagewerk und kann nach dem Ausfüllen gelöscht werden.

== Textformatierung

Typst unterstützt *Fettschrift*, _Kursivschrift_ und `Inline-Code`.
Fußnoten werden mit `#footnote[...]` gesetzt.#footnote[So sieht eine Fußnote aus — sie erscheint automatisch am Seitenende.]

Absätze werden durch eine Leerzeile getrennt.
Innerhalb eines Absatzes erzeugt ein einfacher Zeilenumbruch im Quelltext keinen neuen Absatz.

== Listen und Aufzählungen

Unsortierte Liste:
- Erster Punkt
- Zweiter Punkt
  - Eingerückter Unterpunkt
  - Noch ein Unterpunkt
- Dritter Punkt

Nummerierte Liste:
+ Schritt 1: Sensor initialisieren
+ Schritt 2: Messung starten
+ Schritt 3: Daten auswerten

Gemischte Aufzählung mit Inline-Inhalt:
/ Typst: Modernes Satzsystem, speziell für wissenschaftliche Dokumente.
/ LaTeX: Etabliertes System mit großem Ökosystem, steilere Lernkurve.
/ Word: Weit verbreitet, weniger geeignet für komplexe Formeln.

== Querverweise

Auf Abbildungen, Tabellen und Kapitel kann mit `@label` verwiesen werden.

- Abbildung aus Kapitel 1: @fig:k1-beispiel
- Tabelle aus Kapitel 1: @tab:k1-parameter
- Anderes Kapitel: @chap:kandidat1
- Gleichung aus Kapitel 1: @eq:k1-ohm

Literatur wird mit `@schluessel` zitiert — der Eintrag muss in `references.bib` vorhanden sein.
Beispiele mit den drei Einträgen aus dieser Vorlage: @stroustrup2013cpp, @arduino2024ref, @espressif2023esp32.

== YAML-Konfigurationsbeispiel

#code_yaml(
  caption: [Beispiel: Gerätekonfiguration],
  "device:
  name: Sensor-Node-01
  baudrate: 9600
  sampling_rate_hz: 10
  pins:
    sensor: 34
    led: 2",
)

== Komplexere Tabelle

Tabellen können mehrspaltigen Header und farbige Zeilen haben:

#figure(
  table(
    columns: (1fr, auto, auto, auto),
    inset: 6pt,
    stroke: none,
    fill: (x, y) => if y == 0 { mainblue } else if calc.odd(y) { lighterblue } else { lightblue },
    table.header([*Komponente*], [*Spannung*], [*Strom*], [*Leistung*]),
    [Mikrocontroller], [3,3 V], [80 mA], [0,26 W],
    [Sensor], [3,3 V], [12 mA], [0,04 W],
    [Display], [5,0 V], [150 mA], [0,75 W],
    [Gesamt], [—], [242 mA], [1,05 W],
  ),
  caption: [Leistungsbilanz der Komponenten],
) <tab:k2-leistung>

== Mathematische Gleichungen

Gleichungen werden in `$ ... $` gesetzt und automatisch nummeriert:

$ P = U dot I $ <eq:k2-leistung>

Mehrzeilige Gleichungen mit Ausrichtung:

$
  Q & = m dot c dot Delta T \
  W & = F dot s \
  P & = W / t
$ <eq:k2-physik>

Im Text wird auf @eq:k2-leistung und @eq:k2-physik verwiesen.

== Funktions- und Attributreferenz

#figure(
  analyse_function_table(
    [void],
    [setPWM(int pin, int duty)],
    [Setzt das PWM-Signal auf den gewünschten Tastgrad (0–100 %).],
    [int],
    [readVoltage(int pin)],
    [Liest die Spannung am ADC-Pin in Millivolt.],
    [bool],
    [isConnected()],
    [Gibt true zurück, wenn die Verbindung aktiv ist.],
  ),
  caption: [Steuermodul – Funktionsreferenz],
) <tab:k2-funktionen>

#figure(
  analyse_attribute_table(
    [int],
    [pwmPin],
    [GPIO-Pin-Nummer für das PWM-Signal.],
    [int],
    [dutyCycle],
    [Aktueller Tastgrad in Prozent (0–100).],
    [String],
    [deviceId],
    [Eindeutige Gerätekennung für die Kommunikation.],
  ),
  caption: [Steuermodul – Attributreferenz],
) <tab:k2-attribute>

== Ergebnisse

#TODO[
  - Was wurde gemessen, getestet oder verifiziert?
  - Abbildungen und Tabellen referenzieren: @tab:k2-leistung, @eq:k2-leistung.
]
