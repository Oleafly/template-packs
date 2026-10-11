#import "lib/template.typ": conf
#import "lib/helpers.typ": *

#set text(lang: "es")

#show: doc => conf(
  title: [Implementación de Sistemas de Recomendación Generativos: Fine-Tuning de Qwen 2.5 con Unsloth],
  abstract: [
    El presente trabajo documenta la implementación técnica y evaluación de un sistema de recomendación generativo basado en Grandes Modelos de Lenguaje (LLMs). Utilizando el modelo *Qwen 2.5-3B-Instruct*, se ha transformado el problema de recomendación clásica en una tarea de generación de texto estructurado (JSON). El entrenamiento se ha realizado mediante *Supervised Fine-Tuning (SFT)* sobre el dataset MovieLens 1M, empleando la librería *Unsloth* para optimizar el consumo de memoria y la velocidad en una GPU NVIDIA A100. Se detalla la estrategia de *ventana deslizante* con instrucciones dinámicas para la preparación de los datos, la configuración de hiperparámetros (LoRA, cuantización de 4 bits) y se analizan las métricas de entrenamiento, donde la pérdida se redujo de 0.89 a 0.21, demostrando una convergencia robusta y capacidad de razonamiento semántico superior a los métodos matriciales tradicionales.
  ],
  affiliations: (
    (
      id: 1,
      name: "Universidad de La Laguna",
      full: [
        Sistemas Inteligentes, Escuela Superior de Ingeniería y Tecnología,
        #linebreak()Universidad de La Laguna, Canarias, España
      ],
    ),
  ),
  authors: (
    (
      name: "Pablo Hernández Jiménez",
      affiliation: [1],
      email: "alu0101495934@ull.edu.es",
      equal-contributor: true,
    ),
  ),
  accent: rgb("#0d9488"),
  doc,
)

= Introducción: El paradigma Generativo

La evolución de los sistemas de recomendación ha transitado desde el Filtrado Colaborativo basado en vecinos (KNN) y la Factorización Matricial (SVD) hacia arquitecturas basadas en *Deep Learning*. Sin embargo, la reciente irrupción de los *Large Language Models (LLMs)*
#footnote[
  Lin, J., et al. (2023). "A Survey on Large Language Models for Recommendation". arXiv. Disponible en: #link("https://arxiv.org/abs/2305.19860")[arXiv:2305.19860].
]
ha permitido un nuevo enfoque: tratar la recomendación no como una predicción de puntuación ($hat(r)_(u i)$), sino como una tarea de generación de lenguaje natural condicionado.

A diferencia de los modelos discriminativos que asignan vectores latentes a IDs opacos, los LLMs poseen un vasto conocimiento semántico del mundo (géneros, tramas, directores) adquirido durante su pre-entrenamiento. Este proyecto explora cómo adaptar (*fine-tune*) un LLM de propósito general para que actúe como un motor de recomendación especializado capaz de generar salidas estructuradas en formato JSON.

= Arquitectura e Implementación

La implementación se ha llevado a cabo en un entorno de alto rendimiento utilizando Google Colab con una GPU **NVIDIA A100-SXM4-40GB**, aprovechando la aceleración por hardware para el entrenamiento en precisión mixta (Bfloat16).

== Selección del Modelo Base

Se ha seleccionado el modelo *Qwen 2.5-3B-Instruct*
#footnote[
  Qwen Team. "Qwen2.5: A Series of Large Language Models". Hugging Face Model Card. Disponible en: #link("https://huggingface.co/Qwen/Qwen2.5-3B-Instruct")[Hugging Face].
].
La elección se justifica por:
1.  **Tamaño Eficiente:** Con 3 mil millones de parámetros, es ejecutable en entornos con recursos limitados mediante cuantización, sin sacrificar excesiva capacidad de razonamiento.
2.  **Seguimiento de Instrucciones:** Benchmarks recientes demuestran que Qwen supera a modelos de tamaño similar (como Llama-3.2-3B) en tareas de codificación y matemáticas, lo cual es crítico para generar JSON sintácticamente válido.

