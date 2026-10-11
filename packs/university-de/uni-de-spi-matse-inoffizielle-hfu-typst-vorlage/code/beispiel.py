"""Beispieldatei, um `quellcode-datei` zu zeigen."""


def fibonacci(n: int) -> int:
    """Berechnet die n-te Fibonacci-Zahl iterativ."""
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a


if __name__ == "__main__":
    print(fibonacci(10))
