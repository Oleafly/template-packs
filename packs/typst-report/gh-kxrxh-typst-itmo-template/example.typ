#import "itmo/lib.typ": *

#show: setup

// Generate the ITMO title page
#itmo-title-page(
  labn: "1",
  worktype: "Лабораторная работа",
  discipline: "Программная инженерия",
  group: "P12345",
  student1: "Иванов Иван Иванович",
  student2: "Петров Петр Петрович",
  teacher: "Сидоров Сидор Сидорович",
  year: "2025"
)
#outline(title: "Содержание", depth: 3)
#pagebreak()


= Введение

Это пример использования Typst шаблона для лабораторных работ ИТМО, портированного из LaTeX.

Это пример использования Typst шаблона для лабораторных работ ИТМО, портированного из LaTeX.

Это пример использования Typst шаблона для лабораторных работ ИТМО, портированного из LaTeX.

== Цель работы

Изучить возможности Typst для создания документов и сравнить с LaTeX.

= Теоретическая часть

== Основные понятия

Typst - это современная система верстки документов, альтернатива LaTeX.

= Практическая часть

== Примеры кода

=== Простой код на Rust

```rust
fn main() {
    println!("Hello, ITMO!");
    let x = 42;
    println!("The answer is: {}", x);
}
```

=== Код на Rust

```rust
use std::io;

fn main() {
    println!("Enter your name:");
    let mut name = String::new();
    io::stdin().read_line(&mut name)
        .expect("Failed to read line");
    println!("Hello, {}!", name.trim());
}
```

=== Код на Java (как в оригинальном LaTeX)

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, ITMO!");
        int number = 42;
        System.out.println("Number: " + number);
    }
}
```



= Изображения

== Пример изображения

#figure(
  image("itmo/itmo.png", width: 80%),
  caption: [Логотип ИТМО]
)

= Математические формулы

== Примеры формул

Простая формула: $E = m ^2$

Более сложная формула с использованием функции:
$ integral_0^1 f(x) dif x = lim_(n->infinity) sum_(i=1)^n f(x_i) Delta x $

= Таблицы

== Пример таблицы

#table(
  columns: 3,
  align: (left, center, right),
  table.header(
    [Название], [Значение], [Единицы]
  ),
  [Переменная x], [42], [шт.],
  [Константа π], [3.14159], [—],
  [Скорость света], [299792458], [м/с]
)

= Заключение

В данной работе мы рассмотрели основные возможности Typst для создания лабораторных отчетов ИТМО. Шаблон успешно портирован из LaTeX и предоставляет аналогичный функционал.
