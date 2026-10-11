#import "../template.typ": code

= Introduction and Relevance<sec-intro>
Das ist ein Kapitel

== Research Question <sec-question>
Das ist ein Abschnitt.
Die Aussage bezieht sich auf diese Quelle @vaswaniAttentionAllYou2017.

Die Antwort dazu ist in @sec-conclusion.
Dieses Bild passt gut dazu @fig-dsr:
#figure(
  image("/img/dsr.svg", width: 80%),
  caption: [nette Caption],
  //placement: auto,
) <fig-dsr>

\
\

Und das _Ganze_ geht auch als *grid*:
#grid(
  columns: (2.0fr, 2.7fr), 
  column-gutter: 10pt,
  // Right column: Table in a Figure
  [

 
#figure(
  image("/img/dsr.svg", width: 100%),
  caption: [Token Pipeline in the Transformer architecture, own representation],
  //placement: auto,
) <fig-dsr2>
  ],

    [

oder auch als Liste:
#set list(indent: 2em)
#set enum(indent: 1em)
- eins 
 - zwei


#set enum(numbering: "1.1.", full: true)
+ eins
+ zwei
  + *Drei*
  + wasd
+ Vier
+ Fünf

#set list(indent: 0em)
#set enum(indent: 0em)





/* Formeln sind änlich zu Latex, aber nicht ganz gleich, evtl. nochmal nachschauen: https://typst.app/docs/reference/math/


übrigens, mehrzeiliger Kommentar geht mit alt+shift+a 
und Zeilenumbruch aktiviert man mit alt+z
 */
  ]
)
\ 

und Formeln gehen auch:

$ sum_(k=0)^n k
    &= 1 + ... + n \
    &= (n(n+1)) / 2 $

Mehr dazu steht in @appendix-system-prompt bzw. @lst:system-prompt. Und @llm kann man auch abkürzen. Im Plural ist das dann @llm:long\s bzw @llm\s bzw. @llm:short\s

#code(```python
print("Hello World")

```,
      caption: [hello world],
      supplement: [Code Snippet],

)

