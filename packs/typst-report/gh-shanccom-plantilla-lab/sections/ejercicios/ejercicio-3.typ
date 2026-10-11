= Ejercicio 3

== Enunciado

Instrucciones del tercer ejercicio.

== Desarrollo

Solución desarrollada por el integrante encargado.

```python
# Solución del Ejercicio 3
def busqueda_binaria(arr, objetivo):
    izq, der = 0, len(arr) - 1
    while izq <= der:
        medio = (izq + der) // 2
        if arr[medio] == objetivo:
            return medio
        elif arr[medio] < objetivo:
            izq = medio + 1
        else:
            der = medio - 1
    return -1

lista = [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
print(f"Índice de 23: {busqueda_binaria(lista, 23)}")
```