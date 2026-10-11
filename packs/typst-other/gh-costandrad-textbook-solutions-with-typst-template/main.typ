#import "conf.typ": *
#import "utils.typ": *


#show: conf.with(
  author: [Igo da Costa Andrade],
  book: (
    title: [Mecânica Clássica],
    subtitle: none,
    year: 2013,
    press: "Bookman",
    address: "Porto Alegre",
    authors: (
      (
        name: "John R. Taylor",
        short-name: "Taylor, J. R.",
      ),
    ),
    chapter: (
      number: 0,
      title: "Título do capítulo"
    )
  ),
)



#let opts = (
  size: (5, 5), axis-style: "school-book", 

  x-tick-step: 1, y-tick-step: 1,
  x-grid: true, y-grid: "both",
)

#let line-styles = (stroke: 1.2pt+primary-color)
#let mark-styles(fill-color) = (stroke: 1.2pt+primary-color, fill: fill-color)

#v(1cm)

+ Determinie as assíntotas verticais da função $f(t) = sec(t)$.
  #solution([
    Lembrando que $sec(t) = 1/cos(t)$, a função $f(t)$ possui pontos de indeterminação nos valores de $t$ para os quais $cos(t) = 0$, ou seja, $f(t)$ não está definida para $t$ tal que:
    $ 
      cos(t) = 0 => t =  (2k + 1) pi/2, " para " k = 0, plus.minus 1, plus.minus 2, plus.minus 3, dots
    $

    #figure()[
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        plot.plot(
          size: (12, 6), axis-style: "school-book", 
          x-tick-step: none, y-tick-step: none, 
          {
            for i in range(6) {
              let k = 2*i - 5
              let l0 = (k - 1) * calc.pi/2
              let l1 = k * calc.pi/2
              let l2 = (k + 1) * calc.pi/2
              plot.add(
                samples: 100,
                domain: (l0, l1 - 0.2),
                x => 1/calc.cos(x),
                style: line-styles
              )
              plot.add(
                samples: 100,
                domain: (l1 + 0.2, l2),
                x => 1/calc.cos(x),
                style: line-styles
              )
              plot.annotate({
                line((k * calc.pi/2, 5), (k * calc.pi/2, -5), stroke: (dash: "dashed", paint: darkred))
              })

            }
            for j in range(-5, 6).filter(i => i != 0) {
                let k =  j * calc.pi/2
                plot.annotate({
                  line((k, 0.2), (k, -0.2))
                  if calc.rem(j, 2)==0 {
                    content((k, -0.3), [$script(#j""pi)$], anchor: "south", padding: "0.1", frame: "rect", stroke: none, fill: white)
                  } else {
                    if j == 1 {
                      content((k, -0.3), [$pi/2$], anchor: "south", padding: "0.25", frame: "rect", stroke: none, fill: white)
                    } else if j == -1 {
                      content((k -0.25, -0.3), [$- (pi)/2$], anchor: "south", padding: "0.25", frame: "rect", stroke: none, fill: white)
                    } else if j > 0 {
                      content((k, -0.3), [$(#j""pi)/2$], anchor: "south", padding: "0.25", frame: "rect", stroke: none, fill: white)
                    } else {
                      content((k -0.25, -0.3), [$-(#calc.abs(j)""pi)/2$], anchor: "south", padding: "0.25", frame: "rect", stroke: none, fill: white)
                    }
                  }
                })
            }
          }
        )
      })
    ]
  ])



+ Calcule os limites abaixo:
  #set enum(numbering: "(a)")
  + $display(lim_(x -> +infinity) ("sen" x)/x)$
    #solution([
      Partimos do fato de que a função $"sen" x$ é limitada:
      $
        -1 <= "sen" x <= 1
      $
      Como estamos tomando o limite $x$ tendendo a $+ infinity$, podemos multipliicar a desigualdade acima por $1\/x$ sem alterar o sentido das desigualdades:
      $
        -1 dot 1/x <= "sen" x dot 1/x <= 1 dot 1/x => -1/x <= ("sen" x)/x <= 1/x
      $
      Finalmente, tomamos o limite $x -> +infinity$ dos três termos na desigualdade:
      $
        lim_(x -> + infinity) (-1/x) <= lim_(x -> + infinity) ("sen" x)/x <= lim_(x -> + infinity) 1/x\
        0 <= lim_(x -> + infinity) ("sen" x)/x <= 0
      $
      Pelo teorema do confronto, 
      $
        lim_(x -> + infinity) ("sen" x)/x = 0
      $
    ])
  + $display(lim_(x -> -infinity) (x^2 + cos x)/(x^2 - 1))$
    #solution([
      $
        lim_(x -> -infinity) (x^2 + cos x)/(x^2 - 1) &= lim_(x -> -infinity) (cancel(x^2)(1 + display((cos x)/x^2)))/(cancel(x^2)(1 - display(1/x^2))) = (1 + display(lim_(x -> - infinity) (cos x)/x^2))/(1 - display(lim_(x -> -infinity)1/x^2 ))\
        &= 1 + lim_(x -> -infinity) (cos x)/x^2
      $
      O último limite pode ser demonstrado lembrando que a função $cos x$ é limitada. 
      $
        -1 <= cos x <= 1 &=> -1 dot (1/x^2) >= cos x dot (1/x^2) >= 1 dot (1/x^2) \
          &=> - 1/x^2 >= (cos x)/x^2 >= 1/x^2\
          &=> lim_(x -> -infinity) (- 1/x^2) >= lim_(x -> -infinity) (cos x)/x^2 >= lim_(x -> -infinity) 1/x^2\
          &=> 0 >=  lim_(x -> -infinity) (cos x)/x^2 >=0 
      $ 

      
      Pelo teorema do confronto, 
      $
        lim_(x -> - infinity) (cos x)/x = 0.
      $
      Portanto, 
      $
        lim_(x -> -infinity) (x^2 + cos x)/(x^2 - 1) = 1 + lim_(x -> -infinity) (cos x)/x^2 = 1
      $
    ])

  + $display(lim_(x -> -infinity) sqrt(x^2 + "sen" x)/x)$
    #solution([
      $
        lim_(x -> -infinity) sqrt(x^2 + "sen" x)/x &= lim_(x -> -infinity) sqrt(x^2 (1 + display(("sen" x)/x^2)))/x = lim_(x -> - infinity) (sqrt(x^2) sqrt(1 + display(("sen" x)/x^2)))/x\
        &= lim_(x -> - infinity) (|x| sqrt(1 + display(("sen" x)/x^2)))/x = lim_(x -> - infinity) (-cancel(x) sqrt(1 + display(("sen" x)/x^2)))/cancel(x)\
        &= lim_(x -> - infinity)  sqrt(1 + display(("sen" x)/x^2))\ 
        &= sqrt(1 + 0)\
        & = 1 
      $
      A desmonstração de que $display(lim_(x -> -infinity) ("sen" x)/x^2) = 0$ é idêntica ao caso $display(lim_(x -> -infinity) (cos x)/x^2)$ mostrado no item anterior.
    ])