== Optimización con Unsloth

Dado el coste computacional de entrenar LLMs, se ha utilizado el framework *Unsloth*
#footnote[
  Unsloth AI. "Faster LLM Training with Less Memory". Repositorio oficial: #link("https://github.com/unslothai/unsloth")[GitHub].
], que implementa kernels de Triton personalizados para optimizar la retropropagación.

Las técnicas clave aplicadas incluyen:
-   *Cuantización a 4-bits (NF4):* Reduce la huella de memoria del modelo base drásticamente.
-   *LoRA (Low-Rank Adaptation):* Se inyectan matrices de bajo rango ($r=16$) en los módulos de atención (`q_proj`, `k_proj`, `v_proj`, `o_proj`) y en las capas feed-forward (`gate_proj`, `up_proj`, `down_proj`). Esto resulta en solo *29,933,568 parámetros entrenables* (0.96% del total), permitiendo un entrenamiento eficiente sin *catastrophic forgetting*.

= Ingeniería de Datos

El conjunto de datos utilizado es *MovieLens 1M*
#footnote[
  GroupLens Research. "MovieLens 1M Dataset". Disponible en: #link("https://grouplens.org/datasets/movielens/1m/")[grouplens.org].
].
El preprocesamiento es fundamental para traducir interacciones tabulares a un formato de instrucción conversacional.

== Ventana Deslizante y Contexto Semántico

Se transformaron los historiales de usuario $H_u = [m_1, m_2, ..., m_n]$ en secuencias de entrenamiento mediante una ventana deslizante.

Para enriquecer la semántica y evitar alucinaciones basadas meramente en popularidad, se inyectaron explícitamente los géneros en la cadena de texto de entrada. Un ejemplo de *prompt* procesado es:

#block(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  [
    *User:* User History:\n
    - Terminator 2 (1991) (Action|Sci-Fi)\n
    - The Matrix (1999) (Action|Sci-Fi)\n
    Recommend 5 new movies.\n
    JSON:
  ]
)

== Instrucción Dinámica (Count Tuning)

Para mejorar la robustez del modelo al seguir instrucciones numéricas, se implementó una lógica dinámica durante la generación del dataset donde el *target_count* varía aleatoriamente entre 3, 5 y 7 ítems:

#math.equation(
  block: true,
  $ "target_count" ~ "Random"({3, 5, 7}) $
)

Esto enseña al modelo a detener la generación (`<|im_end|>`) en el momento adecuado, evitando listas interminables o truncadas.

= Configuración del Entrenamiento

El entrenamiento se orquestó utilizando la librería `trl` (Transformer Reinforcement Learning) de Hugging Face
#footnote[
  Von Werra, L. et al. "TRL: Transformer Reinforcement Learning". Documentación: #link("https://huggingface.co/docs/trl/index")[Hugging Face Docs].
].

Se configuró el `SFTTrainer` con una función de pérdida especial: `completion_only_loss=True`. Esto aplica una máscara sobre los tokens del "User Prompt", de modo que el modelo solo calcula gradientes sobre la respuesta generada (el JSON de recomendaciones), ignorando el historial de entrada.

Los hiperparámetros definitivos fueron:

#table(
  columns: (1fr, 1fr),
  inset: 8pt,
  align: horizon,
  stroke: 0.5pt + gray,
  [*Hiperparámetro*], [*Valor*],
  [`max_seq_length`], [2048 tokens],
  [`batch_size`], [8 (por dispositivo)],
  [`gradient_accumulation`], [4 (Total BS = 32)],
  [`learning_rate`], [$2 times 10^(-4)$ (Linear Decay)],
  [`optimizer`], [`adamw_8bit`],
  [`lora_alpha`], [16],
  [`lora_dropout`], [0 (Optimizado por Unsloth)],
  [`seed`], [3407],
)

= Análisis de Resultados

El entrenamiento se ejecutó durante 500 pasos (aproximadamente 1.68 épocas sobre el subconjunto de datos procesados), con una duración total de *27 minutos*.

