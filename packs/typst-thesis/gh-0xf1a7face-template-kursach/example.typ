// Лорем-наполнитель с не повторяющимся текстом -- его можно вырезать
#let builtin_lorem = lorem
#let lorem(n) = context {
  let off = counter("lorem").get().at(0)
  builtin_lorem(off + n)
    .replace(regex("\S+ "), "", count: off)
    .replace(regex("\.$"), "")
    .replace(regex("^."), s => upper(s.text))
  counter("lorem").update(n)
}

#import "template-kursach.typ"
#show: template-kursach.template

#[
  #set page(margin: (left: 2cm, right: 0.5cm))

  #set page(numbering: none)
  #set par(justify: false)
  #set align(center)
  МИНИСТЕРСТВО ОБРАЗОВАНИЯ РЕСПУБЛИКИ БЕЛАРУСЬ \
  БЕЛОРУССКИЙ ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ \
  ФАКУЛЬТЕТ ПРИКЛАДНОЙ МАТЕМАТИКИ И ИНФОРМАТИКИ \
  #v(12em)
  ОТЧЁТ \
  #lorem(8) \
  // РЕФЕРАТ \
  // \
  // по предмету: \
  // #lorem(2) \
  // \
  // на тему: \
  // #lorem(8) \
  #v(10em)
  #set align(right)
  #block(width: 40%)[
    #set align(left)
    студента 1 курса, 1 группы \
    специальности «Информатика» \
    John A. Smith \
    // Выполнил: \
    // John A. Smith \
    // студент 1 курса, 1 группы \
    // специальность «Информатика» \
    \
    Руководитель: \
    старший преподаватель \
    кафедры #lorem(4) \
    Jane M. Doe \
    // Руководитель: \
    // Jane M. Doe \
    // старший преподаватель \
    // кафедры #lorem(4) \
  ]
  #v(1fr)
  #set align(center)
  Минск, #datetime.today().display("[year]") \
  #pagebreak()
]

#outline(indent: n => if n == 0 { 0em } else { 1em }, title: "Оглавление")

= Введение

#lorem(24).

#lorem(2):

- #lorem(10).
- #lorem(20).
- #lorem(25).
- #lorem(7).

= #lorem(2)

== #lorem(3)

#lorem(38).

#lorem(47).

== #lorem(4)

#lorem(23).

#lorem(1):

```
int x = a + 5;
```

#lorem(8):

```
DeclStmt
  VarDecl: int x
    BinaryOperator: '+'
      DeclRefExpr: a
      IntegerLiteral: 5
```

#lorem(10) #ref(<clang_ast_intro>).

== #lorem(2)

#lorem(10).

#lorem(44).

#lorem(2):

```
using namespace clang::ast_matchers;
auto matcher = callExpr(callee(functionDecl(hasName("printf"))));
```

#lorem(22):

```
class FindPrintf : public MatchFinder::MatchCallback {
public:
  void run(const MatchFinder::MatchResult &Result) override {
    if (const auto *Call = Result.Nodes.getNodeAs<CallExpr>("call")) {
      llvm::outs() << "Found printf at:\n";
      Call->dump();
    }
  }
};
```

#lorem(9).

- #lorem(10).

- #lorem(8).

#lorem(16).

== #lorem(3)

#lorem(40).

#lorem(24).

#lorem(33).

#figure(image("./figure1.jpg", width: 75%), caption: [
  Kasane Teto - Teto territory #ref(<teto>) \
  youtube.com/watch?v=JALbemLw3G4
]) <fig:teto>

= #lorem(4)

== #lorem(5)

#lorem(45)

== #lorem(4)

#lorem(65)

#lorem(25)

#figure(image("./figure2.jpg"), caption: [
  Sousou no Frieren 2nd Season. #ref(<frieren>)
]) <fig:frieren>

= Заключение

#lorem(45).

#lorem(55).

#lorem(37).

#lorem(81).

#lorem(81).

= Список использованных источников

#bibliography(
  "./example.bib",
  full: true,
  style: "gost-r-705-2008-numeric",
  title: none,
)

// vim:spelllang=en,ru
// vim:textwidth=80
