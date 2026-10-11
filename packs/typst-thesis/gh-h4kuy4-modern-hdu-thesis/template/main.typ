#import "../lib.typ": thesis-init, appendix

#show: thesis-init.with(
  abstract-cn: [
    中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试

    中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试中文测试
  ],
)

= 导论

== 参考文献

参考文献可是这样用@蒋有绪1998@中国力学学会1990

== 列表

列表无明确格式要求

=== 无序列表

- 无序列表项一
- 无序列表项二
  - 无序子列表项一
  - 无序子列表项二

=== 有序列表

+ 有序列表项一
+ 有序列表项二
  + 有序子列表项一
  + 有序子列表项二

=== 术语列表

/ 术语一: 术语解释
/ 术语二: 术语解释

#pagebreak()

== 图表

引用@tbl:timing，引用@tbl:timing-tlt，以及@fig:test。引用图表时，表格和图片分别需要加上 `tbl:`和`fig:` 前缀才能正常显示编号。

#align(
  center,
  (
    stack(dir: ltr)[
      #figure(
        table(
          align: center + horizon,
          columns: 4,
          [t], [1], [2], [3],
          [y], [0.3s], [0.4s], [0.8s],
        ),
        caption: [常规表],
      ) <timing>
    ][
      #h(50pt)
    ][
      #figure(
        table(
          columns: 4,
          stroke: none,
          table.hline(),
          [t], [1], [2], [3],
          table.hline(stroke: .5pt),
          [y], [0.3s], [0.4s], [0.8s],
          table.hline(),
        ),
        caption: [三线表],
      ) <timing-tlt>
    ]
  ),
)

#figure(
  image("images/test.png", width: 20%),
  caption: [图片测试],
) <test>


== 公式<equation>

引用@eqt:test-equation

$ F_n = floor(1 / sqrt(5) phi.alt^n) $ <test-equation>

== 章节引用

这里引用@equation，这里引用@appendix-1

= 致谢 <acknowledgement>

致谢需要有`<acknowledgement>`标签

#bibliography("reference.bib"),

#show: appendix.with()
= 附录示例<appendix-1>

这里是附录

= 附录示例

这里还是附录