+ Resolva os problemas abaixo:
    #set enum(numbering: "(a)")
    + A velocidade de um paraquedista é dada por $v(t) = 60(1 - e^(-0,2 t))$ m/s. Qual é a velocidade terminal?
      #solution([
        $
          v_t = lim_(t -> +infinity) v(t) &= lim_(t -> + infinity) 60(1 - e^(-0,2 t)) = 60 "m/s"
        $
      ])

    + A carga de um capacitor é dada por $Q(t) = 500 (1 - e^(-t/5))$ $mu"C"$. Qual é a carga final do capacitor?
      #solution([
        $
          Q_"final" = lim_(t -> + infinity) Q(t) = lim_(t -> + infinity) 500 (1 - e^(-t/5)) = 500 " "mu"C"
        $
      ])
    
    + Em um movimento mass-mola amortecido, a posição é dada por $x(t) = 3e^(-0.1t) cos(2t)$ cm. Qual é a posição limite quanto $t -> + infinity$?
      #solution([
        $
          x_"limite" = lim_(t -> +infinity) x(t) &= lim_(t -> +infinity) 3e^(-0.1t) cos(2t)
        $
        Para resolver o limite acima, lembremos que a função cosseno é limitada. Então,
        $
          -1 <= cos(2t) <= 1 &=> -1 dot (3e^(-0,1t)) <= cos(2t) dot (3e^(-0,1t)) <= 1 dot (3e^(-0,1t))\
          &=> - 3e^(-0,1t) <= 3e^(-0,1t) cos(2t)  <= 3e^(-0,1t)\
          &=> lim_(t -> +infinity) (- 3e^(-0,1t)) <= lim_(t -> +infinity) 3e^(-0,1t) cos(2t) <= lim_(t -> +infinity) 3e^(-0,1t)\
          &= 0 <= lim_(t -> +infinity) 3e^(-0,1t) cos(2t) <= 0
        $
        Pelo teorema do confronto, $display(lim_(t -> +infinity) 3e^(-0,1t) cos(2t)) = 0$. Portanto, $x_"limite" = 0 " cm"$.
      ])

