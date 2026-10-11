#set page(margin: (x: 2.1cm, y: 1.9cm))
#set text(font: ("New Computer Modern", "Source Han Serif SC", "Noto Serif CJK SC", "DejaVu Serif"), size: 10pt, lang: "zh")
#set par(justify: true, leading: 0.72em)

#let blue = rgb(56, 115, 192)
#let gray = rgb(128, 128, 128)

#show heading.where(level: 1): it => block(width: 100%)[
  #text(fill: blue, weight: "bold", it.body)
  #v(0.15em)
  #line(length: 100%, stroke: 0.8pt + blue)
]

#let info() = align(center)[
  ☎ 138XXXX8899 #h(0.7em) ✉ gaosongdeng\@163.com #h(0.7em) 🌐 github.com/gaosongdeng-rl #h(0.7em) 📍 北京市
]

#let date(body) = text(fill: gray, body)
#let project(title, role, period, tech, body) = [
  #grid(
    columns: (1fr, 3.2cm),
    column-gutter: 0.7em,
    align: (left, right),
    [*#title* · #role],
    [#date(period)],
  )
  #emph(tech)
  #body
  #v(0.3em)
]

#align(center)[#text(2.35em, weight: "regular")[高松灯]]
#info()

= 基本信息
求职意向：运动控制算法工程师（强化学习方向）

= 教育背景
*北京理工大学* #h(0.8em) 机器人工程（本科） #h(1fr) #date[2020.09 -- 2024.06]\
GPA 3.8/4.0（专业前5%） · 综测前8%（2/25）\
核心课程：机器人运动学与动力学、强化学习原理与应用、现代控制理论、深度学习、多刚体动力学、最优控制、机器人仿真技术

= 实习经历
#table(
  columns: (5fr, 2.4fr, 2.6fr),
  align: (left, left, right),
  stroke: none,
  column-gutter: 0.8em,
  inset: (x: 0pt, y: 0.3em),
  [*北京智元机器人科技有限公司*], [运动控制算法实习生（RL方向）], [#date[2023.07 -- 2023.09]],
  [
    #table.cell(colspan: 3)[
      - 基于Isaac Gym搭建四足机器人强化学习训练环境，优化PPO奖励函数，越障成功率提升35%。\
      - 参与仿真到实机迁移，结合域随机化与系统辨识，将动作误差从12%降至5%。\
      - 参与RL+前馈复合控制架构实现，负责关节力矩控制模块，动态行走能耗降低18%。
    ]
  ],
)

= 专业技能
- 强化学习：PPO、SAC、TD3、DDPG；掌握奖励函数设计与训练稳定性调优
- 仿真开发：Isaac Gym、MuJoCo、PyTorch、URDF/MJCF建模、并行训练
- 控制部署：RL+PID/前馈/MPC复合控制，ONNX/TensorRT加速，Jetson实时部署
- 工程协同：熟悉EtherCAT/CANopen通讯，可完成算法与伺服驱动/传感器对接

= 获奖情况
#table(
  columns: (5.5fr, 2.2fr, 2.3fr),
  align: (left, left, right),
  stroke: none,
  inset: (x: 0pt, y: 0.28em),
  [*全国大学生机器人竞赛（RoboMaster）机甲大师赛*], [*国家级二等奖*], [#date[2023.10]],
  [*北京市大学生机械创新设计大赛*], [*省级一等奖*], [#date[2023.05]],
  [*北京理工大学“优秀科研创新奖”*], [*校级*], [#date[2022.12]],
  [*北京理工大学机器人控制算法竞赛*], [*院级一等奖*], [#date[2022.06]],
)

= 项目经历
#project(
  "机器人RL动态步态生成与抗扰动控制",
  "算法负责人",
  "2023.03 -- 2023.06",
  "PPO+TD3 · 域随机化 · Isaac Gym · TensorRT",
  [
    - 设计分层奖励函数，训练效率提升40%。
    - 实机在15°斜坡和5cm凸起砂石路稳定性达92%，较传统方案提升45%。
  ],
)

#project(
  "人形机器人AMP的人体运动复刻与泛化",
  "核心开发",
  "2022.09 -- 2023.02",
  "AMP · BC · MuJoCo · URDF",
  [
    - 处理1000+帧动捕数据，动作复刻相似度达95%。
    - 域自适应后在0.2-0.8摩擦系数地面成功率从70%提升至90%。
  ],
)

#project(
  "RL+PID复合控制的机械臂柔顺装配系统",
  "算法开发",
  "2022.03 -- 2022.08",
  "SAC · 阻抗控制 · ROS2 · Jetson Xavier NX",
  [
    - 基于SAC优化PID调节策略，装配力控制误差从±5N降至±1N。
    - 轴承压装合格率从85%提升至98%，部署延迟≤10ms。
  ],
)
