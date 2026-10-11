= Глава 2 <ch:ch02>

== Раздел 1 <sec:ch02-sec01>

=== Подраздел 1 <subsec:ch02-sec01-sub01>

Пример ссылки на рисунок в документе @fig:example03.
#figure(
  image("images/fibonacci.png", width: 50%),
  caption: [Пример рисунка в формате PNG.],
) <fig:example03>

Пример ссылки на рисунок в документе @fig:example04.
#figure(
  image("images/fibonacci.svg", width: 50%),
  caption: [Пример рисунка в формате SVG.],
) <fig:example04>

=== Подраздел 2 <subsec:ch02-sec01-sub02>

== Раздел 2 <sec:ch02-sec02>

=== Подраздел 1 <subsec:ch02-sec02-sub01>

=== Подраздел 2 <subsec:ch02-sec02-sub02>

Пример ссылки на таблицу в документе @tab:example03.
#figure(
  kind: table,
  supplement: "Таблица",
  table(
    columns: (3cm, 3cm, 3cm, 5cm),
    [Минимальные требования], [1], [2], [3],
    [Версия операционной системы], [1], [2], [3],
    [Процессор], [1], [2], [3],
    [Графический API], [1], [2], [3],
  ),
  caption: [Системные требования],
) <tab:example03>

Пример ссылки на таблицу в документе @tab:example04.
#figure(
  kind: table,
  supplement: "Таблица",
  table(
    columns: (3cm, 3cm, 3cm, 5cm),
    [Минимальные требования], [1], [2], [3],
    [Версия операционной системы], [1], [2], [3],
    [Процессор], [1], [2], [3],
    [Графический API], [1], [2], [3],
  ),
  caption: [Системные требования],
) <tab:example04>

Пример оформления кода и ссылка на этот код @code:example03.
#figure(
  kind: "listing",
  supplement: "Листинг",
  ```c
  #include <stdio.h>
  #include <omp.h>
  #define N 100

  int main(int argc, char *argv[]) {
    double a[N], b[N], c[N];
    int i;
    omp_set_dynamic(0);
    omp_set_num_threads(10);
    for (i = 0; i < N; i++) {
        a[i] = i * 1.0;
        b[i] = i * 2.0;
    }
  #pragma omp parallel for shared(a, b, c) private(i)
     for (i = 0; i < N; i++)
       c[i] = a[i] + b[i];

    printf ("%f\n", c[10]);
    return 0;
  }
  ```,
  caption: [Вычисление последовательности Фибоначчи],
) <code:example03>

Пример оформления кода и ссылка на этот код @code:example04.
#figure(
  kind: "listing",
  supplement: "Листинг",
  ```c
  #include <stdio.h>
  #include <omp.h>
  #define N 100

  int main(int argc, char *argv[]) {
    double a[N], b[N], c[N];
    int i;
    omp_set_dynamic(0);
    omp_set_num_threads(10);
    for (i = 0; i < N; i++) {
        a[i] = i * 1.0;
        b[i] = i * 2.0;
    }
  #pragma omp parallel for shared(a, b, c) private(i)
     for (i = 0; i < N; i++)
       c[i] = a[i] + b[i];

    printf ("%f\n", c[10]);
    return 0;
  }
  ```,
  caption: [Сложение двух массивов параллельно десятью потоками (пример из https://ru.wikipedia.org/wiki/OpenMP)],
) <code:example04>
