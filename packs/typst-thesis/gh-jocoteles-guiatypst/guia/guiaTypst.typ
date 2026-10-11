#import "@preview/zero:0.1.0": num, set-num
#import "@preview/physica:0.9.8": *
#import "funcsGuia.typ": *

//Configurações do documento
//-----------------------------------------------

#set text(lang: "pt")

#set-num(decimal-separator: ",")

#show link: it => underline(text(blue, it))

#set page(
  paper: "a4",
  margin: (x: 3cm, y: 3cm),
)

#set par(
  leading: 0.8em, //Espaçamento entre linhas
  spacing: 1.5em, //Espaçamento abaixo dos parágrafos
  first-line-indent: (amount: 2.5em, all: true),
  justify: true,
)

#set heading(numbering: "1.")

#set math.equation(numbering: "(1)")

#set figure.caption(position: top)

// Adequa citação em bloco para ABNT:
#set quote(block: true, quotes: false)
#show quote: it => {
  set pad(left: 4cm)
  set align(right)
  text(size: 10pt, it)
}

//Espaçamento acima e abaixo dos títulos das seções:
#show heading: set block(
  above: 2em,
  below: 1.5em,
)

//Funções e variáveis auxiliares
//-------------------------------------------------

#let mi = text("µ")
#let sen = math.op("sen")

#let cite_indireta(reference) = {
  cite(reference, form: "prose")
}

//Conteúdo do Documento
//---------------------------------------------------------

#align(center, text(17pt)[*Guia de usos e exemplos do Typst*])

#align(center, text(12pt)[
  João Teles de Carvalho Neto\
  DCNME/CCA/UFSCar\
  09/03/2025
])

#outline()

#pagebreak()

= Introdução

Typst @typstdocs é um sistema de composição de documentos, como o LaTeX. Você escreve seu TCC em um arquivo de texto simples (`.typ`) e o compilador Typst gera um PDF formatado. As vantagens do Typst incluem:

