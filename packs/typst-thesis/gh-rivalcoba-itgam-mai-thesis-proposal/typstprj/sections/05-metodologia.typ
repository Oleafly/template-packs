= Metodología

La @fig:logotipo-ejemplo muestra cómo insertar una imagen con su caption y una referencia cruzada desde el texto.

#figure(
  image("../figures/Logotipo_Maestria_oficial-01.png", width: 45%),
  caption: [Logotipo de la Maestría: ejemplo de imagen con caption.],
) <fig:logotipo-ejemplo>

== Diseño de investigación

Indique el tipo de estudio, las fases del proyecto y la estrategia de validación. Justifique la relación entre cada objetivo específico y las actividades metodológicas.@Long2015

== Datos y preparación

Describa las fuentes, los criterios de inclusión y exclusión, la calidad de los datos, el tratamiento de valores faltantes, el etiquetado y la partición para entrenamiento, validación y prueba.

== Modelos y línea base

Defina los modelos candidatos, la línea base y el procedimiento de ajuste. Documente las decisiones necesarias para favorecer la reproducibilidad. Por ejemplo, para una red neuronal con $m$ observaciones, la función de costo de error cuadrático medio se expresa en la @eq:costo-red-neuronal.

$
  J(theta) = 1/m sum_(i=1)^m (f_theta(x_i) - y_i)^2
$ <eq:costo-red-neuronal>

== Evaluación

Especifique métricas técnicas y criterios del dominio. Incluya análisis de error, comparación con la línea base y, cuando corresponda, pruebas estadísticas.

== Consideraciones éticas

Analice privacidad, sesgo, explicabilidad, seguridad y posibles impactos. Señale las medidas de mitigación y las restricciones de uso del sistema.
