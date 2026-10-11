#import "@preview/icu-datetime:0.1.2": fmt-date
#import "settings.typ": *
#import "table-headers.typ": h-header, v-header
#import "graph.typ": makeVulnGraph
#include "cover.typ"
#pagebreak()

#let data = yaml("data.yml")
#let vulnerabilities = data.vulnerabilities.sorted(key: vuln => severityOrder.at(vuln.severity))
#let startDate = datetime(
  year: data.startDate.year,
  month: data.startDate.month,
  day: data.startDate.day,
)
#let endDate = datetime(
  year: data.endDate.year,
  month: data.endDate.month,
  day: data.endDate.day,
)
#let shortStartDate = fmt-date(startDate, locale: "pt-BR", length: "short")
#let shortEndDate = fmt-date(endDate, locale: "pt-BR", length: "short")
#let longStartDate = fmt-date(startDate, locale: "pt-BR", length: "long")
#let longEndDate = fmt-date(endDate, locale: "pt-BR", length: "long")

#show ref: it => underline(
  smallcaps(text(font: "New Computer Modern", fill: blue, it)),
)
#show link: it => underline(text(fill: blue, it))

#show figure.where(kind: image): set figure(supplement: "Imagem")
#show figure.where(kind: raw): set figure(supplement: "Registro")
#show figure.caption: set text(font: "New Computer Modern", size: 10pt)

#let terminal(command, caption) = {
  figure(
    block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      #raw(command, lang: "bash")
    ],
    kind: "terminal",
    supplement: "Comando",
    caption: caption,
  )
}

#let evidences = state("evidences", ())
#let add-evidence(path, description) = {
  let filename = path.split("/").last()
  let evidence-name = filename.split(".").first()
  let origin-name = "origin-" + evidence-name

  let evidence-label = label(evidence-name)
  let origin-label = label(origin-name)
  let origin-link = link(origin-label)[Origem]
  let caption = description + " | " + origin-link

  evidences.update(e => {
    e.push([
      #figure(
        [
          #image(path, width: 80%)
        ],
        caption: caption,
        kind: "evidence",
        supplement: "Evidência",
      ) #evidence-label
    ])

    return e
  })

  [ #ref(evidence-label) #origin-label ]
}

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)
#show raw.where(block: true): code => align(center)[
  #block(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )[#code]
]

#set enum(numbering: "1.a)", full: true)
#set text(lang: "pt", font: "Liberation Sans", size: 12pt)
#set page(
  paper: "us-letter",
  margin: (top: 3cm, left: 2cm, right: 2cm, bottom: 2cm),
  header: [
    #align(left)[
      #image("images/header.png", width: 3.16cm, height: 0.99cm)
    ]
  ],
  footer: [
    #set text(size: 9pt)
    #align(center)[
      #grid(
        columns: (1fr, 1fr),
        rows: 1,
        align: (left, right),
        stroke: (top: 0.5pt),
        inset: 5pt,
        [PENETRATION TESTING REPORT | BUSINESS CORP], [_CONFIDENCIAL_],
      )
      #image("images/footer.png", width: 2.58cm, height: 0.80cm)
    ]
  ],
  footer-descent: 0%,
)

#show heading: set text(fill: highlight-fill-color, size: 14pt)

= Controle de Versões
\

#h-header(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    [DATA], [VERSÃO], [AUTOR], [ALTERAÇÕES],
    [01/07/2024], [1], [Vinicius],
  ),
)

\
\
#h-header(
  table(
    columns: 1fr,
    table.header([_CONFIDENCIAL_]),
    [
      _Este documento contém informações proprietárias e confidenciais e todos os dados encontrados durante os testes e presentes neste documento foram tratados de forma a garantir a privacidade e o sigilo dos mesmos. A duplicação, redistribuição ou uso no todo ou em parte de qualquer forma requer o consentimento da *#data.companyName*_.
    ]
  ),
)

#pagebreak()

= Aviso Legal
\
O Pentest foi realizado durante o período de *#shortStartDate* até *#shortEndDate*. As constatações e recomendações refletem as informações coletadas durante a avaliação e estado do ambiente naquele momento e não quaisquer alterações realizadas posteriormente fora deste período. \

