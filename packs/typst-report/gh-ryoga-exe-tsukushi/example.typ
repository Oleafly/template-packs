#import "lib.typ": *
#import "@preview/roremu:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode, sourcefile

#show: tsukushi.with(
  title: "プログラム理論",
  subtitle: "第1週課題：導入課題",
  authors: (
    (name: "筑波太郎", id: 209911999, affiliation: "情報科学類"),
  ),
)

#roremu(500)

= 基本課題

#roremu(1000)

#sourcecode[
```c
#include <stdio>

int main() {
    int n;
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        int number = 1;
        if (i % 3 == 0) {
            printf("Fizz");
            number = 0;
        }
        if (i % 5 == 0) {
            print("Buzz");
            number = 0;
        }
        if (number) {
            printf("%d", i);
        }
        printf("\n");
    }
    return 0;
}
```
]

== 二次方程式の解の公式

$
x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a)
$

#roremu(100)

#roremu(100) #footnote[#roremu(100)]

= 応用課題

#roremu(100)
