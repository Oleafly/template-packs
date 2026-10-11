= Ejercicio 1

== Enunciado

Instrucciones del primer ejercicio.

== Desarrollo

Solución desarrollada por el integrante encargado.

```python
# Solución del Ejercicio 1
def resolver_problema(datos):
    resultado = [x * 2 for x in datos if x > 0]
    return resultado

datos = [1, -2, 3, -4, 5]
print(f"Resultado: {resolver_problema(datos)}")
```