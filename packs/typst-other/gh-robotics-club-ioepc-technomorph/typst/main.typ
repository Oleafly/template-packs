#import "template.typ": cover

#show: cover.with(
  title: "Day 1: Introduction to Robots and Robotics <Title>",
  by: (
    (
      name: "Issac Asimov <Your Name>",
      rollno: "PUR031ABC041 <Your Roll>",
    ),
  ),
  to: "Albert Einstein <Instructor's Name>",
  logo: "robo.png",
    date: "3014-03-14 <ISO Date>",
)


= Heading
== Second Heading

This is regular text.


```cpp
# This is a code block.
print("Hello")
```

=== Third Heading
- This is an unnumbered list.
- This is also an unnumbered list.

+ This is a numbered list.
+ This is also a numbered list.

#figure(image("logo.png", width: 50%), caption: [Logo of Tribhuvan University.])

#align(center,[
#table(
  columns: 2,
  [One], [Plan],
  [Two], [Draft],
  [Three], [Document],
)
])

You can do almost anything with this typesetting system.

*Bold*
_Italics_
#underline[Underline]
#strike[Strike]

#align(center, [#underline[#strike[*_Everything all at once_*]] Center Aligned])