O trabalho desenvolvido pela DESEC SECURITY *NÃO* tem como objetivo corrigir as possíveis vulnerabilidades, nem proteger a CONTRATANTE contra ataques internos e externos, nosso objetivo é fazer um levantamento dos riscos e recomendar formas para minimizá-los. \

As recomendações sugeridas neste relatório devem ser testadas e validadas pela equipe técnica da empresa CONTRATANTE antes de serem implementadas no ambiente em produção. A DESEC SECURITY *não se responsabiliza* por essa implementação e possíveis impactos que possam vir a ocorrer em outras aplicações ou serviços.
\
\
= Informações de Contato
\
#h-header(
  table(
    columns: (1fr, 1fr, 1.5fr),
    [NOME], [CARGO], [INFORMAÇÕES],
    table.cell(
      fill: highlight-fill-color,
      align: center + horizon,
      colspan: 3,
      text(fill: white)[*BUSINESS CORP*],
    ),
    [José dos Santos], [Diretor de Segurança da Informação], [
      *Telefone*: (00) 0 1234-4321 \
      *Email*: jsantos\@grupobusinesscorp.com
    ],
    table.cell(
      fill: highlight-fill-color,
      align: center + horizon,
      colspan: 3,
      text(fill: white)[*CORPO TÉCNICO | DESEC SECURITY*],
    ),
    [Ricardo Longatto], [Penetration Tester], [
      *Telefone*: (00) 0 1234-4321 \
      *Email*: \@desecsecurity.com
    ],
  ),
)
#pagebreak()

= Sumário Executivo
\
A Desec Security avaliou a postura de segurança da #data.companyName através de um Pentest Externo pelo período de #longStartDate até #longEndDate. Os resultados das avaliações efetuadas no ambiente a partir da internet demonstram que a empresa possui sérios riscos cibernéticos com a presença de vulnerabilidades de nível *CRÍTICO* que *comprometem a integridade, disponibilidade e o sigilo de informações sensíveis*.
\
\

#makeVulnGraph(data)

#let tableContent = vulnerabilities.sorted(key: vuln => severityOrder.at(vuln.severity)).map(vuln => {
  let severity = severityMap.at(vuln.severity)
  return (severity, vuln.description)
})

#h-header(
  table(
    columns: (auto, 1fr),
    [RISCO], [VULNERABILIDADE],
    ..tableContent.flatten()
  ),
)
\
É altamente recomendável que a #data.companyName resolva as vulnerabilidades classificadas como risco crítico com *alta prioridade* para que não haja um impacto negativo para os negócios, visto a criticidade das vulnerabilidades encontradas e passíveis de serem exploradas através da internet.
#pagebreak()

A tabela abaixo resume as principais vulnerabilidades e riscos encontrados durante os testes realizados e ao final deste relatório são propostas as recomendações para mitigação dos problemas encontrados.
#text(size: 10pt)[
  #for vuln in vulnerabilities [
    #figure()[
      #v-header(
        table(
          columns: (auto, 1fr),
          align: left + horizon,
          [Descrição], vuln.description,
          [CVE], vuln.id,
          [Risco], severityMap.at(vuln.severity),
          [Impacto], vuln.impact,
          [Sistema], [#vuln.system \@ #vuln.location],
        ),
      )
    ]
  ]
]

#pagebreak()
= Introdução
\
A Desec Security foi contratada para conduzir uma avaliação de segurança _(Penetration Testing)_ no ambiente digital da ALGOR Soluções.

A avaliação foi conduzida de maneira a simular um ciberataque à partir da internet com o objetivo de determinar o impacto que possíveis vulnerabilidades de segurança possam ter no que diz respeito à *integridade, disponibilidade e confidencialidade* das informações da empresa contratante.

Os testes foram realizados entre os dias #longStartDate e #longEndDate e este documento contém todos os resultados.

O método utilizado para a execução do serviço proposto segue rigorosamente as melhores práticas de mercado, garantindo a adequação às normas internacionais de segurança da informação, e os relatórios gerados apontam evidências quanto à segurança do ambiente definido no escopo.

= Escopo

#h-header(
  table(
    columns: (1fr, 1fr),
    [TIPO DE AVALIAÇÃO], [DETALHES],
    ..data.scope.map(s => (s.type, s.id)).flatten(),
  ),
)