+ Calcule os limites abaixo:
  #set enum(numbering: "(a)")
  + $display(lim_(x -> +infinity) e^(-2x))$
    #solution([
      $
        lim_(x -> +infinity) e^(-2x) = lim_(x -> +infinity) 1/e^(2x) = 0
      $
    ])

  + $display(lim_(x -> +infinity) ln x)$
    #solution([
      Seja $f(x) = e^x$ e a inversa $f^(-1)(x) = ln x$. Sabemos que:
      #figure()[
        #cetz.canvas({
          import cetz.draw: *

          content((0, 0), [$ lim_(x -> #text(darkred)[$+infinity$]) e^x = #text(primary-color)[$+infinity$]  ==> lim_(x -> #text(primary-color)[$+infinity$]) ln x = #text(darkred)[$+infinity$] $])

          line((-.8, -0.1), (-.8, -1), (1, -1), (1, -0.3), stroke: primary-color, mark: (end: ">>", fill: primary-color))

          line((-2.55, -0.3), (-2.55, -1.5), (3, -1.5), (3, -0.1),  stroke: darkred, mark: (end: ">>", fill: darkred))
        })
      ]
    ])

  + $display(lim_(x -> +infinity) "arctan" x)$
    #solution([
      Seja $f(x) = tan x$ e a inversa $f^(-1)(x) = "arctan" x$. Sabemos que:
      #figure()[
        #cetz.canvas({
          import cetz.draw: *

          content((0, 0), [$ lim_(x -> #text(darkred)[$+pi\/2$]) tan x = #text(primary-color)[$+infinity$]  ==> lim_(x -> #text(primary-color)[$+infinity$]) "arctan" x = #text(darkred)[$+ pi/2$] $])

          line((-.84, -0.1), (-.84, -1), (1.15, -1), (1.15, -0.4), stroke: primary-color, mark: (end: ">>", fill: primary-color))

          line((-3.2, -0.5), (-3.2, -1.5), (4, -1.5), (4, -0.4),  stroke: darkred, mark: (end: ">>", fill: darkred))
        })
      ]
    ])

  + $display(lim_(x -> +infinity) "arccotg" x)$
    #solution([
      Seja $f(x) = "cotg" x$ ($DD = {x in RR | 0 < x < pi}$ e $II = RR$) e a inversa $f^(-1)(x) = "arccotg" x$ ($DD = RR$ e $II = {x in RR | 0 < x < pi}$). Sabemos que:
      #figure()[
        #cetz.canvas({
          import cetz.draw: *

          content((0, 0), [$ lim_(x -> #text(darkred)[$0^+$]) "cotg" x = #text(primary-color)[$+infinity$]  ==> lim_(x -> #text(primary-color)[$+infinity$]) "arccotg" x = #text(darkred)[$0$] $])

          line((-.75, -0.1), (-.75, -1), (1.2, -1), (1.2, -0.3), stroke: primary-color, mark: (end: ">>", fill: primary-color))

          line((-3.35, -0.4), (-3.35, -1.5), (3.82, -1.5), (3.82, -0.1),  stroke: darkred, mark: (end: ">>", fill: darkred))
        })
      ]
    ])

  #v(10cm)
+ Determine todas as assíntotas (verticais e horizontais) das funções abaixo:

