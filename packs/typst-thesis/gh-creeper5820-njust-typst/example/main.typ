#import "../lib.typ" as njust
#set heading(numbering: "1.1.1")

#let thesis-title = "基于多源传感信息融合的室内移动机器人路径规划方法研究"
#let thesis-title-en = "Research on Indoor Mobile Robot Path Planning Based on Multi-source Sensor Fusion"

#njust.thesis-title-state.update(thesis-title)

#njust.cover-standard(
  title: thesis-title,
  student-name: "示例学生",
  student-number: "202600000001",
  supervisor-1: ("示例导师", underline(stroke: 1pt, offset: 2pt)[讲师]),
  supervisor-2: ("", ""),
  department: "智能制造学院",
  major: "自动化",
  research-direction: "移动机器人导航",
  date: "2026年6月",
)

#pagebreak()

#njust.cover-inner-zh(
  title: thesis-title,
  student-name: "示例学生",
  supervisor-1: ("示例导师    讲师",),
  date: "2026年6月",
)

#pagebreak()

#njust.cover-inner-en(
  title: thesis-title-en,
  student-name: "Example Student",
  supervisor-1: "Example Advisor",
  supervisor-2: "",
  date: "June, 2026",
)

#pagebreak()

#njust.declare()

#pagebreak()

#counter(page).update(1)

#njust.summary(
  lang: "zh",
  keywords: (
    "移动机器人",
    "多传感器融合",
    "路径规划",
    "避障控制",
    "室内导航",
  ),
)[
  室内移动机器人在仓储巡检、设备配送与公共服务等任务中具有广泛应用前景，而复杂环境中的感知误差、障碍物动态变化以及路径平滑性要求，都会直接影响导航系统的稳定性与实用性。针对单一传感器在遮挡、噪声和局部观测不足条件下的局限性，本文设计了一种面向室内移动机器人的多源传感信息融合路径规划方法。该方法通过融合激光测距、深度视觉与里程计信息，构建较为稳定的局部环境表征，并结合全局路径搜索与局部动态避障策略，提升机器人在未知或半结构化场景中的通行效率与轨迹跟踪性能。围绕系统实现，本文完成了环境建图、状态估计、路径优化与控制执行等模块设计，并在仿真场景中对规划成功率、路径长度、平均速度与避障安全距离等指标进行了测试。实验结果表明，所提出的方法在复杂室内环境下具有较好的鲁棒性和实时性，可为移动机器人导航系统的工程实现提供参考。
]

#pagebreak()

#njust.summary(
  lang: "en",
  keywords: (
    "mobile robot",
    "multi-sensor fusion",
    "path planning",
    "obstacle avoidance",
    "indoor navigation",
  ),
)[
  Indoor mobile robots are widely used in warehouse inspection, material delivery, and public service scenarios. However, perception errors, dynamic obstacles, and path smoothness requirements in complex environments can significantly affect the stability and practicality of navigation systems. To address the limitations of single-sensor solutions under occlusion, noise, and incomplete local observations, this thesis proposes a path planning method for indoor mobile robots based on multi-source sensor fusion. The method integrates laser ranging, depth vision, and odometry information to build a stable local representation of the environment, and combines global path search with local dynamic obstacle avoidance to improve navigation efficiency and trajectory tracking performance in unknown or semi-structured scenes. This thesis further implements environment mapping, state estimation, path optimization, and motion control modules, and evaluates the system in simulation using planning success rate, path length, average speed, and safety distance metrics. Experimental results show that the proposed method achieves good robustness and real-time performance in complex indoor environments, providing a practical reference for engineering deployment.
]

#pagebreak()

#njust.contents[
  #outline(title: none, indent: 0mm)
]

#pagebreak()

#njust.charts()

#pagebreak()

#counter(page).update(1)

#njust.main-body[
  #include "chapters/01-intro.typ"

  #include "chapters/02-method.typ"

  #include "chapters/03-system.typ"

  #include "chapters/04-experiment.typ"

  #include "chapters/05-conclusion.typ"
]

#pagebreak()

#njust.acknowledge[
  本文示例用于演示模板的组织方式与基本排版效果，相关内容均为匿名化虚构文本，不对应任何真实个人、项目或单位。

  在示例撰写过程中，重点参考了本科毕业论文常见的章节结构、技术表述方式以及前后置部分的组织方法，以便使用者在此基础上快速替换为自己的论文内容。

  同时，感谢所有为开源排版工具、字体适配与学术写作规范整理提供经验的人，这些工作使得模板的复用与维护变得更加高效。
]

#pagebreak()

#njust.reference(read("ref.bib", encoding: none), full: true)

#pagebreak()

#njust.appendix[
  == 附录 A 示例附加说明

  本附录用于展示附录页的标题层级、正文段落与列表排版效果。

  - 可在此处补充额外实验说明。
  - 可在此处列出符号表、接口说明或补充数据。
  - 可在此处放置不适合进入正文但需要归档的材料。

  == 附录 B 示例成果概述

  - 完成一个可复用的本科论文模板示例。
  - 演示封面、摘要、目录、正文、参考文献与附录的完整组织方式。
]
