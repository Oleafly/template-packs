#import "dependencies.typ": *
#show: codly-init.with()
#codly(languages: codly-languages)

== Zusätzliche Materialien

Hier können zusätzliche Materialien wie detaillierte Daten, erweiterte Analysen, Codes, oder andere unterstützende Dokumente eingefügt werden.

=== Datenquellen

Detaillierte Informationen zu den verwendeten Datenquellen können hier aufgeführt werden.

==== Primärquellen

Liste der Primärquellen...

==== Sekundärquellen

Liste der Sekundärquellen...

=== Ergänzende Analysen

Weitere Analysen, die nicht in den Hauptteil der Arbeit passen, können hier dokumentiert werden.

==== Statistische Auswertungen

Zusätzliche statistische Daten und Auswertungen...

==== Grafiken und Diagramme

#figure(
  rect(width: 100%, height: 60pt, fill: gray.lighten(80%))[
    #align(center + horizon)[Beispieldiagramm - Hier würde ein echtes Diagramm stehen]
  ],
  caption: "Beispiel für ein Diagramm im Anhang",
)

=== Code-Beispiele

Falls Code-Beispiele relevant sind:

```javascript
function calculateBusinessMetrics(data) {
  return data.map(item => ({
    ...item,
    efficiency: item.output / item.input
  }));
}
```

```python
import pandas as pd
import matplotlib.pyplot as plt

def analyze_business_data(filename):
    df = pd.read_csv(filename)
    return df.describe()
```

== Fragebogen und Interviews

=== Fragebogen

Hier könnte der verwendete Fragebogen vollständig abgebildet werden.

=== Interview-Leitfaden

Der Interview-Leitfaden für qualitative Gespräche...

== Rohdaten

=== Umfrageergebnisse

Tabellarische Darstellung der Rohdaten...

=== Analyseergebnisse

Detaillierte Analyseergebnisse, die aufgrund des Umfangs nicht in den Hauptteil gehören.
