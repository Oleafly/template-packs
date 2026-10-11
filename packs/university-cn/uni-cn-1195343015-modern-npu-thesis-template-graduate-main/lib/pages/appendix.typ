#import "../deps.typ": numbly
#import "../layouts/floats.typ": with-numbering-format
#import "../utils.typ": page-title

// 附录页面
#let appendix-page(
  graduate: false,
  english-writing: false,
  it,
) = {
  let appendix-numbering = if english-writing {
    numbly("Appendix {1:A}", "{1:A}.{2}", "{1:A}.{2}.{3}", "({4})", "{5}")
  } else if graduate {
    numbly("附录{1:A}", "{1:A}.{2}", "{1:A}.{2}.{3}", "（{4}）", "{5}）")
  } else {
    numbly("附  录", "{1:A}.{2}", "{1:A}.{2}.{3}",  "（{4}）", "{5}）")
  }

  set heading(numbering: appendix-numbering)
  counter(heading).update(0)

  show: with-numbering-format.with("A-1")

  heading(level: 1)[]
  it
}
