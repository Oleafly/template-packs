#import "../template.typ": *

#show: assign_class.with(
  student_id: "22012345678",
  student_name: "张三",
  student_class: "1970 级软件工程",
  student_no: "51",
  course_name: "数据库系统",
  semester: "2024 年秋季学期",
  teacher_name: "何日火",
  finish_date: datetime(
    year: 2024,
    month: 10,
    day: 26,
  ),
  lab_date: "周三 5-6 节（单周）",
  lab_title: "使用商用数据库SQLServer或MySQL实现教务系统的数据库设计",
  fill-page: true,
)

#show figure.where(kind: image): it => {
  set image(width: 67%)
  it
}

= 实验要求（10%）

实验要求。

+ 创建教务系统各数据库表，包括：Student, Course, SC。设置主键和外键，以及用户定义的完整性约束条件。
+ 输入数据，体验实体完整性、参照完整性、以及用户定义的完整性约束。

= 实验内容及步骤（80%）

使用以下 SQL 语句创建数据库 lab2：

```sql
use master;
go
create database lab2;
go
```

- 列表1
- 列表2

$ e = m c^2 $

= 心得总结（写出自己在完成实验过程中遇到的问题、解决方法，以及体会、收获等）（10%）

真难啊，学计算机。

分页一下吧。
#pagebreak(fill-rest: true)

分页后的内容。