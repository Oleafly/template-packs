#import "template.typ": *

#show: body => resume(
  "你的姓名",
  contact-row((
    "电话: 你的电话",
    box[邮箱: #link("mailto:your@email.com")[your\@email.com]],
    box[GitHub: #link("https://github.com/yourname")[yourname]],
    box[个人网站: #link("https://example.com")[example.com]],
  )),
  body
)

#section-block("教育经历")[
  #entry(
    [你的学校 | 你的城市],
    subtitle: [你的专业 | 本科 / 硕士],
    date: [2023.09—2027.06]
  )
]

#v(1em)

#section-block("技术能力")[
  - *Java 基础：*熟悉 Java 核心语法、集合、多线程与常见设计模式，能够结合项目说明具体使用场景。
  - *Spring 生态：*熟悉 Spring Boot、Spring MVC、Spring Security 的常见开发模式，能够完成接口、鉴权与业务模块开发。
  - *数据库与中间件：*熟悉 MySQL、Redis、RabbitMQ 等常见组件，并能围绕索引、缓存、异步削峰等问题展开说明。
  - *工程化能力：*熟悉 Git、Docker、Linux 基本使用，能完成本地开发、调试与部署说明。
]

#v(1em)

#section-block("实习经历")[
  #entry(
    [*某科技公司*],
    subtitle: [Java 后端开发实习生],
    date: [2025.06—2025.09],
    body: [
      #project-line(
        [*示例项目名称*],
        stack: tech-stack("Spring Boot, MySQL, Redis")
      )
      - *模块开发：*负责某核心业务模块的接口设计、表结构设计与业务实现，保证功能按期交付。
      - *性能优化：*围绕慢 SQL、缓存命中率或异步处理流程做优化，提升接口响应效率与系统稳定性。
      - *工程实践：*补充日志、异常处理和可排查能力，降低问题定位成本。
    ]
  )
]

#v(1em)

#section-block("个人项目")[
  #entry(
    [*示例项目名称*],
    subtitle: [Java 后端开发],
    date: [2025.01—2025.05],
    body: [
      #tech-stack("Spring Boot, PostgreSQL, Redis, RabbitMQ")

      #v(0.3em)
      #project-desc("一句话说明项目是做什么的，解决什么问题。")

      - *权限设计：*说明如何做登录、鉴权、RBAC 或资源级访问控制。
      - *业务设计：*说明核心业务流程、数据流转和关键接口设计。
      - *稳定性优化：*说明缓存、消息队列、幂等、限流、重试或监控等实践。
      - *结果总结：*说明项目体现出的后端能力，例如性能优化、系统设计或问题排查能力。
    ]
  )
]
