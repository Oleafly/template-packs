#import "/common.typ":*
= Løsning
I denne seksjonen beskriver du hvordan hver deloppgave faktisk ble løst. Skriv i avsnitt og ha et eget avsnitt per deloppgave og plasser relevante elementer som da figurer, kodesnutter, og tabeller rett etter avsnittet de omtales i. Målet er at leseren skal tydelig se hva som er laget/gjort, hvordan det ble gjort og hvorfor bestemte valg og kommandoer var viktige. \\

For hvert delavsnitt, start med å skrive en kort forklaring av målet ("hva har du/dere laget eller oppnådd?"). Beskriv deretter fremgangsmåten, hva som måtte til for å få det til og hvordan det ble løst. Må også oppgi hvor informasjonen ble hentet og sitere dette.

== Figurer

=== Et bilde
#figure(image("images/due.jpg", width: 80%), caption: [
Fiber distrubusjons switch, som har et par fiberkabler koblet i seg i en haug, og en due som virker intressert i å se om det er muligt å spise noen av disse
]) @cit-fiber-optic @cit-TexBook

#figure(grid(
  columns: (1fr, 1fr),
// Calls to the figure() function have to be wrapped in [] if one wants to attach a lable
//https://github.com/typst/typst/discussions/4680
  [#figure(image("images/due.jpg", width: 90%), caption: [Figur Tekst 1]) <fig-subim1>],
  [#figure(image("images/due.jpg", width: 90%), caption: [Figur Tekst 2]) <fig-subim2>] ,
),   caption: [En figurtekst som gjelder for begge bildene både a og b.]
)<fig-image2>


== Tabell
#figure(table(
  columns:3,
[Col1],[Col2],[Col3],
[A],[B],[C],
[D],[E],[f]),
caption: [Eksempel Typst tabell]
) <tab-example>

== Listing
=== Python
#figure(caption:[Python eksempel kode for hvordan man bruke requests])[```python
from requests import requests

def getData(url: str):
  return requests.get(url).text()

print (getData("https://github.com/skandix.keys"))
```]<lst-eksempelkode>

#pagebreak()
