#import "/src/lib.typ": glossario, apendice, anexo

#glossario((
  (
    termo: "Acurácia",
    definicao: "Métrica que mede a proporção de predições corretas em relação ao total de predições realizadas.",
  ),
  (
    termo: "Backpropagation",
    definicao: "Algoritmo para calcular o gradiente da função de perda em relação aos pesos da rede neural, usado no treinamento.",
  ),
  (
    termo: "Ensemble",
    definicao: "Técnica que combina múltiplos modelos de aprendizado de máquina para melhorar o desempenho e robustez das predições.",
  ),
  (
    termo: "Overfitting",
    definicao: "Fenômeno que ocorre quando um modelo aprende padrões específicos dos dados de treinamento que não generalizam para novos dados.",
  ),
  (
    termo: "Transfer Learning",
    definicao: "Técnica que utiliza conhecimento adquirido em uma tarefa para melhorar o aprendizado em outra tarefa relacionada.",
  ),
))

#apendice("A", "Detalhes de Implementação")[

  Este apêndice apresenta detalhes adicionais sobre a implementação dos modelos desenvolvidos neste trabalho.

  === Código de Treinamento

  ```python
  import torch
  import torch.nn as nn
  from torchvision import models, transforms

  # Carregar modelo pré-treinado
  model = models.efficientnet_b3(pretrained=True)

  # Modificar camada final
  num_classes = 14
  model.classifier[1] = nn.Linear(
      model.classifier[1].in_features,
      num_classes
  )

  # Definir loss e otimizador
  criterion = nn.BCEWithLogitsLoss()
  optimizer = torch.optim.Adam(
      model.parameters(),
      lr=0.001
  )
  ```

  === Hiperparâmetros Detalhados

  A @tab:hiperparametros-detalhados apresenta os hiperparâmetros utilizados no treinamento dos modelos.

  #figure(
    table(
      columns: (auto, auto, auto),
      align: (left, center, left),
      table.header([*Parâmetro*], [*Valor*], [*Descrição*]),
      [Learning rate], [0.001], [Taxa inicial],
      [Batch size], [32], [Tamanho do lote],
      [Épocas], [100], [Máximo de iterações],
      [Weight decay], [1e-4], [Regularização L2],
      [Dropout], [0.3], [Taxa de dropout],
    ),
    caption: [Hiperparâmetros utilizados no treinamento.],
  ) <tab:hiperparametros-detalhados>

]

#apendice("B", "Resultados Adicionais")[

  Este apêndice apresenta resultados complementares aos apresentados no Capítulo 5.

  === Análise por Patologia

  A @tab:analise-patologia apresenta o desempenho detalhado do modelo EfficientNet-B3 para cada tipo de patologia.

  #figure(
    table(
      columns: (auto, auto, auto, auto),
      align: (left, center, center, center),
      table.header([*Patologia*], [*Sensibilidade*], [*Especificidade*], [*F1-Score*]),
      [Pneumonia], [96.2%], [97.1%], [0.965],
      [Atelectasia], [93.5%], [95.8%], [0.947],
      [Cardiomegalia], [94.8%], [96.3%], [0.955],
      [Derrame pleural], [95.1%], [96.9%], [0.960],
      [Infiltração], [92.7%], [94.5%], [0.937],
    ),
    caption: [Desempenho do EfficientNet-B3 por tipo de patologia.],
  ) <tab:analise-patologia>

]

#apendice("C", "Questionário de Validação Clínica")[

  Este apêndice apresenta o questionário utilizado para validação com médicos especialistas.

  === Formulário de Avaliação

  *Avaliação de Sistema de IA para Diagnóstico*

  Os seguintes critérios foram avaliados pelos especialistas:

  1. Você concorda que as regiões destacadas pelo modelo são clinicamente relevantes?
    - \[ \] Concordo totalmente
    - \[ \] Concordo parcialmente
    - \[ \] Discordo

  2. Você utilizaria este sistema como ferramenta de apoio ao diagnóstico?
    - \[ \] Sim, certamente
    - \[ \] Talvez, com reservas
    - \[ \] Não

  3. O sistema demonstra precisão adequada para uso clínico?
    - \[ \] Sim
    - \[ \] Parcialmente
    - \[ \] Não

  4. Comentários adicionais: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

]

#anexo("A", "Aprovação do Comitê de Ética")[

  Este anexo contém o documento de aprovação do Comitê de Ética em Pesquisa da UFSM.

  #v(2cm)

  #align(center)[
    #text(weight: "bold")[PARECER CONSUBSTANCIADO DO CEP]
  ]

  #v(1cm)

  *Número do Parecer:* 12345678

  *Data da Relatoria:* 15/03/2024

  *Apresentação do Projeto:*

  O projeto "Aplicação de Técnicas de Aprendizado Profundo para Classificação de Imagens Médicas" foi aprovado pelo Comitê de Ética em Pesquisa da Universidade Federal de Santa Maria.

  *Conclusões ou Pendências:*

  O projeto foi aprovado sem pendências.

]

#anexo("B", "Termo de Consentimento Livre e Esclarecido")[

  Este anexo apresenta o modelo do Termo de Consentimento Livre e Esclarecido (TCLE) utilizado na pesquisa.

  #v(1cm)

  #align(center)[
    #text(weight: "bold")[TERMO DE CONSENTIMENTO LIVRE E ESCLARECIDO]
  ]

  #v(1cm)

  Você está sendo convidado(a) a participar da pesquisa "Aplicação de Técnicas de Aprendizado Profundo para Classificação de Imagens Médicas", sob responsabilidade do pesquisador Nome Completo do Autor.

  *Objetivo da Pesquisa:*

  Esta pesquisa tem como objetivo desenvolver e avaliar modelos computacionais para auxiliar no diagnóstico de patologias através de análise de imagens médicas.

  *Procedimentos:*

  Sua participação consistirá em avaliar os resultados gerados pelo sistema computacional e fornecer feedback sobre sua relevância clínica.

  *Riscos e Benefícios:*

  Os riscos desta pesquisa são mínimos, relacionados ao tempo dedicado à avaliação. Os benefícios incluem contribuir para o avanço de tecnologias que podem auxiliar no diagnóstico médico.

  *Confidencialidade:*

  Todas as informações coletadas serão mantidas em sigilo e utilizadas apenas para fins de pesquisa.

]
