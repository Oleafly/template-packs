#show raw.where(block: true): c => block(
  {  
    show raw.line: line => {
      text(fill: black)[#line.number]
      h(1em)
      line.body
    }
    c
  }
)
#let raw_sv = f => raw(read(f), block: true, lang: "systemverilog")

= Template 3

#grid(columns: 3*(1fr,), align: (right, center, left),
  raw_sv("Codes/SystemVerilog/toto.sv"),
  raw_sv("Codes/SystemVerilog/toto.sv"),
  raw_sv("Codes/SystemVerilog/toto.sv")
)
#raw_sv("Codes/SystemVerilog/toto.sv")

== Exemple citing

@kumar2024radio @corneloup1999imaginaire @sorokin2006multiple