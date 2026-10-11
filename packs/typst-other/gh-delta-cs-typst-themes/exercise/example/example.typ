#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "../delta-exercise.typ": project, subtask, task

#show: project.with(
  title: "Ukázkový test",
  seminar: [CPR3/JS],
  date: datetime(
    day: 4,
    month: 09,
    year: 2026,
  ),
  // show-hints: true,
  // show-solutions: true,
)

#task(points: 2)[Datové struktury][][
  #subtask[
    Vysvětlete rozdíl mezi *polem* a *spojovým seznamem*. \
    U obou uveďte složitost operace #box[_vložení na začátek_].
  ]

  #v(4cm)

  #subtask[
    Kdy dává smysl použít *hašovací tabulku*? Uveďte alespoň *dvě* typické situace.
  ]

  #v(4cm)
][ // Solution
  #subtask[
    *Pole* má prvky uložené souvisle za sebou, přístup podle indexu je $cal(O)(1)$,
    ale vložení na začátek znamená posun všech prvků, tedy $cal(O)(n)$.

    *Spojový seznam* drží u každého prvku ukazatel na následníka. Vložení na začátek
    je pouhé přepojení ukazatele, tedy $cal(O)(1)$, zato přístup podle indexu je $cal(O)(n)$.
  ]

  #subtask[
    Hašovací tabulka se hodí tam, kde potřebujeme *rychlé vyhledání podle klíče*:

    - vyhledávací index (slovník, cache),
    - odstranění duplicit v datové sadě.
  ]
][ // Hints
  #subtask[
    Zamyslete se nad tím, co musí program udělat s ostatními prvky, když na začátek přibude nový.
  ]
]

#task(points: 3)[Predikce výstupu][Určete, co program vypíše, a vysvětlete proč.][
  #subtask[
    ```javascript
    const numbers = [1, 2, 3];
    const doubled = numbers.map(n => n * 2);
    console.log(numbers.length, doubled.length);
    ```
  ]

  #v(3cm)

  #subtask[
    ```javascript
    console.log(0.1 + 0.2 === 0.3);
    ```
  ]

  #v(3cm)
][ // Solution
  #subtask[
    Vypíše `3 3`. Metoda `map` původní pole *nemění*, vrací nové pole stejné délky.
  ]

  #subtask[
    Vypíše `false`. Čísla jsou uložena v plovoucí řádové čárce (IEEE 754),
    kde `0.1` ani `0.2` nemají přesnou binární reprezentaci.
  ]
][ // Hints
  #subtask[
    Mění `map` původní pole, nebo vrací nové?
  ]
]

#task(points: 3, extra: true)[Úprava spojového seznamu][][
  #subtask[
    Do následujícího seznamu vložte prvek `15` mezi `6` a `27`. \
    Nakreslete výsledný stav včetně ukazatelů.
  ]

  #v(0.5cm)

  #align(center)[
    #diagram(
      node-stroke: 1pt,
      node-shape: rect,
      spacing: (12mm, 10mm),
      node((0, 0), [`9`], name: <a>),
      node((1, 0), [`6`], name: <b>),
      node((2, 0), [`27`], name: <c>),
      node((3, 0), [`NULL`], stroke: none, name: <n>),
      edge(<a>, <b>, "->"),
      edge(<b>, <c>, "->"),
      edge(<c>, <n>, "->"),
    )
  ]

  #v(5cm)
][ // Solution
  #subtask[
    Nový uzel `15` převezme ukazatel uzlu `6` na uzel `27`, uzel `6` pak ukazuje na `15`:

    #align(center)[
      #diagram(
        node-stroke: 1pt,
      node-shape: rect,
        spacing: (12mm, 10mm),
        node((0, 0), [`9`], name: <a>),
        node((1, 0), [`6`], name: <b>),
        node((2, 0), [`15`], fill: rgb("#d4edda"), name: <x>),
        node((3, 0), [`27`], name: <c>),
        node((4, 0), [`NULL`], stroke: none, name: <n>),
        edge(<a>, <b>, "->"),
        edge(<b>, <x>, "->"),
        edge(<x>, <c>, "->"),
        edge(<c>, <n>, "->"),
      )
    ]

    *Pozor* na pořadí: nejdřív napojte nový uzel na `27`, teprve pak přepište ukazatel uzlu `6`.
  ]
][ // Hints
  #subtask[
    Kolik ukazatelů se musí změnit? A záleží na pořadí, v jakém je přepíšete?
  ]
]
