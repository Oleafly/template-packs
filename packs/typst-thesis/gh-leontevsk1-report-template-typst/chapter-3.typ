= Глава 3 <ch:ch03>

Пример ссылок:
+ на главу @ch:ch01;
+ на раздел @sec:ch01-sec01 главы @ch:ch01;
+ на раздел @sec:ch02-sec01 главы @ch:ch02;
+ на приложение на странице #context counter(page).at(<appendix1>).first();
+ на код на странице #context counter(page).at(<code:pi-example>).first().

== Раздел 1 <sec:ch03-sec01>

=== Подраздел 1 <subsec:ch03-sec01-sub01>

=== Подраздел 2 <subsec:ch03-sec01-sub02>

== Раздел 2 <sec:ch03-sec02>

=== Подраздел 1 <subsec:ch03-sec02-sub01>

=== Подраздел 2 <subsec:ch03-sec02-sub02>

Пример ссылки на рисунок в документе @fig:example05.
#figure(
  image("images/fibonacci.png", width: 50%),
  caption: [Пример рисунка в формате PNG.],
) <fig:example05>

Пример ссылки на рисунок в документе @fig:example06.
#figure(
  image("images/fibonacci.svg", width: 50%),
  caption: [Пример рисунка в формате SVG.],
) <fig:example06>

Пример ссылки на таблицу в документе @tab:example05.
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
) <tab:example05>

Пример ссылки на таблицу в документе @tab:example06.
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
) <tab:example06>

Пример оформления кода и ссылка на этот код @code:example05.
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
) <code:example05>

Пример оформления кода и ссылка на этот код @code:example06.
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
) <code:example06>