- *Sintaxe mais simples:* Menos comandos e mais clareza.
- *Compilação rápida:* Visualize as mudanças quase instantaneamente.
- *Pacotes integrados:* Muitos recursos já estão incluídos, sem precisar instalar pacotes extras. Embora existam pacotes poderosos que estendem bastante as funcionalidades padrão.
- *Web App:* Você pode usar o Typst online, sem instalar nada, e colaborar em tempo real. (https://typst.app)
- *Comunidade Ativa:* O Typst é um projeto de código aberto e conta com uma comunidade ativa.

A principal desvantagem que observamos até o momento é que, diferentemente do LaTeX, as editoras no Brasil e no exterior ainda não aceitam documentos em código fonte do Typst (arquivos `.typ`). Entretanto, se o documento em PDF é suficiente para a publicação almejada, então o Typst é uma excelente opção.

= Aprendizagem do Typst

A primeira coisa que você precisa fazer para começar a usar o Typst é estudar o Tutorial online: https://typst.app/docs/tutorial/. Preocupe-se em entender bem as seções 1 e 2 do tutorial, pois são as mais importantes:

1. #link("https://typst.app/docs/tutorial/writing-in-typst/")[Wrting in Typst]
2. #link("https://typst.app/docs/tutorial/formatting/")[Formatting]

Caso queira se aprofundar um pouco mais, parta para a seção: #link("https://typst.app/docs/tutorial/making-a-template/")[Making a Template]. Para obter informações sobre funções e comandos específicos do Typst, acesse a seção #link("https://typst.app/docs/reference/")[Reference] e use a ferramenta _Search_ disponível no topo da página. Após esses estudos, o passo seguinte é:

3. Ler e estudar a @sec_exemplos deste guia de Usos e Exemplos do Typst.

*Atenção:* só comece a escrever o seu texto após o estudo cuidadoso dos itens 1, 2 e 3 listados acima.

Mesmo tendo estudado todos esses recursos, é normal que dúvidas ou problemas surjam ao longo da escrita da monografia. Disponibilizamos no #link("https://github.com/jocoteles/GuiaTypst")[repositório GuiaTypst] o arquivo de documentação `typst_doc_repo_textualized.txt` para ser carregado em um _Large Language Model_. Temos observado que o conhecimento padrão dos LLM's sobre o Typst é muito ruim. E o uso desse arquivo melhora bastante a qualidade das respostas geradas.

= Usos e Exemplos mais Comuns do Typst<sec_exemplos>

A seguir elencamos os exemplos de usos mais comuns encontrados nas monografias escritas em Typst pelos estudantes. Usamos uma abordagem bem direta baseada em exemplos corretos (ou bons) e incorretos (ou ruins). Nos exemplos, comandos em Typst são marcados com a cor de fundo cinza e os textos renderizados para visualização/impressão aparecem emoldurados. Em alguns exemplos utilizamos recursos do arquivo #link("https://github.com/jocoteles/GuiaTypst/TCC/templateTCC.typ")[templateTCC.typ] disponível no #link("https://github.com/jocoteles/GuiaTypst")[repositório GuiaTypst].

Como este guia está em constante desenvolvimento, a lista de exemplos pode aumentar ou alterar-se com o tempo.

== Para as seções e subseções utilize espaço após o símbolo de seção.

- Exemplo correto: #typw("= Título da Seção 1")
- Exemplo incorreto: #typw("=Título da Seção 1")

== Evite deixar os títulos das seções em negrito ou itálico

O Typst já formata as seções e subseções com um padrão pré-definido. Isso garante consistência.
- Exemplo bom: #typw("= Título da Seção 1")
- Exemplo ruim: #typw("= *Título da Seção 1*")

== Mantenha o texto organizado

Mesmo que algumas disposições do texto não façam diferença no resultado do pdf final, adote boas práticas de organização. Isso facilita a leitura e a busca por partes específicas do texto. Uma delas é deixar uma linha em branco entre o título da seção/subseção e o primeiro parágrafo.

== Forma correta para quebrar páginas

Para realizar quebra de página, use o comando #typw("#pagebrake()"). Não fique pulando linhas até o título da seção escorregar para a outra página. Isso é muito frágil.

== Citações indiretas

Para citações indiretas, use a função do templateTCC #typw("#cite_indireta(<reference>)") ou use a função #typw("#cite") original do Typst com a opção prose: #typw("cite(<reference>, form: \"prose\")").

#typex("O artigo de #cite(<galilei1638>, form: \"prose\") relata isso e aquilo.", "Exemplo")

== Citações diretas

Para citações diretas use simplesmente #typw("@galileu1638").

#typex("Corpos de massas diferentes caem em queda livre com a mesma aceleração @galilei1638.", "Exemplo")

== Citações diretas a trechos literais

Para citações diretas a trechos literais longos, use o comando #typw("#quote").

#typex(
  "#quote(attribution: [@galilei1638])[Esta simultaneidade da visão, creio, é o *único* argumento que pode ser oferecido em favor do movimento instantâneo da luz]",
  "Exemplo",
)

== Formatos de bibliografias

O Typst suporta #link("https://typst.app/docs/reference/model/bibliography/")[bibliografias] nos formatos BibTeX (`.bib`) e YAML (formato yaml através do motor #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md")[Hayagriva]).

Embora o BibTeX seja amplamente utilizado, o formato YAML é recomendado por sua clareza e estrutura moderna. No próprio repositório oficial do Typst você encontra um arquivo com muitos #link("https://github.com/typst/hayagriva/blob/main/tests/data/basic.yml")[exemplos] em Hayagriva.



== Variáveis matemáticas no meio da frase

Use sempre o modo matemático para variáveis matemáticas ao longo do texto.

#typex("As variáveis $m$ e $t$ designam massa e tempo, respectivamente.", "Exemplo correto")
#typex("As variáveis m e t designam massa e tempo, respectivamente.", "Exemplo incorreto 1")
#typex("As variáveis _m_ e _t_ designam massa e tempo, respectivamente.", "Exemplo incorreto 2")

== Potências de dez no meio da frase

Para potências de dez ao longo de uma frase use formatação matemática ou a função #typw("#num()").

#typex("O tamanho do átomo é da ordem de $10^(-10)$ metros.", "Exemplo correto 1")

/ Exemplo correto 2: #typw("A distância Sol-Terra é igual a $num(1,5e8)$ km"). Que gera "A distância Sol-Terra é igual a $#num("1,5e8")$ km". A função #typw("#num") não é padrão do Typst e precisa ser importada no início do arquivo. Ela possui muitas outras opções de formatação que você pode utilizar conforme o caso e a conveniência. Vide https://typst.app/universe/package/zero/.

