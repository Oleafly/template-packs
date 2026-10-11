#import "template/lib.typ": *

#show: conf.with(
  pic: "placeholder.png",
  name: "张三",
  sex: "男",
  birthday: "2001-01-01",
  phone: "19999999999",
  email: "email@example.com",
  address: "xx省xx市xx区xx路xx号",
)

#container(
  title: "校园经历",
  [

    #triple(
    "2019.09 - 2023.06",
    "xx大学",
    "计算机科学与技术"
    )
  ]
)

#container(
  title: "技能",
  [
    #pair("编程语言", "C, C++, Java, Python, JavaScript")
    #pair("技术栈", "React, Vue, Node.js, Spring Boot, Flask")
  ]
)