De acordo com o combinado e acordado entre as partes, a avaliação escolhida foi do tipo *Black Box (sem conhecimento de informações)*, ou seja, a única informação oferecida pela CONTRATANTE foi um endereço IP.

#pagebreak()
#[
  #set list(
    indent: 15pt,
    marker: align(center + horizon)[
      #square(
        width: 5pt,
        fill: highlight-fill-color,
        stroke: highlight-fill-color,
      )
    ],
  )

  = Limitações do Escopo
  \
  As *limitações* impostas pela CONTRATANTE foram:

  - Os testes devem encerrar caso seja possível comprometer algum host na rede interna
  - Ataques DoS e DDoS (Negação de Serviço)
  - Ataques de Engenharia Social

  = Metodologia
  \
  Para execução destes trabalhos, a Desec Security adotou a metodologia própria mesclada com padrões existentes e solidamente reconhecidos, tais como PTES (Penetration Testing Execution Standard) e OWASP Top Ten nas quais foram executados nas seguintes fases:

  - Coleta de Informações
  - Varredura
  - Enumeração
  - Exploração
  - Pós Exploração
  - Documentação

  A fase de coleta de informações tem como objetivo mapear a superfície de ataque, identificando informações sobre blocos de ip, subdomínios e ambientes digitais de propriedade da #data.companyName.

  A fase de varredura consiste em identificar portas abertas, serviços ativos e possíveis mecanismos de defesa.

  A fase de enumeração permite identificar detalhes sobre os serviços ativos, identificando possíveis versões, fornecedores, usuários e informações que possam ser uteis para o sucesso de um ataque.

  A fase de exploração tem como objetivo explorar as possíveis vulnerabilidades identificadas nos serviços e sistemas identificados nas fases anteriores e obter acesso ao sistema.

  A fase de pós exploração tem como objetivo aprofundar o ataque obtendo mais privilégios e aumentando o nível de acesso, se deslocando para outros sistemas afim de controlar ou extrair dados mais sensíveis.

  A fase de documentação consiste em relatar todos os resultados obtidos nas fases anteriores.
]
#pagebreak()

#align(center)[
  #heading()[Narrativa da Análise Técnica]
]
\
Os testes iniciaram no dia #shortStartDate de posse apenas dos endereços informados pelo cliente.
\
#align(center)[
  #heading()[HOST X]
]

= _Coleta de Informações_
......
= _Exploração de Vulnerabilidades_
......
= _Pós Exploração_
......
= _Escalação de Privilégios_
......

#pagebreak()
#align(center)[= Vulnerabilidades e Recomendações]
\
#let vulnBySystem = vulnerabilities.sorted(key: vuln => vuln.system)
#for vuln in vulnerabilities {
  v-header(
    table(
      columns: (0.2fr, 1fr),
      align: left + horizon,
      [Host], [#vuln.system - #vuln.location],
    ),
  )

  v-header(
    table(
      columns: (0.2fr, 1fr),
      align: left + horizon,
      [Identificação], vuln.id,
      [Descrição], vuln.description,
      [Risco], severityMap.at(vuln.severity),
      [Impacto], vuln.impact,
      [Sistema], vuln.location,
      [Referências],
      [
        #for ref in vuln.references [
          #link(ref)\
        ]
      ],
    ),
  )

  if vuln.at("problems", default: none) != none {
    [= Problemas]
    enum(..vuln.problems)
  }

  if vuln.at("recommendations", default: none) != none {
    [= Recomendações]
    enum(..vuln.recommendations)
  }

  pagebreak()
}
\
= Evidências
#context for ev in evidences.final() {
  ev
}

= Considerações Finais
\
A realização deste teste de segurança permitiu identificar vulnerabilidades e problemas de segurança que *poderiam causar um impacto negativo* aos negócios do cliente. Com isso podemos concluir que o teste atingiu o objetivo proposto.

Podemos concluir que a avaliação de segurança como o *teste de invasão* apresentado neste relatório é fundamental para identificar vulnerabilidades, testar e melhorar controles e mecanismos de defesa afim de garantir um bom grau de segurança da informação em seu ambiente digital.

Após a CONTRATANTE aplicar todas as correções sugeridas faremos um reteste nas vulnerabilidades apresentadas para comprovar que os problemas foram devidamente resolvidos.

Desde já agradecemos a #data.companyName pela oportunidade em oferecer nossos serviços de segurança ofensiva.

