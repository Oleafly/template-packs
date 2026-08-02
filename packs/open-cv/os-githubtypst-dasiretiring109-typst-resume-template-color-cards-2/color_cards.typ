#set page(margin: (x: 1.25cm, y: 1.2cm))
#set text(font: ("Noto Sans CJK SC", "Source Han Sans SC", "DejaVu Sans"), size: 10pt, lang: "zh")
#set par(justify: true, leading: 0.65em)

#let card(title, body) = box(
  stroke: 0.8pt + rgb("#f59e0b"),
  radius: 0.18em,
  inset: 0.45em,
  [
    #text(fill: rgb("#92400e"), weight: "bold", title)
    #v(0.2em)
    #body
  ],
)

#align(center)[
  #text(2em, weight: "bold", fill: rgb("#b45309"))[高松灯]
  #linebreak()
  运动控制算法工程师（强化学习方向）
  #linebreak()
  138XXXX8899 · #link("mailto:gaosongdeng@163.com")[gaosongdeng\@163.com] · 北京市
]

#v(0.55em)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.6em,
  row-gutter: 0.6em,
  card("基本信息", [
    学校：北京理工大学\
    学历：本科\
    GitHub：#link("https://github.com/gaosongdeng-rl")[gaosongdeng-rl]
  ]),
  card("教育背景", [
    2020.09 - 2024.06\
    北京理工大学 机器人工程\
    GPA 3.8/4.0（专业前5%），综测前8%（2/25）
  ]),
  card("实习经历", [
    北京智元机器人科技有限公司（2023.07 - 2023.09）\
    运动控制算法实习生（RL方向）\
    - 越障成功率提升35%\
    - 动作误差从12%降至5%\
    - 动态行走能耗降低18%
  ]),
  card("项目经历", [
    四足机器人RL动态步态生成与抗扰动控制（算法负责人）\
    - 训练效率提升40%，稳定性达92%\
    人形机器人AMP复刻与泛化（核心开发）\
    - 复刻相似度95%，成功率70%→90%\
    机械臂RL+PID柔顺装配（算法开发）\
    - 力控误差±5N→±1N，合格率85%→98%
  ]),
  card("专业技能", [
    强化学习：PPO / SAC / TD3 / DDPG\
    仿真开发：Isaac Gym / MuJoCo / PyTorch\
    控制部署：RL+PID/前馈/MPC，ONNX/TensorRT\
    工程协同：EtherCAT / CANopen
  ]),
  card("荣誉证书", [
    2023.10 RoboMaster 国家级二等奖\
    2023.05 北京市机械创新设计大赛 省级一等奖\
    2022.12 北理工优秀科研创新奖\
    2022.06 北理工机器人控制算法竞赛 院级一等奖
  ]),
)
