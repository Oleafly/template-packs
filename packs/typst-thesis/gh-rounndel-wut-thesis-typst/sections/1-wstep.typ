= Praefatio <praefatio>

#lorem(100) @goossens93

#figure(
  image("/img/logopw.png", width: 50%), 
  caption: [Tradycyjne godło Politechniki Warszawskiej])<fig:tradycyjne-logo-pw>

#lorem(50)
Reference to image @fig:tradycyjne-logo-pw. Lub gdy musimy odmienić - odwołanie do @fig:tradycyjne-logo-pw[Rysunku]. This is a list:
- Item 1:
  - item 1.1;
  - item 1.2;
- Item 2;
- Item 3.

And this is a numbered list:
+ Item 1:
  + item 1.1;
  + item 1.2:
    + item 1.2.1;
    + item 1.2.2;
  + item 1.3;
+ Item 2;
+ Item 3.

Lorem ipsum dolor sit amet #footnote[#lorem(20)] consectetur adipiscing elit.

#figure(
  table(
      columns: 3, 
      align: (center, center, right,), 
      table.header([Kolumna 1], [Kolumna 2], [Liczba]), 
      table.hline(), 
      [cell1], [cell2], [60], 
      [cell4], [cell5], [43], 
      [cell7], [cell8], [20,45], 
      table.cell(align: right, colspan: 2)[Suma#footnote[Footnote in table]], [123,45],
    ), 
    caption: [Przykładowa tabela], // Podpis pojawi się na górze bez względu na kolejność argumentów
)<tab:tabela1>

Lorem ipsum dolor sit amet.