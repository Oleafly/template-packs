#import "../lib.typ": *

= Third Chapter with Content <ch:thirdContentChapter>
In diesem Kapitel stellst du weitere Erkenntnisse fest.
Lege dich nicht auf eine strenge Anzahl an Kapiteln und Unterkapiteln fest, sondern teile den Inhalt deiner Arbeit sinnvoll auf.

Während der gesamten Arbeit solltest du Quellen benutzen.
Daher zeige ich hier kurz ein paar Beispiele für die Einbringung indirekter Zitate bezogen auf einen ganzen Absatz.

Der Vorteil des Betriebs in einem Container im Vergleich zu einer virtuellen Maschine ist der deutlich geringere Speicherbedarf.
Im Gegensatz zu virtuellen Maschinen muss ein Container in Docker nicht das gesamte System eines Computers per Software replizieren.
#cite(<oggl_docker_2023>, supplement: [p. 54f])

Zur Erstellung der Container, benötigt es eine unveränderliche Vorlage.
Diese Vorlage enthält alle Komponenten, die für die Ausführung der enthaltenen Anwendung erforderlich sind.
Die instanziierte, laufende Version dieser Vorlage wird als Container bezeichnet.
#cite(<docker_what_is_a_container>)

Zur Hervorhebung von Dateinamen (z.B. `.env`) kannst du texttt verwenden.
Auch kannst du Wörter durch kursive Schrift (z.B. _Button_) hervorheben.
Aber achte darauf, dass dies nicht Überhand nimmt und du konsequent deinen Stil beibehälst.

Auch Kommandozeilen-Befehle kann man so vom Text abheben:

#raw("python -m venv venv") \
#raw(".\\venv\\bin\\activate") \
#raw("pip install -r .\\requirements.txt")

Manchmal bietet es sich auch an, für die PDF-Version Links an bestimmten Stellen zu hinterlegen:
Beim Test wurde #link("https://github.com/getsentry/self-hosted/releases/tag/24.10.0")[Version 24.10.0] verwendet.

Nun noch ein Beispiel zum Einbau von kurzen Quellcode-Schnippseln in die Arbeit.
Achte dabei darauf, dass diese wirklich kurz sind, notwendig zum Verstehen des Textes sind und nur wenige Listings innerhalb der Arbeit vorkommen.
Ansonsten sollten diese besser in den Anhang gepackt werden und dorthin verwiesen werden.

#breakable-code-listing(
  caption: [Python-Aufruf der TH-Nuernberg efi-Website],
  label: <lst:pythonRequest>,
  ```python
import requests
response = requests.get('https://www.th-nuernberg.de/fakultaeten/efi/')
print(response.status_code)
  ```,
)