#import "style/report.typ": *
#import "style/util.typ": terminal

#show: style.with(
  title: "typst template",
  authors: (
    (
      name: "n.takana",
      organization: [University of xxx, yyyyyyyyy],
      email: "name@xxx.ac.jp"
    ),
  ),
  abstract: none,
  index-terms: ("typst", "template", "report"),
  bibliography-file: none,
)

#let quote_block(body) = {
  block(
    width: 100%,
    fill: silver,
    inset: 8pt,
    body
  )
}

= Section
引用は以下．
#quote_block()[
  #lorem(20)
]

ターミナルは以下．
#terminal()[
  #lorem(20)
]


#lorem(50)

= Listing
列挙は以下の通り．
- xxx
- yyy
- zzz

数字の列挙は+を使う．
+ abc
+ def
+ ghi

= table
NAND の真理値表を @nand に示す．
#figure(
  table(
    stroke: none,
    columns: 3,
    table.hline(y: 1, start: 0),
    table.vline(x: 2, start: 0),
    [x], [y], [$overline(x dot y)$],
    [0], [0], [1],
    [0], [1], [1],
    [1], [0], [1],
    [1], [1], [0],
  ),
  caption: [NAND の真理値表],
)<nand>

複雑なテーブルを以下に示す．
#[
  #show table.cell.where(y: 0): set text(
    fill: white,
    weight: "bold",
  )

  #rotate(
    -90deg,
    reflow: true,
    figure(
      table(
        columns: 4,
        fill: (_, y) => if y == 0 {
          blue
        } else if calc.odd(y) {
          blue.lighten(85%)
        } else {
          blue.lighten(96%)
        },
        align: (horizon + left, horizon + left, horizon + left, horizon + left),
        table.header[][MOSFET][BJT][IGBT],
        [Drive method \ (Current or Voltage)], [Voltage], [Current], [Voltage],
        [Input Impedance (Low or High)], [High], [Low], [High],
        [Drive Power (Low or High)], [Low], [High], [Low],
        [Switching Speed \ (Slow, Medium, or Fast)], [Fast], [Slow], [Medium],
        [Operating Frequency \ (ex. 1KHz-100KHz)], [\- 1MHz], [200Hz - 10kHz], [\- 50kHz],
        [Saturation Voltage (Low or High)], [High], [Low], [Low],
        [Cost (Low, Medium, or High)], [Medium], [Low], [High],
        [Examples of USAGE \ (3 examples or more)], [power amplification, low to medium power switching, and in integrated circuits], [DAC Converters, Induction motor drivers, UPS], [inverters, motor drives, and power electronics],
      ),
      caption: [MOSFET，BJT，IGBT の特徴],
    )
  )
]

= Math
数式の例を@integral, @case に示す．
$
X(f) &= integral^infinity_(-infinity) w(t)e^(-j 2 pi f t) d t \
     &= integral^(T/2)_(-T/2) 1 times e^(-j 2 pi f t) d t \
     &= [ 1/(-j 2 pi f) e^(-j 2 pi f t)]^(T/2)_(-T/2) \
     &= 1/(-j 2 pi f) (e^(-j pi f T) - e^(j pi f T)) \
     &= 1/(-j 2 pi f) (e^(-j pi f T) - e^(j pi f T)) \
     &= 1/(pi f) sin (pi f T)
$<integral>
$
w(t) = cases(
  1\, |t| <= T/2,
  0\, "otherwise"
)
$<case>

ブール代数の例を@bool に示す．
$
  f &= overline(overline(overline(x) and x) and overline(overline(x) and y)) \
    &= overline(1 and overline(overline(x) and y)) \
    &= overline(overline(overline(x) and y)) \
    &= overline(x) and y 
$<bool>

= Code
```typst
#show raw.line: it => {
  box(
    width: 100%,
    align(horizon, stack(
      dir: ltr,
      box(
        width: 17pt,
        inset: (x: 7pt),
        align(right, text(white)[
            #it.number
        ]
      )),
      it.body,
    ))
  )
}
```

