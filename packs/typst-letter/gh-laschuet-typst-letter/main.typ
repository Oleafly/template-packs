#import "letter.typ": letter

#show: letter.with(
  sender: [
    Vorname Nachname\
    Straße 23\
    12345 Ort
  ],
  return-address: [Vorname Nachname, Straße 23, 12345 Ort],
  recipient: [
    Zeile 1\
    Zeile 2\
    Zeile 3\
    Straße 1\
    12345 Ort
  ],
  location: [Ort],
  date: datetime.today(),
  subject: [Betreff],
)

Sehr geehrte Damen und Herren,

#lorem(11)

#lorem(41)

Mit freundlichen Grüßen
#v(2em)
Vorname Nachname

Anlagen
