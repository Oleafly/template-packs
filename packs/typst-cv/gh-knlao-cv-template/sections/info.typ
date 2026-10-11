#import "../template/styles.typ": *
#import "../template/cert-listing.typ": cert-listing

= 一、个人资料

#[
  #show table.cell.where(x: 0): set text(weight: "bold")
  #show table.cell.where(x: 2): set text(weight: "bold")
  #set table(fill: (x, _) => if x == 0 or x == 2 or x == 4 {theme-1})
  #table(
    columns: (13%, 20%, 13%, 30%, 24%),
    rows: (0.5in, 0.5in, 0.5in, 0.5in),
    align: (center+horizon, center+horizon, center+horizon, center+horizon, center+horizon),
    [中文姓名], [陈大文],
    [外文姓名], [CHAN Tai Man],
    table.cell(rowspan: 4)[#box(image("../media/you.jpg", height: 1.76in, width: 1.37in,))],
    [性别], [男],
    [出生日期], [1999/02/29],
    [手机号码], [+853 12345678],
    [电邮地址], [?????\@?????.???],
    [现住地址], table.cell(colspan: 3)[宇宙拉尼亚凯亚超星系团室女座星系团本星系群]
  )
]

= 二、教育背景

#table(
  columns: (33.33%, 33.34%, 33.34%),
  rows: (3%),   
  align: (center+horizon, center+horizon, center+horizon),
  [开始年份-结束年份], [XX中学], [高中],
  [开始年份-结束年份], [XX中学], [初中],
)

= 三、其他介绍

#[
  #show table.cell.where(y: 0): set text(weight: "bold")
  #set table(fill: (_, y) => if y == 0 {theme-1})
  #table(
    columns: (33.33%, 33.34%, 33.33%),
    rows: (9%),
    align: (center+horizon, center+horizon, center+horizon),
    table.header([??], [??], [??]),
    table.hline(),
    [??], [??], [??],
    [??], [??], [??],
    [??], [??], [??],
    [??], [??], [??],
    [??], [??], [??],
  )
]

#pagebreak()

= 四、奖项及证书

#cert-listing(yaml("../lists/certs.yaml"))

#pagebreak()