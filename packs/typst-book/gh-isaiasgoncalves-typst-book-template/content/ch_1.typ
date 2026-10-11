#import "../template/chapter.typ": capitulo, nota-cap, nota-livro, par-inicio, verse

#capitulo("O Silêncio dos Tipos")[

  #verse[_Escrever é desenhar o vento\
  sobre um campo branco de algodão.\
  A tinta é a âncora do pensamento;\
  o espaço em branco, sua libertação._]
  #align(right)[--- Antiga Canção dos Copistas]

  #par-inicio[No][
    universo da diagramação, a maior força não reside nas letras visíveis, mas nos vazios que as cercam. O espaço que separa dois caracteres — conhecido como *kerning* — não é meramente decorativo; ele é a força gravitacional que impede que as palavras colapsem sob seu próprio peso semântico#nota-cap[O espaço em branco (ou 'contra-grafismo') atua como o vácuo quântico na física: parece vazio, mas é carregado de energia potencial interpretativa.].
  ]

  == A Gravidade da Prosa

  Podemos modelar a força de atração semântica entre dois caracteres tipográficos adjacentes utilizando uma equação derivada diretamente da gravidade de Newton:

  $ F_t = G_c dot (W_1 dot W_2) / (d^2) $

  Onde $F_t$ representa a força de tensão tipográfica, $W_1$ e $W_2$ são os pesos visuais dos glifos (suas massas de tinta) e $d$ é a distância microscópica de kerning que os separa. Esse conceito de comunicação está profundamente ligado à teoria matemática da informação descrita por Claude Shannon @shannon1948mathematical, na qual o ruído e o silêncio são partes fundamentais do canal de transmissão.

  #align(center)[
    #figure(
      image("figures/sinfonia_cosmica.jpg", width: 85%),
      caption: [Representação poética da união entre o traço da pena e a expansão harmônica do cosmos quântico.],
    ) <fig:sinfonia>
  ]

  // Inicia uma numeração local
  #show heading.where(level: 3): set heading(numbering: (..args) => str(args.pos().last()) + ".")

  === A Ressonância das Famílias

  Cada família tipográfica possui uma assinatura quântica distinta. Algumas se comportam como cristais rígidos, outras como ondas fluidas, conforme detalhado na tabela a seguir:

  #align(center)[
    #set text(size: 11pt)
    #table(
      columns: (1.5fr, 1.5fr, 2fr),
      inset: 10pt,
      align: (center + horizon),
      stroke: 0.5pt + luma(120),
      table.header([*Família*], [*Estado da Matéria*], [*Efeito Cósmico*]),
      [EB Garamond], [Líquido\ (Clássico)], [Fluidez de leitura e harmonia quântica],
      [Baskerville], [Sólido\ (Cristalino)], [Precisão geométrica e gravidade racional],
      [Bodoni], [Plasma\ (Energético)], [Tensão de contraste e luz dramática],
    )
  ]

  === O Vácuo entre Palavras

  O vazio tipográfico reflete a própria estrutura cósmica descrita pela astrofísica moderna. Assim como as estrelas no céu estão separadas por anos-luz de vácuo frio, as palavras em uma página precisam do espaço em branco para brilhar de forma individual#nota-cap[Na Idade Média, a introdução do espaço entre palavras revolucionou a leitura silenciosa, permitindo a interiorização da consciência humana#nota-livro[A separação sistemática de palavras na escrita ocidental foi introduzida pelos monges irlandeses no século VIII, alterando permanentemente a cognição humana e a neuroplasticidade da leitura.]]. Sem o espaço, a leitura torna-se uma massa singular infinitamente densa de tinta, inacessível ao intelecto humano.
]