== Unidades de grandezas físicas

Unidades de grandezas físicas devem ser escritas em texto normal com espaço após o valor numérico:

#typex("O diâmetro da esfera é $d=12$ m.", "Exemplo correto 1")
#typex("O diâmetro da esfera é $d=12\" m\"$.", "Exemplo correto 2 (menos desejável)")
#typex(
  "O diâmetro da esfera é $d=12 m$. Ou, o diâmetro da esfera é $d=12$ $m$. Ou ainda, o diâmetro da esfera é $d=12$ _m_.",
  "Exemplo incorreto",
)

Às vezes, a unidade pode ser indesejadamente separada do valor numérico pela quebra de linha automática do Typst. Uma forma de evitar isso é com o comando #typw("#box"):

#typex(
  "Esta é uma frase em que a largura $h=15$ cm teve a unidade separada do valor numérico devido à quebra de linha automática do Typst.",
  "Exemplo sem o comando box",
)

#typex(
  "Esta é uma frase em que a largura #box[$h=15$ cm] teve a unidade e o valor numérico mantidos juntos pelo uso do comando box.",
  "Exemplo com o comando box",
)

== Matemática em linha e em bloco

Para manter o conteúdo matemático na mesma linha do texto, use cifras sem espaço delimitando o conteúdo. Para colocar o conteúdo matemático em um parágrafo separado, inclua os espaços.

#typex("O teorema de Pitágoras diz que: $z^2=x^2+y^2$.", "Exemplo com matemática na linha do texto")

#typex("O teorema de Pitágoras diz que:\n\n $ z^2=x^2+y^2 \".\" $", "Exemplo com matemática em um parágrafo próprio")

== Referencie expressões matemáticas em bloco pelo rótulo

Use rótulos (#typw("<rotulo>")) para identificar as expressões matemáticas mais importantes e assim poder citá-las pelo sistema de numeração automática do Typst.

#typex(
  "A segunda lei da Termodinâmica diz que em um sistema fechado:\n\n $ Delta S >= 0\" .\" $<eq_2alei>\n\nA @eq_2alei é uma das equações fundamentais da termodinâmica.",
  "Exemplo correto",
)

#typex(
  "A segunda lei da Termodinâmica diz que em um sistema fechado:\n\n $ Delta S >= 0\" .\" $\n\nA Equação 3 é uma das equações fundamentais da termodinâmica.",
  "Exemplo incorreto 1",
)

#typex(
  "A segunda lei da Termodinâmica diz que em um sistema fechado:\n\n $ Delta S >= 0\" .\" $\n\nA equação anterior é uma das equações fundamentais da termodinâmica.",
  "Exemplo incorreto 2",
)

== Use pontuação após equações em bloco

Equações matemáticas também fazem parte do texto e, por isso, quando for o caso, precisam receber pontuação como se fossem palavras quaisquer, mesmo quando expressas em bloco. Para fazer isso, inclua a pontuação necessária entre aspas ao final da expressão mas ainda dentro do modo matemático. Se o parágrafo seguinte é na verdade uma continuação do parágrafo anterior é necessário remover a indentação. Nesse caso, use #typw("#h(-2.5em)"), em que #typw("2.5em") é o tamanho da indentação neste caso. No arquivo `templateTCC.typ` incluímos a variável #typw("#noi") (_no indent_) para ser usada no lugar de #typw("#h(-2.5em)").

#typex(
  "A força resultante $F$ sobre um corpo em queda livre é dada por:\n\n $ F = m g \",\" $\n\n#h(-2.5em) em que $m$ é a massa e $g$ é a aceleração gravitacional.",
  "Exemplo correto 1",
)

#typex(
  "As equações:\n\n$ Delta U = Q + W \" e\" $\n$ E = K + U $\n\n#h(-2.5em) expressam o princípio da conservação da energia.",
  "Exemplo correto 2",
)

#typex(
  "A força resultante $F$ sobre um corpo é dada por:\n\n $ F = m a $\n\nEssa é a forma matemática simplificada da 2ª lei de Newton.",
  "Exemplo incorreto",
)


== Como usar o símbolo #mi

