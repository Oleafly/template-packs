// chapters/00_erklaerung.typ
#import "../metadata.typ": meta

#pagebreak()
#heading(level: 1, numbering: none, outlined: false)[Erklärung]

Ich versichere hiermit, dass ich meine #meta.art mit dem Thema
#emph[#meta.titel]
selbstständig verfasst und keine anderen als die angegebenen Quellen und
Hilfsmittel benutzt habe.

#v(2cm)
#meta.ort, #meta.datum

#v(2cm)
#if meta.zeige-unterschrift [
  #image("../assets/signature.png", width: 4cm)
  #v(0.3em)
] else [
  #v(1.5cm)
]
#line(length: 6cm)
#meta.autor