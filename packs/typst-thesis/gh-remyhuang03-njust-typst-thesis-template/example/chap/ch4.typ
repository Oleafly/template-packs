#let ch4 = [
  = 实验设置与结果

  == 数据集划分

  训练集、验证集、测试集比例设置为 7:2:1，本节仅作为结构演示。

  == 结果对比

  #figure(
    table(
      columns: (auto, auto, auto),
      table.header([方案], [准确率], [耗时]),
      [Baseline], [0.81], [120 ms],
      [Dummy-A], [0.86], [135 ms],
      [Dummy-B], [0.89], [149 ms],
    ),
    caption: [Dummy 结果对比表],
  ) <tab:result_cmp>

  如表@tab:result_cmp，示例方法在虚构指标上表现更好。
]