#rect(
  fill: primary-color.transparentize(80%),
  radius: 5pt,
  inset: 20pt,

  )[


    #align(center)[*Critérios para Determinação de\ Assíntotas Verticais e Horizontais*]

    #v(0.5cm)

      #set enum(numbering: "i.")
      + *Assíntotas Verticais*
        - Identificar candidatos, isto é, valores de $x$ para os quais a função não está definida. Por exemplo:
          - o denominador se anula;
          - o argumento de logaritmos é nulo ou negativo;
          - o radicando de raízes de índice par é negativo.
        - Para cada candidato $x = a$, determinar os limites laterais:
          - $display(lim_(x -> a^-) f(x))$
          - $display(lim_(x -> a^+) f(x))$
        - Verificar *divergência*: se pelo menos um dos limites laterais for $+infinity$ ou $-infinity$, então a reta $x = a$ é uma assíntota vertical.

      + *Assíntotas Horizontais*
        - Determinar os limites no infinito:
          - $display(lim_(x -> +infinity) f(x))$
          - $display(lim_(x -> -infinity) f(x))$
        - Verificar *convergência*: se algum dos limites existir for um número real finito $L$, então a reta $y = L$ é uma assíntota horizontal.
]

  #set enum(numbering: "(a)")
  + $f(x) = display(2e^x)/(e^x + 1)$
    #solution([
      #set enum(numbering: "i.")
      + Assíntotas Verticais: Não existem, pois a função $f$ está definida para todo $x in RR$
      + Assíntotas Horizontais:
        - Limites no infinito:
        
          $
            lim_(x -> + infinity) f(x) &= lim_(x -> + infinity) (2e^x)/(e^x + 1) = lim_(x -> + infinity) (2 cancel(e^x))/(cancel(e^x)(1 + display(1/(e^x)))) = lim_(x -> +infinity) 2/(1 + display(1/(e^x)))\
            &= 2/(1 + display(lim_(x -> + infinity) 1/e^x)) = 2/(1 + 0) = 2
          $

          $
            lim_(x -> - infinity) f(x) &= lim_(x -> - infinity) (2e^x)/(e^x + 1) = lim_(x -> - infinity) (2 cancel(e^x))/(cancel(e^x)(1 + display(1/(e^x)))) = lim_(x -> -infinity) 2/(1 + display(1/(e^x))) = lim_(x -> -infinity) 2/(1 + e^(-x))\
            &= 2/(1 + display(lim_(x -> - infinity) e^(-x))) = 0
          $
          pois $display(lim_(x -> -infinity) e^(-x)) = +infinity$.

      Portanto, a função $f$ não possui assíntotas verticais, mas possui os seguintes assíntotas horizontais:
        - $y = 2$ quando $x -> +infinity$, e
        - $y = 0$ quando $x -> -infinity$,
      como ilustra o gráfico abaixo:

      #figure()[
        #cetz.canvas({
          import cetz.draw: *
          import cetz-plot: *

          plot.plot(
            size: (10, 5),
            axis-style: "school-book", 
            x-tick-step: 2, y-tick-step: 1, 
            y-min: 0, y-max: 2.,
            
            legend: (0, 4.9),
            legend-style: (stroke: none, fill: primary-color.mix((white, 700%))),

            {
              plot.add(
                samples: 100, 
                domain: (-6, 6), 
                x => 2*calc.exp(x)/(calc.exp(x) + 1),
                style: line-styles,
                label: [$script(f(x) = 2e^x\/(e^x + 1))$]
              )
              plot.add-hline(
                0, 
                label: [$script(y = 0)$],
                style: (stroke: (dash: "dotted", paint: darkred, thickness: 1.5pt))
              )
              plot.add-hline(
                2, 
                label: [$script(y = 2)$],
                style: (stroke: (dash: "dashed", paint: darkred, thickness: 1.5pt))
              )
            }
          )
        })
      ]




    ])

  + $g(x) = display((x^2 - 1)/(x^3 + x))$
    #solution([
      #set enum(numbering: "i.")
      + Assíntotas Verticais: 
        - Pontos em que o denominador se anula:
          $
            x^3 + x = 0 => x (x^2 + 1) = 0 => x = 0
          $
        - Determinar os limites laterais para o candidato $x = 0$
          - Caso $x -> 0^-$
            $
              lim_(x -> 0^-) g(x) = lim_(x -> 0^-) (x^2 - 1)/(x^3 + x) 
            $
            Observemos que, quando $x -> 0^-$, o numerador tende a um valor netativo $-1$. Por sua vez, como estamos tomando $x < 0$,  o denominador $x^3 - x$ tende a zero, mas por valores também negativos. Assim, ao dividir o numerador negativo constante por valores negativos cada vez menores, o resultado é positivo e cresce indefinidamente. Portanto:
            $
              lim_(x -> 0^-) g(x) = lim_(x -> 0^-) (x^2 - 1)/(x^3 + x) = + infinity
            $

          - Caso $x -> 0^+$
            $
              lim_(x -> 0^+) g(x) = lim_(x -> 0^+) (x^2 - 1)/(x^3 + x) 
            $
            Observemos que, quando $x -> 0^+$, o numerador tende a um valor netativo $-1$. Por sua vez, como estamos tomando $x > 0$,  o denominador $x^3 - x$ tende a zero, mas por valores positivos. Assim, ao dividir o numerador negativo constante por valores positivos cada vez menores, o resultado é negativo e cresce indefinidamente. Portanto:
            $
              lim_(x -> 0^+) g(x) = lim_(x -> 0^+) (x^2 - 1)/(x^3 + x) = - infinity
            $
          Logo, como os dois limites laterais divergem, a reta $x = 0$ é uma assíntota vertical.



      + Assíntotas Horizontais:
        - Limites no infinito:
          - Caso $x -> + infinity$:
            $
              lim_(x -> + infinity) g(x) &= lim_(x -> + infinity) (x^2 - 1)/(x^3 + x) = lim_(x -> + infinity) (cancel(x^3)(1/x - 1/x^2))/(cancel(x^3)(1 + 1/x^2)) = lim_(x -> + infinity) (1/x - 1/x^2)/(1 + 1/x^2)\
              &= lim_(x -> + infinity) ((1/x) (1 - 1/x))/(1 + 1/x^2) = 0^+
            $
            Note que, auando $x -> + infinity$, os termos $1 - 1/x$ e $1 + 1/x^2$ tendem ao valor constante positivo igual a $1$. Por sua vez, $1/x$ tende a zero por valores positivos. Logo, o limite tende a $0^+$.

          - Caso $x -> - infinity$:
            $
              lim_(x -> - infinity) g(x) &= lim_(x -> - infinity) (x^2 - 1)/(x^3 + x) = lim_(x -> - infinity) (cancel(x^3)(1/x - 1/x^2))/(cancel(x^3)(1 + 1/x^2)) = lim_(x -> - infinity) (1/x - 1/x^2)/(1 + 1/x^2)\
              &= lim_(x -> - infinity) ((1/x) (1 - 1/x))/(1 + 1/x^2) = 0^-
            $
            Note que, auando $x -> - infinity$, os termos $1 - 1/x$ e $1 + 1/x^2$ tendem ao valor constante positivo igual a $1$. Por sua vez, $1/x$ tende a zero por valores negaticvos. Logo, o limite tende a $0^-$.

        Portanto, a função $g$ possui um assíntota vertical na reta $x = 0$ e assíntotas horizontais na reta $y = 0$, como ilustra o gráfico abaixo:

      #figure()[
        #cetz.canvas({
          import cetz.draw: *
          import cetz-plot: *

          plot.plot(
            size: (10, 8),
            axis-style: "school-book", 
            x-tick-step: 2, y-tick-step: 2, 
            y-min: -4, y-max: 4.,
            
            legend: (6.8, 8),
            legend-style: (stroke: none, fill: primary-color.mix((white, 700%))),

            {
              plot.add(
                samples: 500, 
                domain: (-5, 5), 
                x => (calc.pow(x, 2) - 1)/(calc.pow(x, 3) + x),
                style: line-styles,
                label: [$script(g(x) = (x^2 - 1)\/(x^3 + x))$]
              )
              plot.add-vline(
                0, 
                label: [$script(x = 0)$],
                style: (stroke: (dash: "dashed", paint: darkred, thickness: 1.5pt))
              )
              plot.add-hline(
                0, 
                label: [$script(y = 0)$],
                style: (stroke: (dash: "dotted", paint: darkred, thickness: 1.5pt))
              )
              
            }
          )
        })
      ]

    ])
  