= Pravidelnými ovce dosavadní
#lorem(110)

#lorem(20)

$ (sum_(n=0)^infinity a_n b_n)^2 lt.eq sum_(n=1)^infinity a_n^2 dot sum_(n=1)^infinity b_n^2 #<eq:G> $

hloupá životem elektromagnetických doma, budou 750 informace oblast k různé vede doprovází i zdarma vědní. O plíseň co ležela

$ (x+y)^3  &=  (x + y) (x + y)^2 #<eq:H> \
           &=  (x + y) (x^2 + 2x y + y^2) #<equate:revoke> \
           &=  x^3 + 3x^2y + 3x y^2 + y^3 #<eq:I> $



#lorem(130)

#import "../src/sub.typ": sub_fig


#figure(
[
    #grid(
      columns: (1fr, 1fr),
      align: center + bottom,

    sub_fig(first: true)[
      #figure(
        image("../figures/fig_A.svg", width: 60mm),
        caption: [neorientovaný graf],
      ) <Subfig1>
    ],

    sub_fig()[
      #figure(
        image("../figures/fig_B.svg", width: 60mm),
        caption: [reprezentace grafu],
      ) <Subfig2>
    ],    
  )
    
],
caption: [Ukázkový obrázek se dvěma podobrázky]
) <TopLevelFigureLabel>

#lorem(210)

#lorem(110)

== Týmem nenavrtávat vkusné uherské <Uherske>
#lorem(110) 

#lorem(130)




#import "@preview/tblr:0.4.2": *


#figure(
  table(
    columns: 6,
    align: center,
    column-gutter: 1em,
    table.hline(stroke: 1pt),
    [], [], table.cell(colspan: 2)[Algoritmus 1], table.cell(colspan: 2)[Algoritmus 2],
    table.hline(start: 2, end: 6),
    [Pokus \#], [$alpha$], [$beta$], [$gamma$], [$delta$], [$chi$],
    table.hline(),
    [1], [20.7141], [50.0798], [-91], [-10], [70.905],
    [2], [71.8653], [-54.2], [-48.7], [11.536], [33.551],
    [3], [50.3331], [-53.63], [-10], [-14.9], [-98],
    [4], [-68.988], [87.2712], [-89.74], [-30], [-9.47],
    [5], [7.93456], [77.214], [55.457], [-57.5], [-13.2],
    [6], [-14.68], [59.108], [23.62571], [-10], [68.548],
    [7], [18.498], [80.002], [4.888], [44.909], [-50],
    [8], [3.746], [25.59786], [99.8605], [-80.8], [23.9323],
    [9], [46.7614], [85.043], [-95], [8.5701], [49.5099],
    [10], [-58.8], [-38.8], [87.8912], [98.18994], [-94.4],
    table.hline(stroke: 1pt),
  ),
  caption: [Exprimentální výsledky],
)




#context{

  [#tblr(header-rows: 2, columns: 6, placement: none,
    stroke: none,
    // combine header cells
    cells((0, (2,4)), colspan: 1, stroke: (bottom: 0.5pt)),
    column-gutter: 0.5em,
    // booktabs style rules
    rows(within: "header", auto, inset: (y: 0.5em)),
    //rows(within: "header", auto, align: center),
    hline(within: "header", y: 0, stroke: 1pt),
    hline(within: "header", y: end, position: bottom, stroke: 0.5pt),
    rows(within: "body", 0, inset: (top: 0.5em)),
    hline(y: end, position: bottom, stroke: 1pt),
    rows(end, inset: (bottom: 0.5em)),
    //table notes, remarks, and caption
    //note((1, (1,4)), [$m v$ is in kg·m².]),
    //note((1, (3,6)), [Time is in secs.]),
    //note(sym.dagger, (2, 0), [Another note.]),
    //remarks: [_Note:_ ] + lorem(18),
    caption: [Experimentální výsledky],
    //note-fun: x => super(text(fill: blue, x)),
    col-apply(within: "body", span(1, end), decimal-align.with(decimal: regex("\,\d"))),

  

    [], [], table.cell(colspan: 2)[Algoritmus 1], table.cell(colspan: 2)[Algoritmus 2],

    [Pokus \#], [$alpha$], [$beta$], [$gamma$], [$delta$], [$chi$],

    [1], [20,7141], [50,0798], [-91], [-10], [70,905],
    [2], [71,8653], [-54,2], [-48,7], [11,536], [33,551],
    [3], [50,3331], [-53,63], [-10], [-14,9], [-98],
    [4], [-68,988], [87,2712], [-89,74], [-30], [-9,47],
    [5], [7,93456], [77,214], [55,457], [-57,5], [-13,2],
    [6], [-14,68], [59,108], [23,62571], [-10], [68,548],
    [7], [18,498], [80,002], [4,888], [44,909], [-50],
    [8], [3,746], [25,59786], [99,8605], [-80,8], [23,9323],
    [9], [46,7614], [85,043], [-95], [8,5701], [49,5099],
    [10], [-58,8], [-38,8], [87,8912], [98,18994], [-94,4],

  ) <ExpResults>]

}


#lorem(110)

#lorem(50)