Para unidades em múltiplos de mícrons (#mi) deve-se evitar a sua escrita em itálico, tal como é obtida no modo matemático #typw("$mu$") ($mu$). Para isso,  pode-se utilizar o comando #typw("\u{03BC}") diretamente no modo texto. Por exemplo, a espessura do fio é #typw("$w=120$ \\u{03BC}m"), que resulta em: $w=120$ \u{03BC}m. Para facilitar, no templateTCC disponibilizamos a variável #typw("#mu"). Exemplo: #typw("$t=15$ #mu\s") que resulta em: $t=15$ #mi\s.

== Texto normal dentro do modo matemático

Use aspas para escrever texto normal dentro do modo matemático. Um exemplo dessa necessidade é para nomes de funções não conhecidas pelo Typst ou que são escritas de forma diferente em português e inglês. Como a função seno (#typw("sen")) em português e  _sine_ (`sin`) em inglês. Outro exemplo é para rótulos subescritos de variáveis. Entretanto, se o índice subescrito ou superescrito for uma variável, deve-se mantê-la no modo matemático.

#typex(
  "A massa grande e a massa pequena são designadas por $m_\"g\"$ e $m_\"p\"$, respectivamente. Ou $m_\"gra\"$ e $m_\"peq\"$, etc.",
  "Exemplo correto 1",
)
#typex(
  "A massa grande e a massa pequena são designadas por $m_g$ e $m_p$\", respectivamente. Ou $m_(g r a)$\" e $m_(p e q)$\", etc.",
  "Exemplo incorreto 1",
)
#typex(
  "O deslocamento quadrático médio das partículas é calculado por $frac(1, N) sum_(i=1)^(N) Delta x_i^2$.",
  "Exemplo correto 2",
)
#typex(
  "O deslocamento quadrático médio das partículas é calculado por $frac(1, N) sum_(\"i\"=1)^(N) Delta x_\"i\"^2$.",
  "Exemplo incorreto 2",
)
#typex("O valor da radiância espectral é dado por $\"Rad\"(nu)$.", "Exemplo correto 3")
#typex("O valor da radiância espectral é dado por $R a d (nu)$.", "Exemplo incorreto 3")

Mas o Typst reconhece as funções matemáticas padrão, que não precisam ser escritas entre aspas. Por exemplo:

- #typw("$arctan(frac(y, x))$") $arrow$ $arctan(frac(y, x))$
- #typw("$cos theta$") $arrow$ $cos theta$

No caso da função seno, no arquivo templateTCC, definimos a grafia da função seno em português no modo matemático com o comando #typw("#let sen = math.op(\"sen\")"), pois o seu uso é muito frequente. Dessa forma, ela é reconhecida automaticamente em português no modo matemático:

- #typw("$sen theta$") $arrow$ $sen theta$.

== Separador decimal no modo matemático

Sabemos que o separador decimal correto exigido pela ABNT é a vírgula. Em modo texto, basta escrever a vírgula normalmente. Por exemplo: #typw("uma polegada é igual a 2,54 cm") (uma polegada é igual a 2,54 cm). Mas, no modo matemático, é criado um espaço indesejado após a vírgula. Por exemplo: #typw("uma polegada é igual a $2,54$ cm") (uma polegada é igual a $2,54$ cm). Portanto, evite o modo matemático se você for citar números com vírgula sem variáveis matemáticas envolvidas. Mas, se for necessário, a melhor maneira de evitar esse problema é colocar o número entre aspas.

#typex(
  "A conversão de centímetros para polegadas é dada pela expressão $p = q/\"2,54\"$ com $q$ em cm.",
  "Exemplo correto",
)

== Utilize o pacote physica

Importe o pacote `physica` no início do documento para poder usufruir de uma vasta gama de símbolos e operadores físicos e matemáticos. Exemplos: #typw("$hbar$") ($hbar$), #typw("$ket(psi)$") ($ket(psi)$), #typw("$nabla$") ($nabla$), etc.

== Use o comando certo para definições

O Typst possui um comando pré-definido para definições. Prefira ele a listas numeradas ou itemizadas, principalmente quando a definição for importante ou única.

#typex(
  "/ Spin: momento angular intrínseco de uma partícula, sem equivalente clássico, que influencia suas interações e estatísticas quânticas.",
  "Exemplo",
)

== Imagens, tabelas e quadros

