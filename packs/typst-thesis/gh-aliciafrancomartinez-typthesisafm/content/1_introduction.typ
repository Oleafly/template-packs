
#import "../lib.typ": lettrine, note-box, prose, paren-cite, thesis-figure

= Introduction

#lettrine("A")quí empieza tu intro 

== *Título de la sección*
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac ex at purus lobortis mollis ut eget elit. Nunc auctor lacus sit amet augue efficitur, eu pellentesque dolor fringilla. Nullam sapien nunc, semper in convallis in, auctor sed quam. Ut ac est ac magna convallis hendrerit at vitae orci. Ut vehicula, elit sed lobortis porttitor, arcu magna volutpat purus, quis laoreet dolor purus sed felis. 



=== Título de la subsección
Seguimos escribiendo esta subsección blabla. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac ex at purus lobortis mollis ut eget elit. Nunc auctor lacus sit amet augue efficitur, eu pellentesque dolor fringilla. Nullam sapien nunc, semper in convallis in, auctor sed quam. Ut ac est ac magna convallis hendrerit at vitae orci.


==== Incluso título de la subsubsección, claro.
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac ex at purus lobortis mollis ut eget elit. Nunc auctor lacus sit amet augue efficitur, eu pellentesque dolor fringilla.


#pagebreak() //Con esto saltamos de página

Podemos mencionar una figura usando la etiqueta que va entre <> cuando la creamos (@significance).

#figure(
  [
    #set align(left)
    #image("../assets/1_figures_introduction/1_figure_significance.png", width: 9cm)
    #v(0.3em)
    #text(size: 10pt)[_Note_. Reproduced with explicit permission from the author. More of his artwork can be found at #link("https://www.davidparkins.com/")[davidparking.com].]
  ],
  caption: [Illustration by David Parkins]
)<significance>

También podemos hacer tablas y mencionarlas de la misma manera, como podemos ver en la @table_descriptives.

#thesis-figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    inset: 10pt,
    align: (left, center, center, center, center),
    stroke: none, // Removing all borders to add custom lines
    
    // Header lines
    table.hline(),
    [*Parameter*], [*Mean*], [*Standard deviation*], [*Min*], [*Max*],
    table.hline(stroke: 0.5pt),
    
    // Body rows
    [$beta_0$], [682.46], [138.34], [430.48], [1293.85],
    [$beta_1$], [10.50], [11.37], [-2.00], [47.18],
    [$beta_2$], [65.61], [45.59], [-25.75], [265.00],
    [$sigma_(R T)$], [103.43], [51.43], [30.58], [306.86],
    [$tau_(R T)$], [390.69], [141.48], [166.16], [1199.59],
    
    // Bottom line
    table.hline(),
  ),
  title: [Descriptive statistics for each parameter for the data from Vicente-Conesa et al. (2023)],
  kind: table
) <table_descriptives>

Hasta puedes poner etiquetas <> a los títulos de tus secciones para poder referenciarlas en el doc, por ejemplo: @replicating. Si clicas te lleva a esa sección.

=== Citas y referencias
Si quieres poner una cita entre paréntesis usa la función `paren-cite()`: #paren-cite(<franco-martinez2026>). Si quisieras añadir prefijos y sufijos a la cita, también puedes hacerlo #paren-cite(prefix: "e.g., ", <franco-martinez2026>, suffix: ", p. 45").

Si quieres hablar del estudio de #prose(<Mendel1865>), así, en prosa, usa la función `prose()`. También puedes ponerle suplementos después del año: #prose(<chang2004>, supp: "p. 22"). En inglés a veces queremos decir "In #prose(<cos2023>, ese: true) study", ese apóstrofe se añade con el argumento `ese: true`. 

    
=== Maquetado un poco más complejo...

Si queréis darle un toque más tipo libro a vuestro documento, podéis incluir las figuras a un lado del texto. Para ello, podemos usar la función `grid` que nos permite crear 
#grid(
  columns: (11fr, 12fr),
  column-gutter: 2em,
  [
    #figure(
  [
    #image("../assets/1_figures_introduction/1_figure_significance.png", width: 7cm)
    #set align(left)
    #v(0.3em)
    #text(size: 10pt)[_Note_. Reproduced with explicit permission from the author. More of his artwork can be found at #link("https://www.davidparkins.com/")[davidparking.com].]
  ],
  caption: [Illustration by David Parkins]
)<significance1>

  ],

  [ 
    #v(-7pt)
    dos o más columnas y continuar el texto dentro de la función.  
    
     Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac ex at purus lobortis mollis ut eget elit. Nunc auctor lacus sit amet augue efficitur, eu pellentesque dolor fringilla. Nullam sapien nunc, semper in convallis in, auctor sed quam. Ut ac est ac magna convallis hendrerit at vitae orci. Ut vehicula, elit sed lobortis porttitor, arcu magna volutpat purus, quis laoreet dolor purus sed felis. 
  ]
)