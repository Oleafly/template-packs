#import "../config/acronyms.typ": *
#import "../config/functions.typ": codeListing
#include "../config/config.typ"
// Examples (can be removed)
= Beispiele

Beispiele, können problemlos entfernt werden!

== Literatur
Beispiel Text @testBuch1[S. 10]
Beispiel Homepage @urlId

== Bilder



#figure(
  image("../resources/logo-dhbw.png", width: 30%),
  caption: [DHBW Logo @testBuch1[S. 10]]
) <abbildung>


Siehe #ref(<abbildung>) für das DHBW‑Logo.
#figure(
  image("../resources/logo-dhbw.png", width: 30%),
  caption: "DHBW Logo"
)
#figure(
  image("../resources/logo-dhbw.png", width: 30%),
  caption: "DHBW Logo"
) <abbildung2>
Siehe #ref(<abbildung2>) für das DHBW‑Logo.
#figure(
  image("../resources/logo-dhbw.png", width: 30%),
  caption: "DHBW Logo"
)
== Fußnote
Fußnote#footnote[Fußnote]

== Abkürzung
Die #acro("DHBW") wird bei der ersten Erwähnung ausgeschrieben und danach immer als #acro("DHBW") verwendet.

== Tabelle
#figure(
  table(
    columns: 3,
    [Spalte 1], [Spalte 2], [Spalte 3],
    [Zeile], [], [],
    [], [Zeile], [],
    [], [], [Zeile],
    align(right)[Verbunden], align(right)[Verbunden], [nicht Verbunden]
  ),
  caption: "Tabellenbeispiel"
)

== Code

=== C Beispiel
```c
printf("Inline Code");
```

=== Python Beispiel
```python
def example_function():
    """Example Python function"""
    print("Hello, world!")
    return 42
```

=== C++ Beispiel
```cpp
#include <iostream>
int main() {
    std::cout << "Hello, world!" << std::endl;
    return 0;
}
```

=== Java Beispiel
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, world!");
    }
}
```

=== Nummerierte Zeilen für Codebeispiel
Import aus einer externen Datei mit Zeilennummer offset:
#codeListing("../resources/examples/example.py", start: 6, end: 14, numberStart: 2, showBox: true)

== Referenzkapitel <Referenzkapitel>
Hier steht Text auf den referenziert werden soll.

== Weiteres Kapitel das auf das Referenzkapitel verweist
In diesem Kapitel wird auf das Referenzkapitel #ref(<Referenzkapitel>) verwiesen.

== Mathematische Formel

$
E = m c^2
$

Pi Chudnovsky Formel:

$
1 / pi = 12 / sqrt(640320) sum_(k = 0)^oo ((-1)^k (6k)! (13591409 + 545140134 k)) / ((3k)! (k!)^3 (640320)^(3k))
$


== TODOs
// TODO: Liste aller TODOs
