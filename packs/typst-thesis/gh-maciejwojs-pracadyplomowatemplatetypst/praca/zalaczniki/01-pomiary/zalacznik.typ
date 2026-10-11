#import "/szablon/template.typ": tabela, zalacznik

#zalacznik[Zestawienie danych pomiarowych][
  W załączniku umieszcza się obszerne zestawienia, algorytmy i rysunki, do których odsyła tekst główny. Każdy załącznik jest osobną całością i ma własny numer.

  #tabela(
    [Fragment serii pomiarowej],
    table(
      columns: 3,
      [Pomiar], [Napięcie [V]], [Prąd [A]],
      [1], [12,0], [0,24],
      [2], [12,0], [0,25],
    ),
    zrodlo: [opracowanie własne],
  )
]