Para elementos flutuantes como imagens, tabelas e quadros, não se refira a eles como "abaixo", "ao lado", "na seção anterior", etc. Faça referência à numeração automática do Typst. *Sempre inclua legendas (caption) e a fonte da autoria*. Inclua todos eles dentro da função #typw("#figure()"). Jamais deixe de fazer referência a esses elementos flutuantes no texto principal da monografia: se o elemento existe ele deve ser mencionado ao longo do texto. Além disso, inclua o elemento o mais próximo possível à sua citação no texto.

#typex(
  "#figure(
image(\"figuras/Galileu1.png\"),
  caption: [Exemplo clássico do método científico de Galileu.],
) <fig_galileu1>
#align(center)[Fonte: #cite(<galilei1638>, form: \"prose\")]
\nNa @fig_galileu1, Galileu aplica o método científico ao estudo da resistência de vigas.",
  "Exemplo correto de imagem e citação à imagem",
)

#typex(
  "#figure(
image(\"figuras/Galileu1.png\")
) <fig_galileu2>\n\nNa figura acima, Galileu aplica o método científico ao estudo da resistência de vigas.
",
  "Exemplo incorreto de imagem e de citação à imagem",
)

#typex(
  "#figure(
  caption: [Dados de queda livre],
  table(
    columns: (auto, auto),
    align: center,
    table.header(
      [$h$ [m]\ ($plus.minus$ 0,01)],
      [$t$ [s]\ ($plus.minus$ 0,02)],
    ),
    [1,00], [0,45],
    [2,00], [0,64],
    [3,00], [0,78],
  )
)<tab_quedalivre>
#align(center)[Fonte: Elaborado pelo autor.]
\nNa @tab_quedalivre estão organizadas algumas medidas de queda livre de uma esfera metálica.",
  "Exemplo correto de tabela e citação à tabela",
)

#typex(
  "#table(
    columns: (auto, auto),
    align: center,
    table.header(
      [$h$ [m]\ ($plus.minus$ 0,01)],
      [$t$ [s]\ ($plus.minus$ 0,02)],
    ),
    [1,00], [0,45],
    [2,00], [0,64],
    [3,00], [0,78],
  )\n\nNa tabela anterior estão organizadas algumas medidas de queda livre de uma esfera metálica.
",
  "Exemplo incorreto de tabela e de citação à tabela",
)

#typex(
  "#figure(
  caption: [Cientistas e suas Contribuições],
  table(
    columns: (auto, auto),
    align: center + horizon,
    table.header([*Cientista*], [*Contribuição*]),
    [Galileu], [Astronomia],
    [Newton], [Gravitação],
    [Einstein], [Relatividade],
  ),
  kind: \"quadro\",
  supplement: \"Quadro\",
)<qua_cientistas>
#align(center)[Fonte: Elaborado pela autora.]
\nO @qua_cientistas ilustra apenas uma das principais contribuições de alguns dos cientistas mais eminentes da Física.",
  "Exemplo correto de quadro",
)

Repare que para a construção do quadro usa-se a mesma função da tabela (#typw("#table()")), mas é necessário incluir as opções #typw("kind: quadro") e #typw("supplement: Quadro") para que o elemento seja referenciado pela palavra "Quadro".

== Referência a seções e subseções

Da mesma forma que para figuras, no caso de seções e subseções não se refira a elas como "na seção anterior", "na seção seguinte", etc., mas utilize a numeração automática. Para isso, inclua um rótulo a direita do texto da seção. Por exemplo: #typw("== Análise dos Resultados <sec_analise>"), que é referenciada ao longo do texto como, por exemplo, #typw("Estas conclusões estão em acordo com a discussão da @sec_analise").

== Referências Bibliográficas

O Typst possui suporte nativo para bibliografias em formatos como BibTeX (`.bib`) e YAML (através do motor Hayagriva). Embora o BibTeX seja amplamente utilizado, o formato YAML é recomendado por sua clareza e estrutura moderna. Você pode encontrar exemplos no arquivo `referencias.yml` deste guia. Para uma explicação completa do modelo YAML e todos os campos suportados, acesse a documentação oficial do formato: #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md")[Hayagriva File Format].

#bibliography("referencias.yml", style: "associacao-brasileira-de-normas-tecnicas")

