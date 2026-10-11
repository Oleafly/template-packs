= Analýza problému

#lorem(110) 

#figure(
  image("../figures/coffe_and_computer.jpg", width: 40%),
  caption: [Každodenní realita @AhDTEmY2CY7Qv65e],
) <WritingThesis>

#lorem(110)

#lorem(110)

#show figure: set block(breakable: true)

#figure(
  ```cpp
  // My first program in C++
  // Příšerně žluťoučký kůň úpěl ďábelské ódy
  #include <iostream>
  
  int main()
  {
    std::cout << "Hello World!";
  }
  ```,
  caption: [Program Hello world v jazyce C++],
) <CppListing>

/*
#figure(
  ```cpp
  // My first program in C++
  // Příšerně žluťoučký kůň úpěl ďábelské ódy
  #include <iostream>
  
  int main()
  {
    std::cout << "Hello World!";
  }
  ```,
  caption: [Program Hello world v jazyce C++],
) <CppListing>
*/
#figure(
  ```python
  # Python program Hello, World
  my_string = "Hello, World!"
  print(my_string)

  ```,
  caption: [Program Hello world v jazyce Python],
) <PythonListing>

#lorem(110)

== Důležití sezonní za úspěch





#import "../src/sub.typ": sub_table, sub_fig

#figure(
[
  #columns(2)[

    #sub_table(first: true)[
      #figure(
        table(
          columns: 2,
          align: (left, right),
          table.hline(),
          [Viverra], [Bibendum], 
          table.hline(),
          [integer lacinia], [10], 
          [autem vel eum], [25], 
          [velit esse], [4], 
          [tincidunt], [256], 
          table.hline(),
        ),
        caption: [velice malinká tabulka],
      ) <Subtable1>
    ]

    #colbreak()

    #sub_table()[
      #figure(
        table(
          columns: 3,
          align: (left, center, right),
          table.hline(),
          [Duis], [Esse], [Convallis],
          table.hline(),
          [donec vitae arcu], [e], [2,15],
          [elementum], [s], [3,00],
          [scelerisque], [t], [78,0],
          [vehicula], [t], [-1,15],
          [tempor], [u], [24],
          [placerat], [h], [13],
          table.hline(),
        ),
        caption: [o něco větší tabulka],
      ) <Subtable2>
    ]
    
    ]
    
],
caption: [Ukázka dvou velice malých tabulek a způsob, jak je sdružit dohromady]
) <TopLevelTableLabel>

Odkaz na tabulky @Subtable1[] @Subtable2[].

#lorem(150)

#lorem(150)

#lorem(150)

#figure(
[
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 1em,
      align: center + top,

    sub_fig(first: true)[
      #figure(
        rect(
          width: 20mm,
          height: 20mm,
        ),
        caption: [prázdný],
      ) <imA>
    ],

    sub_fig()[
      #figure(
        rect(
          width: 20mm,
          height: 20mm,
          fill: blue
        ),
        caption: [plný],
      ) <imB>
    ],

    sub_fig()[
      #figure(
        rect(
          width: 20mm,
          height: 20mm,
          fill: gradient.linear(red, green, angle: 45deg)
        ),
        caption: [s gradientem],
      ) <imC>
    ],

    sub_fig()[
      #figure(
        rect(
          width: 20mm,
          height: 20mm,
          stroke: (5pt + red),
          align(center + horizon)[#circle(radius: 5mm)]
        ),
        caption: [s kolečekm a tlustým čeveným okrajem],
      ) <imD>
    ],

    sub_fig()[
      #figure(
        rect(
          width: 20mm,
          height: 20mm,
          fill: luma(50),
          align(center + horizon)[#text(16pt, fill: white)[A]]
        ),
        caption: [s bílým písmenem na šedém pozadí],
      ) <imE>
    ],

    sub_fig()[
      #figure(
        rect(
          width: 20mm,
          height: 20mm,
          fill: teal,
          align(center + horizon)[#text(16pt, fill: white)[Typst]]
        ),
        caption: [s nápisem],
      ) <imF>
    ],
    
  )
    
],
caption: [Ukázka čtverců]
)

Odkazy na obrázky @imA[] @imB[] @imC[] @imD[] @imE[] @imF[].

#lorem(150)

+ #lorem(12)

+ #lorem(19)

 + #lorem(9)
 
 + #lorem(8)
 
 + #lorem(45)
 
    + #lorem(13)
    
    + #lorem(20)
    
    + #lorem(5)
    
      + #lorem(6)
      
      + #lorem(12)
      
      + #lorem(4)

+ #lorem(5)

+ #lorem(32)

+ #lorem(18)

+ #lorem(20)


#lorem(110)


== Bojovat výhodu zářivě i Nobel
#lorem(110)

- #lorem(45)

- #lorem(23)

- #lorem(4)

 - #lorem(53)
 
 - #lorem(12)

- #lorem(31)

#lorem(40) 

=== Hovoru ságy dá nebyly

#lorem(110)

#lorem(110)

#lorem(110)
