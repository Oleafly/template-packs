#let dark = rgb("#131A28")

#set page(
  margin: (left: 15mm, right: 15mm, top: 10mm, bottom: 12mm),
  footer: [
    #set text(fill: gray, size: 8pt)
    #grid(
      columns: (1fr, 1fr, 1fr),
      align(left)[#smallcaps[Mar 2026]],
      align(center)[#smallcaps[Gao #sym.dot.c Songdeng #sym.dot.c Resume]],
      align(right)[#context counter(page).display()],
    )
  ],
)
#set text(font: ("Source Sans Pro", "Noto Sans CJK SC", "DejaVu Sans"), size: 11pt, fill: dark)
#set par(justify: true, leading: 0.66em)

#let sec(title) = [
  #v(0.55em)
  #set text(size: 15pt)
  #smallcaps(strong(title))
  #box(width: 1fr, line(length: 100%))
  #set text(size: 11pt)
]

#align(center)[
  #set text(size: 31pt, font: ("Roboto", "Source Sans Pro", "DejaVu Sans"))
  #text(weight: "thin")[GAO] #text(weight: "bold")[SONGDENG]
]

#align(center)[
  #smallcaps[Motion Control Algorithm Engineer #sym.dot.c Reinforcement Learning]
]

#align(center)[
  ☎ 138XXXX8899 #h(0.65em) ✉ gaosongdeng\@163.com #h(0.65em) 🌐 github.com/gaosongdeng-rl #h(0.65em) 📍 北京市
]

#sec("Education")
*北京理工大学* #h(1fr) 2020.09 -- 2024.06\
机器人工程（本科），GPA 3.8/4.0（专业前5%），综测前8%（2/25）\
核心课程：机器人运动学与动力学、强化学习原理与应用、现代控制理论、深度学习、多刚体动力学、最优控制、机器人仿真技术

#sec("Work Experience")
*北京智元机器人科技有限公司* #h(1fr) 2023.07 -- 2023.09\
_运动控制算法实习生（RL方向）_\
- 基于Isaac Gym搭建四足机器人强化学习训练环境，优化PPO奖励函数，越障成功率提升35%。
- 参与仿真到实机迁移，结合域随机化与系统辨识，将动作误差从12%降至5%。
- 参与RL+前馈复合控制架构实现，负责关节力矩控制模块，动态行走能耗降低18%。

#sec("Projects")
*机器人RL动态步态生成与抗扰动控制* #h(1fr) 2023.03 -- 2023.06\
- 算法负责人；设计分层奖励函数，训练效率提升40%。
- 实机在15°斜坡和5cm凸起砂石路稳定性达92%，较传统方案提升45%。

*人形机器人AMP的人体运动复刻与泛化* #h(1fr) 2022.09 -- 2023.02\
- 核心开发；处理1000+帧动捕数据，动作复刻相似度达95%。
- 域自适应后在0.2-0.8摩擦系数地面成功率从70%提升至90%。

*RL+PID复合控制的机械臂柔顺装配系统* #h(1fr) 2022.03 -- 2022.08\
- 算法开发；基于SAC优化PID调节策略，装配力控制误差从±5N降至±1N。
- 轴承压装合格率从85%提升至98%，Jetson Xavier NX部署延迟≤10ms。

#sec("Skills")
- 强化学习：PPO、SAC、TD3、DDPG；掌握奖励函数设计与训练稳定性调优\
- 仿真开发：Isaac Gym、MuJoCo、PyTorch、URDF/MJCF建模、并行训练\
- 控制部署：RL+PID/前馈/MPC复合控制，ONNX/TensorRT加速，Jetson实时部署\
- 工程协同：熟悉EtherCAT/CANopen通讯，可完成算法与伺服驱动/传感器对接

#sec("Honors")
- 2023.10 全国大学生机器人竞赛（RoboMaster）机甲大师赛，国家级二等奖
- 2023.05 北京市大学生机械创新设计大赛，省级一等奖
- 2022.12 北京理工大学“优秀科研创新奖”，校级
- 2022.06 北京理工大学机器人控制算法竞赛，院级一等奖
