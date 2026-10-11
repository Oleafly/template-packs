#import "/template/template.typ": make-cover, make-table-of-contents

#make-cover()
#make-table-of-contents[
  #let color-gray = color.linear-rgb(25.82%, 25.82%, 25.82%)

  *实验 1*

  #h(0.4cm) 1、#h(0.2cm) 数据设计 #text(red)[（用什么类型的变量储存了哪些数据）]

  #h(0.4cm) 2、#h(0.2cm) 算法设计 #text(red)[（可以用伪代码或者流程图的形式给出算法步骤）]

  #h(0.4cm) 3、#h(0.2cm) 主干代码说明 #text(red)[（只对核心代码进行必要说明）]

  #h(0.4cm) 4、#h(0.2cm) 运行结果展示 #text(red)[（通过截图的方式展示运行结果）]

  #h(0.4cm) 5、#h(0.2cm) 总结和收获

  #line(stroke: 0.2pt + color-gray, length: 100%)

  *实验 2*

  #h(0.4cm) 1、#h(0.2cm) 数据设计

  #h(0.4cm) 2、#h(0.2cm) 算法设计

  #h(0.4cm) 3、#h(0.2cm) 主干代码说明

  #h(0.4cm) 4、#h(0.2cm) 运行结果展示

  #h(0.4cm) 5、#h(0.2cm) 总结和收获
  #line(stroke: 0.2pt + color-gray, length: 100%)

  *附录*

  #h(0.4cm) 1、#h(0.2cm) 实验 1 的源代码

  #h(0.4cm) 2、#h(0.2cm) 实验 2 的源代码
  
  #line(stroke: 0.2pt + color-gray, length: 100%)

  #text(red)[说明：上面的目录中结构仅供参考，可以根据题目的不同而有变化，但是一定要至少从设计、实现和运行三个方面说明一个题目]
]
