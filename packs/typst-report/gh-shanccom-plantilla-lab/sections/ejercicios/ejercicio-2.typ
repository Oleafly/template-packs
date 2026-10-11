= Ejercicio 2

== Enunciado

Instrucciones del segundo ejercicio.

== Desarrollo

Solución desarrollada por el integrante encargado.

```python
# Solución del Ejercicio 2
def calcular_estadisticas(valores):
    promedio = sum(valores) / len(valores)
    varianza = sum((x - promedio) ** 2 for x in valores) / len(valores)
    return promedio, varianza

prom, var = calcular_estadisticas([10, 12, 23, 23, 16, 23, 21, 16])
print(f"Promedio: {prom:.2f}, Varianza: {var:.2f}")
```