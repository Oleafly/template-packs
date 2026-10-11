// =============================================================
// code-examples.typ – Code-Beispiele (Anhang)
// =============================================================

#heading(numbering: "A.1")[Code-Beispiele] <chap-code-beispiele>

// ===================================================================
// ANLEITUNG: Dies ist ein Beispielanhang für Code-Listings.
// Typst hat eingebautes Syntax-Highlighting für alle gängigen
// Programmiersprachen – kein externes Tool nötig!
// ===================================================================

Dieser Anhang demonstriert verschiedene Code-Listings mit Typst's eingebautem Syntax-Highlighting.

== Python-Beispiel
<sec-python-code>

@lst-app-python zeigt ein einfaches Python-Programm mit Syntax-Highlighting.

#figure(
  ```python
  def fibonacci(n):
      """
      Berechnet die n-te Fibonacci-Zahl rekursiv.

      Args:
          n: Index der Fibonacci-Zahl

      Returns:
          Die n-te Fibonacci-Zahl
      """
      if n <= 1:
          return n
      return fibonacci(n - 1) + fibonacci(n - 2)


  # Hauptprogramm
  if __name__ == "__main__":
      for i in range(10):
          print(f"F({i}) = {fibonacci(i)}")
  ```,
  caption: [Python-Implementierung der Fibonacci-Funktion (rekursiv)],
  kind: raw,
  supplement: [Code],
) <lst-app-python>

== Java-Beispiel
<sec-java-code>

@lst-java demonstriert objektorientierte Programmierung in Java.

#figure(
  ```java
  public class HelloWorld {
      private String message;

      /**
       * Konstruktor
       */
      public HelloWorld(String message) {
          this.message = message;
      }

      /**
       * Gibt die Nachricht aus
       */
      public void printMessage() {
          System.out.println(message);
      }

      public static void main(String[] args) {
          HelloWorld hello = new HelloWorld("Hello, World!");
          hello.printMessage();
      }
  }
  ```,
  caption: [Java Hello World mit Klassen],
  kind: raw,
  supplement: [Code],
) <lst-java>

== Scala-Beispiel
<sec-scala-code>

@lst-scala zeigt funktionale Programmierung in Scala.

#figure(
  ```scala
  // Funktionale Programmierung in Scala
  object FunctionalExample {
    // Higher-order functions
    def applyTwice(f: Int => Int, x: Int): Int = f(f(x))

    // Pattern Matching
    def describe(x: Any): String = x match {
      case i: Int if i > 0 => "positive integer"
      case i: Int if i < 0 => "negative integer"
      case 0               => "zero"
      case s: String       => s"string: $s"
      case _               => "something else"
    }

    def main(args: Array[String]): Unit = {
      val increment = (x: Int) => x + 1
      println(applyTwice(increment, 5))  // Output: 7
      println(describe(42))              // Output: positive integer
    }
  }
  ```,
  caption: [Scala Beispiel mit funktionaler Programmierung],
  kind: raw,
  supplement: [Code],
) <lst-scala>

== JSON-Konfiguration
<sec-json-code>

Auch Konfigurationsdateien können formatiert werden:

#figure(
  ```json
  {
    "name": "example-project",
    "version": "1.0.0",
    "dependencies": {
      "react": "^18.0.0",
      "typescript": "^5.0.0"
    },
    "scripts": {
      "build": "tsc",
      "test": "jest"
    }
  }
  ```,
  caption: [package.json Beispiel],
  kind: raw,
  supplement: [Code],
) <lst-app-json>

== Shell-Script
<sec-bash-code>

#figure(
  ```bash
  #!/bin/bash
  # Kompilierungs-Script für Typst

  echo "Starting Typst compilation..."

  # Kompilieren
  typst compile main.typ output.pdf

  echo "Compilation complete!"
  # Für automatisches Neu-Kompilieren bei Änderungen:
  # typst watch main.typ
  ```,
  caption: [Bash-Script für Typst-Kompilierung],
  kind: raw,
  supplement: [Code],
) <lst-app-bash>

// ===================================================================
// HINWEIS: Fügen Sie Ihren eigenen Code hier ein!
// Typst unterstützt u.a.: Python, Java, C, C++, JavaScript, Rust,
// Go, Ruby, SQL, HTML, CSS, Bash, JSON, YAML, Scala, und viele mehr!
// ===================================================================

