// 公式全局设置函数
#let math_setup(body) = {
  // 设置公式编号格式
  set math.equation(numbering: (..nums) => {
    let chapter = counter(heading).at(here()).at(0) // 获取当前章节号
    let eq_num = nums.pos().last()
    str("(" + str(chapter) + "-" + str(eq_num) + ")")
  })

  // 公式与上下正文间距
  show math.equation.where(block: true): set block(above: 0.8em, below: 0.8em)

  // 处理引用样式
  show ref: it => {
    let el = it.element
    if el != none and el.func() == math.equation {
      link(el.location(), [#it])
    } else {
      it
    }
  }

  body
}

// 定义常用的数学物理量快捷键
// #let dx = $d x$
// #let dy = $d y$
// #let result = $italic("result")$