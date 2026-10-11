#import "../lib.typ": *

#show: lebenslauf.with(
  name: "Max Mustermann",
  adresse: "Musterstraße 1, 12345 Musterhausen",
  telefonnummer: "1234 56789",
  email: "max@mustermann.de",
)

== Praktische Erfahrung
#arbeit(
  jobtitel: "Barista",
  firma: "Starbucks",
  anfangsdatum: datetime(day: 01, month: 01, year: 2020),
  enddatum: none,
)
- Hab halt Kaffee gemacht

== Schulbildung
#bildung(
  einrichtung: "Gymnasium Musterstadt",
  abschluss: "Abitur",
  anfangsdatum: datetime(day: 01, month: 01, year: 2006),
  enddatum: datetime(day: 01, month: 01, year: 2016),
)

== Persönliche Fähigkeiten und Kompetenzen
- *Kochen*: Kann gut kochen
