#import "template.typ": *

#let name = "HUANG WENYU"
#let namezh = "黄文禹"
#let email = [
  #icon("email.svg") huangwenyuu\@outlook.com
]
#let phone = [
  #icon("phone.svg")
  (+86) 13860891577
]
#let home = [
  #icon("home.svg")
  #link("https://uran0sh.github.io/blog/")[ uran0sh.github.io/blog/ ]
]
#let github = [
  #icon("github.svg")
  #link("https://github.com/uran0sH")[ uran0sh ]
]
#let linkin = [
  #icon("linkedin.svg")
  #link("https://www.linkedin.com/in/wenyu-huang-298b31262/")[ Wenyu Huang ]
]

#let author = (
  name: name,
  email: email,
  phone: phone,
  home: home,
  github: github,
  linkin: linkin,
)
#let authorzh = (
  name: namezh,
  email: email,
  phone: phone,
  home: home,
  github: github,
  linkin: linkin,
)

#let edutitle = [ Education ]
#let edutitlezh = [ 教育经历 ]
#let edu = [
  #datedsubsection(
    align(left)[
      *#lorem(4)* \
      #lorem(4)
    ],
    align(right)[
      Tokyo, Japan \
      202x - _present_
    ],
  )

  #lorem(32)

  #datedsubsection(
    align(left)[
      *#lorem(4)* \
      #lorem(4)
    ],
    align(right)[
      Aichi, Japan \
      201x - 201x
    ],
  )

  #datedsubsection(
    align(left)[
      *#lorem(4)* \
      #lorem(4)
    ],
    align(right)[
      Aichi, Japan \
      201x - 201x
    ],
  )
]
#let eduzh = [
  #datedsubsection(
    align(left)[
      *香港中文大学（深圳）* \
      计算机与信息工程  硕士 \
      导师：钟叶青 \
      GPA 3.5/4.0 \
      论文: A High Read Performance LSM-Tree Key-Value Store (Based on LevelDB)

    ],
    align(right)[
      深圳 \
      2021 - 2023
    ],
  )

  #datedsubsection(
    align(left)[
      #strong[武汉理工大学] \
      软件工程  本科 \
      GPA 4.0/5.0
    ],
    align(right)[
      武汉 \
      2017 - 2021
    ],
  )
]

#let worktitle = [ Work Experience ]
#let worktitlezh = [ 工作经历 ]
#let workzh = [
  #datedsubsection(
    align(left)[
      *华为技术有限公司* \
      - 工作内容主要有：
        - Linux 调度模块的维护和异构融合调度预研（C/C++）
          - 跟进社区EEVDF调度算法，对其进行性能测试和组内培训；适配在离线混部特性到6.6内核并且解决相关的BUG，主要包括死锁，hungtask等。；了解CFS，负载均衡等
          - 实现昇腾NPU训练任务的checkpoint和restore，达成30秒内完成8卡7B训练任务恢复； 主要包括NPU状态的恢复，单机多卡P2P恢复，算子重放等；阅读修改过昇腾CANN（C++），驱动源码，了解算子下发流程，了解驱动hdc通信机制
        - 大数据开发（C++, Python, Java）
          - 流计算引擎dfx功能开发，主要包括作业管理，作业失败自动恢复等
          - 元数据服务高可用开发，实现基于zookeeper和etcd的一主多备
          - NL2SQL 中元数据提取持久化和使用LLM增强元数据持久化，schema Linking预研开发
    ],
    align(right)[
      深圳 \
      2023 - _now_
    ],
  )
]

#let techtitle = [ Technical Skills ]
#let techtitlezh = [ 技术能力 ]
#let tech = [
  - *Programming*: Rust, C/C++, Python, JAVA, Go
  - *Tools*: docker, shell, git, k8s
]
#let techzh = [
  - *编程语言*: Rust, C/C++, Python, JAVA, Go
  - *工具*: docker, shell, git, k8s
  - *擅长领域*: 操作系统（虚拟化），数据库
]

#let projecttitle = [ Project Experience ]
#let projecttitlezh = [ 项目经历 ]
#let projectexperience = [
  #datedsubsection(
    align(left)[
      *vhost-user devices in Rust on macOS and \*BSD* \
      Contributor
    ],
    align(right)[
      202x - _present_
    ],
  )

  - #lorem(32)
  - #lorem(8)

  #datedsubsection(
    align(left)[
      *#lorem(4)* \
      Maintainer
    ],
    align(right)[
      202x - _present_
    ],
  )

  - #lorem(32)
  - #lorem(8)
]
#let projectexperiencezh = [
  #datedsubsection(
    align(left)[
      *vhost-user devices in Rust on macOS and \*BSD* (GSoC 2025)\
      Contributor
    ],
    align(right)[
      2025.6 - 2025.8
    ],
  )

  - 关于Linux虚拟化的项目，适配rust-vmm中vhost-user模块能运行在macOS和\*BSD上。其中涉及使用统一的异步io库mio替换epoll，使用pipe替换eventfd等
  - 涉及技术: Linux，虚拟化，virtio，Rust
  - https://github.com/uran0sH/GSoC2025-vhost-user-bsd-macos
]

#let activitytitle = [ Activity Experience ]
#let activitytitlezh = [ 活动经历 ]
#let activity = [
  #datedsubsection(
    align(left)[
      *#lorem(8)* \
      #lorem(4)
    ],
    align(right)[
      202x
    ],
  )

  #lorem(32)

  #datedsubsection(
    align(left)[
      *#lorem(8) *\
      #lorem(4)
    ],
    align(right)[
      202x - _present_
    ],
  )

  #lorem(16)
·
  #datedsubsection(
    align(left)[
      *#lorem(8)* \
      #lorem(4)
    ],
    align(right)[
      202x
    ],
  )

  - #lorem(8)
  - #lorem(8)
]
#let activityzh = activity

#let hobbiestitle = [ Hobbies and Interests ]
#let hobbiestitlezh = [ 兴趣爱好 ]
#let hobbies = [
  #lorem(32)

  - *#lorem(4)*: #lorem(4)
  - *#lorem(4)*: #lorem(8)
]
#let hobbieszh = hobbies
