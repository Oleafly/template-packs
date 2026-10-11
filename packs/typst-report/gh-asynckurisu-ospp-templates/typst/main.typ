#import "template/template.typ": *
#import "config.typ": *

#show: body => osppdoc(config-dict, body)

#front-matter[
  #thesis-contents()
]

#mainbody(config-dict)[
  // 章节层级说明：
  // = 项目实现方案                  -> 第三章 项目实现方案
  // == RISC-V64 运行兼容验证与最小修复 -> 3.1 RISC-V64 运行兼容验证与最小修复
  // === 三级标题                    -> 3.1.1 三级标题
  // ==== 四级标题                   -> 3.1.1.1 四级标题

  = 项目概述

  在这里填写项目概述。可按当前项目的结构说明背景、现状、目标和最终成果。

  - *分点叙述 1：*在这里填写目标和验收方式。
  - *分点叙述 2：*在这里填写目标和验收方式。
  - *分点叙述 3：*在这里填写目标和验收方式。

  = 项目理解和现有实现分析

  在这里填写对仓库当前实现的理解，展现对仓库的了解程度和与当前项目的联系。

  == 二级标题

  === 三级标题

  ==== 四级标题

  这是一个公式：

  $
    E = M c^2
  $<equal>

  可以通过@equal 来引用。

  对于部分复杂的 Latex 公式，Typst原生不支持，需要导入 mitex 进行编写，引用时@latex-euqation 进行引用，与常规公式共用计数。

  #mitex(`
    \begin{cases}
    \lambda = \frac{y_2 - y_1}{x_2 - x_1} \\
    x_3 = \lambda^2 - x_1 - x_2 \\
    y_3 = \lambda(x_1 - x_3) - y_1
    \end{cases}
  `)<latex-euqation>

  图片文件可放在当前目录，也可放在子目录时需写相对路径，例如 `image("figures/demo.png")`。设置标签后，可以通过 @fig-logo-example 引用图片。会浮动的图表，可以根据段落自由调整位置。设置不会浮动的表需要将 placement 参数设置为 none，例如不会浮动的 @fig-logo-example-fixed:

  #figure(
    image("Logo.png", width: 35%),
    caption: [不会浮动的图片示例],
    placement: none
  ) <fig-logo-example-fixed>

  #figure(
    image("Logo.png", width: 35%),
    caption: [会浮动的图片示例],
  ) <fig-logo-example>

  代码块可用 `raw` 或 Markdown 风格围栏代码。设置标签后，可以通过 @lst-dynamic-datasource 引用代码。

  #figure(
    raw(
      "public synchronized DataSourceService getDataSource() {\n    if (DatasourceConfiguration.isEmbeddedStorage()) {\n        return localDataSourceService;\n    }\n    return basicDataSourceService;\n}",
      lang: "java",
      block: true,
    ),
    caption: [代码块示例],
  ) <lst-dynamic-datasource>

  伪代码可以采用 lovelace 的 pseudocode-list 进行编写，同样使用@ScalarMultiplication 引用。

  #figure(
  kind: "algorithm",
  supplement: [Algorithm],
  pseudocode-list(booktabs: true, numbered-title: [二进制标量乘法#h(19em)])[
    - *输入：* 点$P$，$n$比特的整数$k = sum_(i = 0)^(n - 1)k_i 2_i, k_i in {0, 1}$
    - *输出：* $Q = [k]P$
    + 设定$Q = O$。
    + *for* $i$ in [$n - 1..0$], *do*
      + $Q = [2]Q$;
      + *if* $k_i = 1$, *then*
        + $Q = Q + P$;
      + *end if*
    + *end for*
    + 返回$Q$
    ]
  ) <ScalarMultiplication>

  表格推荐使用三线表写法。设置标签后，可以通过 @tab-test-scope 引用表格。

  #figure(
    table(
      columns: (3.2cm, 1fr),
      stroke: none,
      inset: 6pt,
      align: left,
      table.hline(stroke: 0.8pt),
      table.header([*类型*], [*覆盖内容*]),
      table.hline(stroke: 0.5pt),
      [OpenAPI 测试], [填写接口测试覆盖范围。],
      [Java SDK 测试], [填写客户端测试覆盖范围。],
      [集群测试], [填写多节点和恢复场景。],
      table.hline(stroke: 0.8pt),
    ),
    caption: [表格示例],
  ) <tab-test-scope>

  = 项目实现方案

  在这里填写具体实现方案，给出初步实现思路。

  = 验证方案

  在这里填写验证方案。参考文献使用 `@nacos` 形式引用，例如：Nacos 是服务发现和配置管理平台 @nacos。

  = 项目开发时间规划

  在这里填写项目开发时间规划。

  #figure(
    table(
      columns: (2.2cm, 1.15fr, 1fr),
      stroke: none,
      inset: 6pt,
      align: left,
      table.hline(stroke: 0.8pt),
      table.header([*时间段*], [*主要工作*], [*预期成果*]),
      table.hline(stroke: 0.5pt),
      [第 1 周], [填写主要工作。], [填写预期成果。],
      [第 2 周], [填写主要工作。], [填写预期成果。],
      [第 3 周], [填写主要工作。], [填写预期成果。],
      table.hline(stroke: 0.8pt),
    ),
    caption: [项目开发时间规划示例],
  ) <tab-schedule>

  = 个人情况

  == 基本情况与技术储备

  在这里填写个人基本情况与技术储备。

  == 开源经历

  在这里填写开源经历。

  == 项目沟通安排

  在这里填写项目沟通安排。
]

#after-matter[
  #bib("ref.bib")
]
