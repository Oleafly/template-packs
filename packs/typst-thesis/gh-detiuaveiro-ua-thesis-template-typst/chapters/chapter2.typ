= Capítulo de Demonstração <demonstration>

_Este capítulo foi criado por um modelo de Inteligência Artificial para demonstrar as várias funcionalidades disponíveis neste template de Typst_

O capítulo foi concebido para ser um guia prático para estudantes, apresentando elementos comuns de uma tese, como formatação de texto, citações, figuras, tabelas e listagens de código. O objetivo é fornecer exemplos claros que possam ser facilmente adaptados para o seu próprio trabalho.

== Estrutura do Documento
Uma tese é tipicamente estruturada em capítulos, secções e subsecções. Isto ajuda a organizar o conteúdo de forma lógica e facilita a navegação para os leitores.

=== Secções e Subsecções
Pode criar secções usando o comando `==` e subsecções com `===`. Para um aninhamento mais profundo, `===` também está disponível. O template tratará automaticamente da numeração e adicioná-los-á ao índice.

=== Uma Nota sobre Rótulos (Labels)
É uma boa prática adicionar um `<label>` após cada capítulo, secção, figura e tabela. Isto permite referenciá-los no texto usando `@label`, que gera automaticamente o tipo de referência correto (por exemplo, "Capítulo 1", "Figura 2.3"). Por exemplo, este capítulo é o @demonstration.

== Citações e Bibliografia
Citar as suas fontes corretamente é crucial. Este template usa um ficheiro de bibliografia em formato *Bibtex* para a gestão da bibliografia. Pode adicionar citações de várias maneiras. Por exemplo, pode citar uma fonte usando `@chave`, como as normas da Universidade de Aveiro @modelos.


== Figuras e Tabelas

=== Inclusão de Figuras
As figuras são essenciais para visualizar dados e conceitos. Pode incluir imagens usando o comando `image()` e o `figure()`. A @fig:ualogo mostra um exemplo. Lembre-se de usar imagens de alta qualidade e fornecer uma legenda descritiva.

#figure(caption: "Um exemplo de uma figura ",
    placement: auto,
    image(width: 30%, "../figs/ua-logo.png"),
)<fig:ualogo>


=== Criação de Tabelas

As tabelas são usadas para apresentar dados estruturados. O ambiente não é um flutuante mas fica flutante dentro do `figure()`!  A @tab:example é um exemplo simples.

#figure(
    table(
    columns: 3,
    [*Parâmetro*], [*Valor*], [*Unidade*],
    [Velocidade da Luz], [$2.998  10^8$], $m s^(-2)$, 
    [Constante Gravitacional (G)], [], $(N m^2)/((K g)^2)$,
    [Tamanho de um ficheiro], "1", "Mb",
    ),
    placement: auto,
  caption: "Uma tabela de exemplo mostrando diferentes tipos de dados.",
) <tab:example>


== Listagens de Código
Este template permite para formatar código, o que oferece um excelente realce de sintaxe. Pode incluir blocos de código num ambiente com acentos, como mostrado no Código @lst:c-example}.

#figure(
```c
#include <stdio.h>

int main()
{
    // Imprime uma saudação na consola
    printf("Olá, Mundo!\n");
    return 0;
}
```,
caption: [Um programa "Olá, Mundo!" escrito em C.]
)<lst:c-example>


Para código em linha, pode usar _3 acentos_ com a indicação da linguagem  , por exemplo: ```python print("Olá de Python!")```.

== Fórmulas Matemáticas
O template fornece ferramentas abrangentes para a formatação de matemática. Pode escrever matemática em linha como $E = m c^2$ envolvendo-a em cifrões.

#math.equation(
$
    integral_0^oo e^(-x^2) d x = sqrt(pi)/2
$,
block: true,
numbering: "1.")<eq:gaussian>

A @eq:gaussian representa é a famosa integral Gaussiana.
