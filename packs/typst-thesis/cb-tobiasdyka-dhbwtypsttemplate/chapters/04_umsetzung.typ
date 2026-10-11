// =============================================================
// Kapitel 4 - Umsetzung
// =============================================================

= Umsetzung

== Systemarchitektur

...

== Implementierung

...

== Testen und Validierung

...

== Codebeispiele

=== Beispiel 1: Direkt aus dem Typst-Dokument

```python
def fakultaet(n):
    if n <= 1:
        return 1
    return n * fakultaet(n - 1)

print(f"5! = {fakultaet(5)}")
```

=== Beispiel 2: Code aus externer Datei

#raw(read("../assets/beispiel.java"), lang: "java")