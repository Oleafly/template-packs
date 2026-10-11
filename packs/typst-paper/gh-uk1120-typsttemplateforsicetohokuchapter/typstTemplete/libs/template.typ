#let key(key, key2) = {
  text(9.5pt, weight: "regular")[#key]
  text(10pt, weight: "regular")[(#key2)]
}

#let address(num, address) = {
  text(11.5pt, weight: "bold")[
    連絡先:
  ]
  text(11pt, weight: "regular")[〒]
  text(10pt, weight: "regular")[#num]
  h(5pt)
  text(9.5pt, weight: "regular")[#address]
  linebreak()
}

#let information(tel, fax, email) = {
  text(11pt, weight: "regular")[Tel.: ]
  text(10pt, weight: "regular")[#tel]
  //h(10pt)
  //text(11pt, weight: "regular")[Fax.: ]
  //text(10pt, weight: "regular")[#fax]
  h(10pt)
  text(11pt, weight: "regular")[E-mail: ]
  text(10pt, weight: "regular")[#email]
  linebreak()
}
