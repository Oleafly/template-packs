// Blok kodu: kolory, numeracja linii, ramka.

#import "wspolne.typ": font-mono, polacz, stan-knobs

#let _hex(kolor) = {
  let zapis = kolor.to-hex()
  if zapis.starts-with("#") { zapis } else { "#" + zapis }
}

#let _motyw-kodu(paleta) = bytes(
  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple Computer//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\"><dict>
<key>name</key><string>zpi</string>
<key>settings</key><array>
<dict><key>settings</key><dict>
<key>foreground</key><string>"
    + _hex(paleta.kolor-tekstu)
    + "</string>
</dict></dict>
<dict><key>scope</key><string>comment</string><key>settings</key><dict>
<key>foreground</key><string>"
    + _hex(paleta.kolor-komentarza)
    + "</string>
</dict></dict>
<dict><key>scope</key><string>keyword, storage.type</string><key>settings</key><dict>
<key>foreground</key><string>"
    + _hex(paleta.kolor-slowa)
    + "</string>
</dict></dict>
<dict><key>scope</key><string>string</string><key>settings</key><dict>
<key>foreground</key><string>"
    + _hex(paleta.kolor-napisu)
    + "</string>
</dict></dict>
</array></dict></plist>",
)

#let _tekst-kodu(kod) = {
  let z = kod.replace("\r\n", "\n")
  if z.ends-with("\n") { z.slice(0, -1) } else { z }
}

// Kod w akapicie ma rozmiar tekstu. Zwykły napis łamie się na spacjach; `raw` jest jednym pudełkiem i rozpycha wiersz.
#let kod-w-akapicie(t) = text(font: font-mono, size: 1em, t)

// Reguły `show` są w zwykłej funkcji, nie w `context`, żeby nie obejmowały kodu poza blokiem.
#let _rysuj-kod(kod, jezyk, paleta, numery) = {
  set par(leading: 0.45em, spacing: 0pt, first-line-indent: 0pt, justify: false)
  set align(left)
  set text(font: font-mono, size: 1em, fill: paleta.kolor-tekstu, hyphenate: false)
  show raw: set text(font: font-mono, size: 1em)
  show raw.where(block: true): set block(breakable: true, width: 100%)
  show raw.line: it => {
    block(width: 100%, breakable: false)[
      #if numery {
        grid(
          columns: (2.4em, 1fr),
          column-gutter: 6pt,
          align: (right, left),
          text(size: 0.75em, fill: paleta.kolor-numeru)[#it.number],
          it.body,
        )
      } else {
        it.body
      }
    ]
  }
  let args = (block: true, theme: _motyw-kodu(paleta))
  if jezyk != none { args.insert("lang", jezyk) }
  let obrys = if paleta.ramka { 0.5pt + paleta.kolor-ramki } else { none }
  block(
    width: 100%,
    fill: paleta.tlo,
    stroke: obrys,
    inset: (x: 8pt, y: 6pt),
    breakable: true,
    raw(_tekst-kodu(kod), ..args),
  )
}

// `numeracja`: auto bierze knobs, true/false wymusza numery linii.
// `kolory`: słownik nadpisujący pola z knobs.kod, także `ramka` i `kolor-ramki`.
#let blok-kodu(kod, jezyk: none, numeracja: auto, kolory: (:)) = context {
  let paleta = polacz(stan-knobs.get().kod, kolory)
  let numery = if numeracja == auto { paleta.numeracja } else { numeracja }
  _rysuj-kod(kod, jezyk, paleta, numery)
}
