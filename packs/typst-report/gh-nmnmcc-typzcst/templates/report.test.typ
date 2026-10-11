#import "report.typ": report

#show: doc => report(
  department: "计算机",
  major: "计算机科学与技术",
  course: "高级程序设计",
  students: (("李依馨", "04180424"), ("王五", "04240216")),
  teacher: "张三",
  finish_time: datetime(year: 2025, month: 5, day: 28),
  doc,
)

= Hello, World!

Latin Bold *OK*

CJK Bold *你好*

== Goodbye, World! 你好

以下是一段 `OCaml` 代码
```ml
let more x = (+) 1 x
```

```typescript
const name = "Supersupersupersupersupersupersupersupersupersupersupersupersupersupersuper long name"
console.log(name)
```

= Welcome, World!

#lorem(50)

#figure(image("./report.test.png"), caption: "这是一张图片")
== Bye, World!
=== Go, World!
=== Jump, World!
== Just, World!