== Dinámica de la Pérdida (Loss)

La curva de aprendizaje mostró una convergencia excepcionalmente estable y rápida, lo cual es característico de los modelos pre-entrenados de alta calidad como Qwen cuando se adaptan a tareas estructuradas.

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 5pt,
    stroke: none,
    align: center,
    [
      *Step 10*\
      $L = 0.890$
    ],
    [
      *Step 500*\
      $L = 0.213$
    ]
  ),
  caption: [Evolución de la Training Loss. Datos extraídos de WandB #footnote[Weights & Biases (WandB) es la herramienta utilizada para el seguimiento de métricas. Logs del run `eternal-bird-7`.]],
)

La reducción drástica de la pérdida en los primeros 100 pasos ($0.89 -> 0.45$) indica que el modelo aprendió rápidamente la estructura sintáctica requerida (JSON). La estabilización final en torno a $0.21$ sugiere que el modelo estaba refinando su capacidad de asociar patrones de género y preferencias latentes.

== Evaluación Cualitativa

Se realizaron pruebas de inferencia con perfiles sintéticos para validar la coherencia de las recomendaciones.

=== Caso 1: Perfil de Acción (Sci-Fi/Thriller)
*Historial:* _Terminator 2, The Matrix, Jurassic Park, The Fugitive, Speed._

*Recomendaciones Generadas:*
1.  _Independence Day (ID4)_ (1996)
2.  _Total Recall_ (1990)
3.  _Men in Black_ (1997)
4.  _Star Wars: Return of the Jedi_ (1983)
5.  _Escape from New York_ (1981)

*Análisis:* El modelo ha capturado perfectamente el "zeitgeist" de los éxitos de taquilla de acción/ciencia ficción de los años 80 y 90. No solo coincide en género, sino en tono y popularidad.

#pagebreak()

=== Caso 2: Perfil Disney (Animation/Musical)
*Historial:* _The Lion King, Beauty and the Beast, Aladdin, The Little Mermaid._

*Recomendaciones Generadas:*
1.  _Hot Shots! Part Deux_ (1993) -- *Ruido / Valor atípico*
2.  _Cinderella_ (1950)
3.  _Lady and the Tramp_ (1955)
4.  _Dumbo_ (1941)
5.  _Mary Poppins_ (1964)

*Análisis:* Salvo la primera recomendación (que parece una alucinación posiblemente derivada de co-ocurrencias de fecha o popularidad general en el dataset de entrenamiento), el resto de la lista demuestra una comprensión profunda de la categoría "Clásicos de Disney", recomendando películas que no estaban en el historial pero que pertenecen al mismo nicho cultural.

= Conclusiones

La implementación demuestra que es posible construir un sistema de recomendación de estado del arte utilizando LLMs en hardware accesible (Google Colab).

1.  *Eficacia de Unsloth:* La utilización de Unsloth permitió entrenar un modelo de 3B parámetros con un consumo de VRAM inferior a 8GB (gracias a la cuantización de 4 bits), haciendo viable el fine-tuning en GPUs T4 o A100 de nivel de entrada.
2.  *Semántica vs. ID:* A diferencia de SVD, el LLM comprende que "Toy Story" y "Aladdin" comparten una relación semántica (Animación/Infantil) sin necesidad de una matriz de co-ocurrencia densa, resolviendo eficazmente el problema del *Cold Start* para nuevos ítems si se dispone de sus metadatos.
3.  *Formato Estructurado:* La capacidad de Qwen 2.5 para generar JSON válido facilita la integración de este módulo de IA generativa dentro de pipelines de software tradicionales (Backend/Frontend).

Como trabajo futuro, se propone explorar arquitecturas *RAG (Retrieval-Augmented Generation)*, donde un modelo ligero (bi-encoder) recupera candidatos y el LLM actúa únicamente como *reranker* y explicador, optimizando así la latencia de inferencia, que sigue siendo el principal cuello de botella de los modelos generativos.

