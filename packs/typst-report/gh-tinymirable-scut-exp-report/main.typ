#import "template.typ": *

#set outline(title: "Table of contents")

// Base on Bubble template
#show: scut_ex_report.with(
  title: "课程名称",
  subtitle: "实验报告",
  author: "作者姓名",
  ex_title: "OpenMP、MPI 并行编程",
  // student information
  student_id: "202500000000",
  student_name: "学生姓名",
  college: "学院名称",
  instructor: "任课教师姓名",
  course_name: "课程名称",
  course_id: "045101911",
  affiliation: "University",
  date: datetime.today().display(),
  year: "Year",
  class: "Class",
  other: ("Made with Typst", "https://typst.com"),
  //main-color: "4DA6FF", //set the main color
  logo: image("assets/scut_logo.png"), //set the logo
) 

// Edit this content to your liking

= 实验目的

This is a simple template that can be used for a report.

= 实验要求
== 实验过程
The main color can be set with the `main-color` property, which affects inline code, lists, links and important items. For example, the words highlight and important are highlighted !

- These bullet
- points
- are colored

+ It also
+ works with
+ numbered lists!

== Customized items


Figures are customized but this is settable in the template file. You can of course reference them  : @ref.

#figure(caption: [Code example],

```rust
fn main() {
  println!("Hello Typst!");
}
```
)<ref>

```rust
fn main() {
  println!("Hello Typst!");
}
```
#pagebreak()
== 实验结果
== 实验分析
== 实验小结



= Enjoy !

#lorem(100)