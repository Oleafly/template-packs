#import "../lib.typ": zju-bachelor, formula

#let bib = bibliography("refs.bib", style: "gbt-7714-2015-numeric.csl", title: none)

#show: zju-bachelor.with(
  thesis-info: (
    title-cn: "基于微服务架构的在线教育平台的设计与实现",
    title-en: "Design and Implementation of an Online Education Platform Based on Microservice Architecture",
    author: "张三",
    grade: "2022",
    student-id: "3220100001",
    school: "计算机科学与技术学院",
    major: "计算机科学与技术",
    mentor: "李四",
    mentor-title: "教授",
  ),

  // 中文摘要
  abstract-cn: [
    随着互联网技术的快速发展和教育信息化进程的不断深入，在线教育平台已成为现代教育体系的重要组成部分。然而，传统的单体架构在教育平台面临高并发、大规模用户访问时，普遍存在扩展性差、容错能力不足、开发维护困难等问题。

    本文针对上述问题，设计并实现了一套基于微服务架构的在线教育平台。该平台采用Spring Cloud Alibaba作为微服务基础设施，结合Vue.js前端框架和MySQL数据库，实现了课程管理、在线学习、作业提交与批改、在线考试、学习进度跟踪等核心功能模块。系统通过Nacos实现服务注册与发现，使用Gateway进行统一请求路由，采用Sentinel实现流量控制和熔断降级，利用RabbitMQ进行异步消息处理，有效提升了系统的可用性和扩展性。

    在系统设计阶段，本文首先对在线教育平台的业务需求进行了详细分析，采用领域驱动设计方法对系统进行了服务拆分，将平台划分为用户服务、课程服务、考试服务、作业服务和消息服务五个核心微服务。随后，基于微服务设计原则，完成了各个服务的接口定义、数据库设计和通信机制设计。在系统实现阶段，本文详细阐述了各微服务的核心业务逻辑实现，重点讨论了分布式事务处理、服务间通信优化以及统一异常处理等关键技术问题的解决方案。

    本文还对系统进行了全面的功能测试和性能测试。功能测试覆盖了所有核心业务场景，测试用例通过率达到98.5%。性能测试结果表明，在500并发用户的压力测试场景下，系统平均响应时间为326毫秒，吞吐量达到1532请求/秒，满足预期的性能指标要求。
  ],
  keywords-cn: ("在线教育", "微服务架构", "Spring Cloud", "Vue.js", "分布式系统"),

  // 英文摘要
  abstract-en: [
    With the rapid development of Internet technology and the deepening of educational informatization, online education platforms have become an important component of modern education systems. However, traditional monolithic architectures face significant challenges in education platforms under high concurrency and large-scale user access, including poor scalability, insufficient fault tolerance, and difficulties in development and maintenance.

    This thesis designs and implements an online education platform based on microservice architecture to address the aforementioned issues. The platform adopts Spring Cloud Alibaba as the microservice infrastructure, combined with the Vue.js frontend framework and MySQL database, implementing core functional modules including course management, online learning, homework submission and grading, online examinations, and learning progress tracking. The system utilizes Nacos for service registration and discovery, Gateway for unified request routing, Sentinel for flow control and circuit breaking, and RabbitMQ for asynchronous message processing, effectively improving system availability and scalability.

    During the system design phase, this thesis first conducts a detailed analysis of the business requirements of the online education platform, employs domain-driven design methodology for service decomposition, and divides the platform into five core microservices: user service, course service, examination service, homework service, and message service. Subsequently, based on microservice design principles, the interface definitions, database designs, and communication mechanisms for each service are completed. In the implementation phase, this thesis elaborates on the core business logic implementation of each microservice, focusing on solutions to key technical challenges including distributed transaction processing, inter-service communication optimization, and unified exception handling.

    Comprehensive functional and performance testing has been conducted on the system. Functional testing covers all core business scenarios with a test case pass rate of 98.5%. Performance testing results demonstrate that under a stress test scenario with 500 concurrent users, the average system response time is 326 milliseconds with a throughput of 1532 requests per second, meeting the expected performance requirements.
  ],
  keywords-en: ("Online Education", "Microservice Architecture", "Spring Cloud", "Vue.js", "Distributed Systems"),

  // 致谢
  acknowledgement: [
    时光荏苒，四年的大学生活即将画上句号。在此论文完成之际，谨向所有给予我帮助和支持的人们致以最诚挚的谢意。

    首先，我要衷心感谢我的指导教师李四教授。从选题确定、技术路线选择到论文撰写，李老师始终给予我悉心指导和无私帮助。李老师严谨的治学态度、渊博的专业知识和务实的工作作风，使我受益匪浅，也将激励我在今后的工作和学习中不断进取。

    感谢计算机科学与技术学院的各位老师，在本科四年的学习生涯中，你们的教诲为我打下了扎实的专业基础，培养了我的工程实践能力和科研素养。感谢实验室的各位同学，与你们一同学习、讨论和成长的时光是我大学生活中最宝贵的记忆。

    感谢我的父母和家人，是你们无条件的爱与支持，让我能够专注于学业，顺利完成大学阶段的求学之路。你们的鼓励永远是我前进的最大动力。

    最后，感谢在百忙之中评阅本论文和参加答辩的各位专家、教授，感谢你们提出的宝贵意见和建议。
  ],

  // 结论
  conclusion: [
    本文围绕在线教育平台面临的实际问题，设计并实现了一套基于微服务架构的在线教育平台。主要工作成果总结如下：

    第一，对在线教育平台的业务需求进行了全面分析，采用领域驱动设计方法将系统拆分为五个核心微服务，有效降低了模块间的耦合度，提高了系统的可维护性和可扩展性。

    第二，基于Spring Cloud Alibaba生态体系，完成了微服务基础设施的搭建，包括服务注册与发现、统一网关、熔断降级和消息队列等关键组件，为平台的高可用性和弹性伸缩能力提供了技术保障。

    第三，设计并实现了课程管理、在线学习、作业提交与批改、在线考试和学习进度跟踪等核心功能模块，覆盖了在线教育平台的主要业务场景。

    第四，对系统进行了全面的功能测试和性能测试。功能测试用例通过率达到98.5%，性能测试表明系统在500并发用户场景下平均响应时间为326毫秒，满足预期的性能指标。

    本系统仍存在一些不足之处，需要在后续工作中进一步完善。例如，系统目前仅支持文本形式的作业提交，未来可以扩展支持多媒体形式的作业内容；在个性化学习推荐方面，可以引入机器学习算法，根据学生的学习行为数据提供更加智能化的学习路径推荐。
  ],

  // 附录
  appendix: [
    #set heading(level: 1, numbering: none)
    #align(center)[#text(size: 16pt, weight: "bold", font: ("FangSong", "STFangsong", "SimSun"))[附录A 核心数据库表结构]]

    #v(1em)

    #text(size: 12pt, font: ("FangSong", "STFangsong", "SimSun"), weight: "bold")[表A-1 用户表（t_user）]

    #table(
      columns: (auto, auto, auto, auto),
      align: center,
      table.hline(y: 0, stroke: 1.5pt),
      table.header(
        [字段名], [数据类型], [允许为空], [说明],
      ),
      table.hline(y: 1, stroke: 0.5pt),
      [id], [BIGINT], [否], [主键ID],
      [username], [VARCHAR(50)], [否], [用户名],
      [password], [VARCHAR(255)], [否], [加密密码],
      [email], [VARCHAR(100)], [是], [电子邮箱],
      [role], [TINYINT], [否], [角色：0学生 1教师 2管理员],
      [status], [TINYINT], [否], [状态：0禁用 1启用],
      [create_time], [DATETIME], [否], [创建时间],
      [update_time], [DATETIME], [否], [更新时间],
      table.hline(stroke: 1.5pt),
    )

    #v(1em)

    #text(size: 12pt, font: ("FangSong", "STFangsong", "SimSun"), weight: "bold")[表A-2 课程表（t_course）]

    #table(
      columns: (auto, auto, auto, auto),
      align: center,
      table.hline(y: 0, stroke: 1.5pt),
      table.header(
        [字段名], [数据类型], [允许为空], [说明],
      ),
      table.hline(y: 1, stroke: 0.5pt),
      [id], [BIGINT], [否], [主键ID],
      [title], [VARCHAR(200)], [否], [课程名称],
      [description], [TEXT], [是], [课程描述],
      [teacher_id], [BIGINT], [否], [授课教师ID],
      [category_id], [BIGINT], [否], [课程分类ID],
      [cover_url], [VARCHAR(500)], [是], [封面图片URL],
      [status], [TINYINT], [否], [状态：0下架 1上架],
      [create_time], [DATETIME], [否], [创建时间],
      table.hline(stroke: 1.5pt),
    )

    #v(2em)

    #set heading(level: 1, numbering: none)
    #align(center)[#text(size: 16pt, weight: "bold", font: ("FangSong", "STFangsong", "SimSun"))[附录B 核心接口文档]]

    #v(1em)

    #text(size: 12pt, font: ("FangSong", "STFangsong", "SimSun"), weight: "bold")[B-1 用户登录接口]

    #table(
      columns: (auto, auto),
      align: (left, left),
      table.hline(y: 0, stroke: 1.5pt),
      [请求方法], [POST],
      [请求路径], [/api/user/login],
      [Content-Type], [application/json],
      table.hline(stroke: 1.5pt),
    )

    #v(0.5em)

    #text(size: 12pt, font: ("FangSong", "STFangsong", "SimSun"))[请求参数：]

    #table(
      columns: (auto, auto, auto),
      align: center,
      table.hline(y: 0, stroke: 1.5pt),
      table.header([参数名], [类型], [说明]),
      table.hline(y: 1, stroke: 0.5pt),
      [username], [String], [用户名],
      [password], [String], [加密后的密码],
      table.hline(stroke: 1.5pt),
    )

    #v(0.5em)

    #text(size: 12pt, font: ("FangSong", "STFangsong", "SimSun"))[响应示例：]

    #table(
      columns: (auto, auto),
      align: left,
      table.hline(y: 0, stroke: 1.5pt),
      [成功响应], [`{ "code": 200, "data": { "token": "xxx" } }`],
      [失败响应], [`{ "code": 401, "message": "用户名或密码错误" }`],
      table.hline(stroke: 1.5pt),
    )
  ],

  // 作者简历
  author-bio-info: (
    name: "张三",
    gender: "男",
    ethnicity: "汉族",
    birth: "2002年3月",
    hometown: "浙江省杭州市",
    education: (
      "2022年9月 — 2026年6月  浙江大学  计算机科学与技术专业  工学学士",
    ),
    awards: (
      "2024年  浙江大学优秀学生一等奖学金",
      "2024年  全国大学生计算机设计大赛二等奖",
      "2025年  浙江省优秀大学生荣誉称号",
      "2025年  国家奖学金",
    ),
    projects: (
      "2024年3月 — 2025年6月  基于微服务架构的在线教育平台  项目负责人  负责系统架构设计和后端核心模块开发",
      "2025年7月 — 2025年12月  分布式任务调度系统的设计与实现  核心开发者  负责调度算法设计与实现",
    ),
    publications: (
      "张三, 李四. 面向在线教育场景的微服务负载均衡策略研究[J]. 计算机应用研究, 2026, 43(2): 234-239.",
    ),
  ),

  bibliography: bib,
)

// ========== 正文 ==========
= 绪论

    == 研究背景与意义

    随着信息技术的飞速发展，互联网已经深入渗透到社会生活的各个领域。在教育领域，"互联网+教育"战略的深入推进使得在线教育成为传统教育模式的重要补充和创新方向。根据中国互联网络信息中心（CNNIC）发布的统计报告，截至2025年底，我国在线教育用户规模已突破4.5亿，市场规模超过5000亿元@yolov1。

    在线教育平台通过互联网技术打破了传统教育在时间和空间上的限制，使学习者可以根据自身需求灵活安排学习计划。特别是在新冠疫情期间，在线教育平台在保障教育教学连续性方面发挥了不可替代的作用，充分展示了其在现代教育体系中的重要价值。

    然而，随着用户规模的持续增长和业务场景的不断丰富，在线教育平台面临着诸多技术挑战。传统的单体架构将所有功能模块耦合在一个应用中，导致系统在应对高并发请求时扩展能力不足，单个模块的故障可能影响整个系统的可用性@fpn。此外，随着业务逻辑的日益复杂，单体应用在开发、测试和部署过程中的效率持续下降，难以满足业务快速迭代的需求。

    微服务架构作为一种新兴的软件架构范式，通过将大型应用拆分为一组小型、自治的服务，每个服务独立开发、部署和扩展，为解决单体架构面临的问题提供了有效途径@yolov9。本研究旨在将微服务架构应用于在线教育平台的设计与实现中，探索面向教育场景的微服务拆分策略和关键技术方案。

    == 国内外研究现状

    === 在线教育平台研究现状

    在线教育平台的研究与实践经历了从内容管理系统到智能化学习平台的演进过程。国际上，Coursera、edX和Udacity等大规模开放在线课程（MOOC）平台的出现标志着在线教育进入快速发展阶段@visdrone。这些平台依托云计算基础设施，为全球用户提供优质教育资源的在线访问服务。国内方面，超星学习通、中国大学MOOC、学堂在线等平台也在不断迭代升级，在用户体验和功能完备性方面取得了显著进步。

    在技术架构层面，早期的在线教育平台普遍采用LAMP（Linux+Apache+MySQL+PHP）或Java SSM（Spring+Spring MVC+MyBatis）等传统技术栈构建的单体应用@efficientdet。这些架构在平台发展初期能够满足基本的业务需求，但在用户规模和业务复杂度增长到一定程度后逐渐暴露出局限性。

    === 微服务架构研究现状

    微服务架构的概念由Lewis和Fowler于2014年正式提出，其核心思想是将应用拆分为围绕业务能力组织的、可独立部署的小型服务集合@yolov1。近年来，微服务架构在工业界得到了广泛采用，Netflix、Amazon、Uber等互联网企业成功实践了大规模微服务系统的构建与运维。

    在微服务技术生态方面，Spring Cloud、Dubbo等服务治理框架为微服务架构的落地提供了基础设施支持@yolov9。容器化技术（Docker）和容器编排平台（Kubernetes）的成熟进一步简化了微服务的部署和管理。服务网格（Service Mesh）技术的出现则提供了更加轻量级的服务间通信管理方案。

    在微服务拆分策略方面，领域驱动设计被广泛认为是指导微服务边界划分的有效方法论。通过识别业务领域中的限界上下文，可以将系统的功能需求组织为松耦合、高内聚的服务单元。此外，数据驱动、事件风暴等方法也在微服务拆分实践中得到了有效应用。

    === 现有研究的不足

    尽管微服务架构在理论和实践层面取得了丰富成果，但面向在线教育这一特定领域的微服务应用研究仍相对有限。现有研究主要存在以下不足：第一，教育领域具有独特的业务流程和数据特征，通用的微服务拆分策略难以完全适用；第二，在线教育平台对实时性、数据一致性和用户体验有较高要求，需要在微服务设计中加以特殊考虑；第三，缺乏系统性的面向教育场景的微服务架构案例研究。

    == 本文主要工作

    本文针对在线教育平台面临的实际问题，设计并实现了一套基于微服务架构的在线教育平台。主要工作包括以下几个方面：

    第一，对在线教育平台的业务需求进行深入分析，采用领域驱动设计方法完成微服务的合理拆分，确定各服务的职责边界和接口规范。

    第二，基于Spring Cloud Alibaba技术栈搭建微服务基础设施，包括服务注册与发现、API网关、熔断降级、消息驱动等关键组件的集成与配置。

    第三，设计并实现课程管理、在线学习、作业系统、在线考试和学习进度跟踪等核心业务模块，完成前后端分离的系统开发。

    第四，对系统进行全面的功能测试和性能测试，验证系统在功能和性能方面满足预期设计目标。

    == 论文结构安排

    本文共分为六章，各章内容安排如下：

    第一章为绪论，阐述本文的研究背景与意义，综述国内外研究现状，介绍本文的主要工作和论文结构安排。

    第二章为相关技术概述，介绍本系统开发所涉及的关键技术，包括Spring Cloud微服务框架、Vue.js前端框架、MySQL数据库、RabbitMQ消息队列等。

    第三章为系统需求分析与总体设计，对在线教育平台进行需求分析，提出系统的总体架构设计方案。

    第四章为系统详细设计与实现，详细阐述各微服务的数据库设计、接口设计和核心业务逻辑实现。

    第五章为系统测试，对平台进行全面的功能测试和性能测试，并对测试结果进行分析。

    第六章为总结与展望，总结本文的研究工作，指出系统存在的不足和未来改进方向。


    // ===== 第二章 相关技术概述 =====
    = 相关技术概述

    == 微服务架构基础

    微服务架构是一种将单一应用程序划分为一组小型服务的软件架构风格，每个服务运行在独立的进程中，服务间通过轻量级通信机制（通常是HTTP/REST或RPC）进行协作。与传统的单体架构相比，微服务架构具有以下显著优势：技术异构性，每个服务可以采用最适合其业务需求的技术栈；独立部署，单个服务的更新不需要重新部署整个应用；弹性扩展，可以对瓶颈服务进行针对性扩容；故障隔离，单个服务的故障不会导致整个系统崩溃@fpn。

    微服务架构的落地需要一系列基础设施组件的支持。服务注册与发现组件用于维护服务实例的动态注册信息，使服务消费者能够发现和调用服务提供者；API网关作为系统的统一入口，负责请求路由、认证鉴权、限流等横切关注点的处理；配置中心实现配置信息的集中管理和动态刷新；熔断降级机制在服务出现故障时及时隔离，防止故障的级联传播@yolov9。

    == Spring Cloud Alibaba技术栈

    Spring Cloud Alibaba是阿里巴巴开源的一套分布式应用开发组件，为Spring Cloud生态提供了完整的微服务解决方案。本系统采用的核心组件包括：

    Nacos作为服务注册中心和配置中心。Nacos支持服务健康检查、动态服务发现、配置管理等功能，采用AP模式保证高可用性。在本系统中，所有微服务实例启动时向Nacos注册自身信息，服务消费者通过Nacos获取可用服务实例列表并进行负载均衡调用。

    Sentinel作为流量控制和熔断降级组件。Sentinel提供实时的流量监控和规则管理能力，支持QPS限流、线程数限流、慢调用比例熔断、异常比例熔断等多种规则。本系统使用Sentinel对核心接口进行保护，当瞬时流量超过阈值或下游服务异常时自动触发保护机制。

    Gateway作为API网关。基于Spring WebFlux的响应式编程模型，Gateway提供了高性能的请求路由和过滤能力。本系统通过Gateway实现了统一的请求入口、跨域处理、认证鉴权和请求日志记录等功能。

    == 前端技术

    系统的前端采用Vue.js框架进行开发。Vue.js是一套用于构建用户界面的渐进式JavaScript框架，具有响应式数据绑定、组件化开发和虚拟DOM等特性。本系统使用Vue 3版本，结合Composition API进行组件逻辑组织，通过Vue Router实现前端路由管理，使用Pinia进行全局状态管理。

    在UI组件方面，系统采用Element Plus组件库，提供了丰富的表单、表格、对话框等UI组件，加速了前端界面的开发效率。通过Axios库实现与后端API的HTTP通信，并对请求和响应进行统一拦截处理。

    == 数据存储技术

    本系统采用MySQL作为主要的关系型数据库，存储用户信息、课程数据、考试记录等结构化业务数据。MySQL具有成熟稳定、性能优良、生态完善等优点，适合作为在线教育平台的数据存储方案。

    针对高并发读场景，系统引入Redis作为缓存层@efficientdet。将热门课程信息、用户会话数据等高频访问数据存储在Redis中，有效降低数据库的读压力。Redis还用于实现分布式锁，解决分布式环境下的资源竞争问题。

    对于非结构化数据（如图片、视频资源），系统使用阿里云OSS对象存储服务，通过CDN加速实现教育资源的快速分发。

    #figure(
      image("assets/placeholder.png", width: 80%),
      caption: [微服务基础设施架构示意图]
    )

    #figure(
      table(
        columns: (auto, auto, auto, auto),
        align: center,
        table.hline(y: 0, stroke: 1.5pt),
        table.header(
          [技术组件], [版本], [用途], [选型理由],
        ),
        table.hline(y: 1, stroke: 0.5pt),
        [Spring Boot], [3.2.x], [微服务基础框架], [生态成熟，社区活跃],
        [Nacos], [2.3.x], [服务注册与配置中心], [同时支持服务发现和配置管理],
        [Gateway], [4.1.x], [API网关], [响应式编程，性能优异],
        [Sentinel], [1.8.x], [流量控制与熔断], [实时监控，规则灵活],
        [RabbitMQ], [3.13.x], [消息队列], [可靠性高，路由灵活],
        [Redis], [7.2.x], [缓存与分布式锁], [性能极高，数据结构丰富],
        table.hline(stroke: 1.5pt),
      ),
      caption: [系统核心技术栈一览表]
    )


    // ===== 第三章 系统需求分析与总体设计 =====
    = 系统需求分析与总体设计

    == 功能性需求分析

    #formula(
    $"FL"(p_t) = -alpha (1 - p_t)^gamma log(p_t)$,
    $(2.3)$
    )

    通过对在线教育平台典型业务场景的分析，系统需要满足以下功能性需求：

    用户管理方面，系统需要支持学生、教师和管理员三种角色的注册、登录和信息管理功能。学生用户需要维护个人学习档案，教师用户需要管理个人教学信息，管理员需要对平台用户进行全面管理。

    课程管理方面，教师可以创建和管理课程，包括上传课程资料、发布课程公告、设置课程章节等。学生可以浏览课程目录，选择感兴趣的课程进行学习。

    在线学习方面，学生可以按照课程章节顺序进行学习，系统需要记录学习进度，支持视频播放、文档浏览等多种学习形式。

    作业管理方面，教师可以布置课后作业，设置提交截止时间和评分标准。学生可以在线提交作业，查看批改结果和教师反馈。

    在线考试方面，系统需要支持客观题（选择题、判断题）和主观题（简答题、编程题）的在线作答，并实现自动评分和人工评分相结合的评阅机制。

    == 非功能性需求分析

    性能需求方面，系统需要支持至少500名用户同时在线访问，页面响应时间不超过500毫秒，核心接口响应时间不超过300毫秒。在高并发场景下，系统需要通过弹性扩展保证服务质量。

    可用性需求方面，系统全年可用性应达到99.9%以上，关键服务应实现多实例部署，单个服务实例的故障不影响整体服务能力。

    安全性需求方面，系统需要实现用户身份认证和授权机制，防止未授权访问和数据泄露。敏感数据在传输和存储过程中需要加密保护。

    == 系统总体架构设计

    #figure(
      table(
        columns: (auto, auto, auto),
        align: (center, center, center),
        table.hline(y: 0, stroke: 1.5pt),
        table.header(
          [架构层次], [主要组件], [说明],
        ),
        table.hline(y: 1, stroke: 0.5pt),
        [表现层], [Vue.js + Element Plus], [负责用户界面展示和交互],
        [网关层], [Spring Cloud Gateway], [统一请求路由和认证鉴权],
        [业务层], [各微服务模块], [核心业务逻辑处理],
        [中间件层], [RabbitMQ + Redis], [异步消息和缓存服务],
        [数据层], [MySQL + OSS], [数据持久化和文件存储],
        table.hline(stroke: 1.5pt),
      ),
      caption: [系统技术架构层次]
    )

    系统采用分层架构设计，自上而下分为表现层、网关层、业务层、中间件层和数据层五个层次。各层次职责清晰，依赖关系明确，上层通过接口调用下层提供的服务。

    #figure(
      image("assets/placeholder.png", width: 80%),
      caption: [系统分层架构设计图]
    )

    == 微服务拆分设计

    基于领域驱动设计方法，通过对在线教育平台业务领域的分析，识别出以下核心限界上下文，每个限界上下文对应一个独立的微服务：

    用户服务负责用户注册、登录、个人信息管理和角色权限控制。课程服务负责课程的创建、发布、分类管理和课程内容组织。考试服务负责试卷生成、在线作答、自动评分和成绩管理。作业服务负责作业发布、提交、批改和反馈管理。消息服务负责系统通知、站内信和实时消息推送。

    #figure(
      table(
        columns: (auto, auto, auto),
        align: center,
        table.hline(y: 0, stroke: 1.5pt),
        table.header(
          [微服务名称], [服务端口], [核心职责],
        ),
        table.hline(y: 1, stroke: 0.5pt),
        [user-service], [8081], [用户管理与认证授权],
        [course-service], [8082], [课程管理与内容组织],
        [exam-service], [8083], [在线考试与自动评分],
        [homework-service], [8084], [作业发布与批改],
        [message-service], [8085], [消息推送与通知],
        table.hline(stroke: 1.5pt),
      ),
      caption: [微服务划分一览表]
    )

    各微服务之间通过RESTful API和消息队列两种方式进行通信。同步调用场景（如查询课程详情）使用HTTP协议，异步处理场景（如考试提交后的自动评分）通过RabbitMQ消息队列进行解耦。


    // ===== 第四章 系统详细设计与实现 =====
    = 系统详细设计与实现

    == 数据库设计

    数据库设计遵循以下原则：每个微服务拥有独立的数据库，服务间不直接访问对方数据库；数据库表设计遵循第三范式，在必要时进行适当的反范式优化；合理使用索引提升查询性能。

    #figure(
      table(
        columns: (auto, auto, auto),
        align: center,
        table.hline(y: 0, stroke: 1.5pt),
        table.header(
          [表名], [所属服务], [说明],
        ),
        table.hline(y: 1, stroke: 0.5pt),
        [t_user], [user-service], [用户基本信息表],
        [t_role], [user-service], [角色信息表],
        [t_course], [course-service], [课程基本信息表],
        [t_chapter], [course-service], [课程章节表],
        [t_exam_paper], [exam-service], [试卷信息表],
        [t_exam_question], [exam-service], [试题信息表],
        [t_homework], [homework-service], [作业信息表],
        [t_submission], [homework-service], [作业提交记录表],
        [t_notification], [message-service], [系统通知表],
        table.hline(stroke: 1.5pt),
      ),
      caption: [核心数据库表一览]
    )

    #figure(
      image("assets/placeholder.png", width: 70%),
      caption: [系统核心实体关系图（ER图）]
    )

    == 用户服务设计与实现

    用户服务是平台的基础服务，负责用户身份认证和权限管理。服务采用Spring Security + JWT实现无状态认证机制。用户登录时，服务验证用户名和密码，验证通过后生成JWT Token返回客户端。客户端在后续请求中携带Token，Gateway解析Token并将用户信息注入请求头传递给下游服务。

    密码存储采用BCrypt加密算法，避免明文存储带来的安全风险。权限模型采用RBAC（基于角色的访问控制），系统预设三种角色：学生、教师和管理员，每种角色拥有不同的操作权限。

    == 课程服务设计与实现

    课程服务是平台的核心业务服务，负责课程相关业务逻辑的处理。服务提供课程CRUD、分类检索、章节管理、资源上传等接口。课程列表查询支持多条件筛选和分页，热门课程数据缓存在Redis中以提升查询性能。

    课程内容采用章节式组织结构，每个课程包含若干章节，章节下可以包含视频、文档、测验等多种类型的学习资源。教师可以通过拖拽方式调整章节顺序，灵活组织教学内容。

    == 考试服务设计与实现

    考试服务负责在线考试的全流程管理，包括试卷生成、在线作答、自动评分和成绩统计。试卷支持随机组卷和固定试卷两种模式。随机组卷模式根据题型、难度、知识点等约束条件从题库中随机抽取试题组成试卷，保证每次考试的试卷差异性。

    对于客观题（选择题、判断题），系统在考生提交试卷后自动完成评分。设一份试卷共有 $n$ 道题目，每道题目的分值为 $s_i$，考生在第 $i$ 题的实际得分为 $g_i$，则考生总得分 $S$ 的计算公式为：

    #formula($S = sum_(i=1)^n g_i$, `（4-1）`)

    考试结束后，系统自动计算并展示考试成绩，同时生成错题分析报告，帮助学生了解自己的薄弱知识点。

    == 分布式事务处理

    在微服务架构下，跨服务的业务操作需要保证数据一致性。本系统采用Seata框架实现分布式事务管理。以考试提交场景为例，该操作涉及考试服务（更新考试记录）和消息服务（发送考试完成通知），两个操作需要保证原子性。

    #figure(
      table(
        columns: (auto, auto),
        align: (left, center),
        table.hline(y: 0, stroke: 1.5pt),
        table.header([事务模式], [适用场景]),
        table.hline(y: 1, stroke: 0.5pt),
        [AT模式], [对性能要求较高的业务操作],
        [TCC模式], [对一致性要求严格的资金类操作],
        [Saga模式], [长事务和跨多个服务的业务流程],
        table.hline(stroke: 1.5pt),
      ),
      caption: [Seata分布式事务模式对比]
    )


    // ===== 第五章 系统测试 =====
    = 系统测试

    == 测试环境

    系统测试环境采用三台云服务器搭建，每台服务器配置为4核CPU、8GB内存、100GB SSD存储，操作系统为CentOS 7.9。微服务以Docker容器形式部署，使用Docker Compose进行编排管理。

    == 功能测试

    功能测试覆盖了系统的全部核心业务模块，包括用户管理、课程管理、作业管理、在线考试和消息通知等功能。共设计测试用例245个，按照功能模块进行划分。

    #figure(
      table(
        columns: (auto, auto, auto, auto),
        align: center,
        table.hline(y: 0, stroke: 1.5pt),
        table.header(
          [测试模块], [用例数], [通过数], [通过率],
        ),
        table.hline(y: 1, stroke: 0.5pt),
        [用户管理], [42], [41], table.cell(fill: green.lighten(80%))[97.6%],
        [课程管理], [58], [57], table.cell(fill: green.lighten(80%))[98.3%],
        [作业管理], [45], [45], table.cell(fill: green.lighten(80%))[100%],
        [在线考试], [55], [54], table.cell(fill: green.lighten(80%))[98.2%],
        [消息通知], [25], [24], table.cell(fill: green.lighten(80%))[96.0%],
        [系统管理], [20], [20], table.cell(fill: green.lighten(80%))[100%],
        table.cell(fill: yellow.lighten(80%), colspan: 1)[合计], [245], [241], table.cell(fill: green.lighten(80%))[98.4%],
        table.hline(stroke: 1.5pt),
      ),
      caption: [功能测试结果统计]
    )

    测试结果显示，所有模块的测试用例通过率均超过96%，整体通过率达到98.4%。未通过的4个测试用例涉及边界条件处理和异常输入校验，已在测试后完成代码修复并通过回归验证。

    == 性能测试

    使用JMeter工具对系统进行压力测试，模拟不同并发用户量下的系统性能表现。测试场景选取用户登录、课程列表查询和试卷提交三个核心接口，并发用户数从100递增至500，每次测试持续300秒。

    #figure(
      table(
        columns: (auto, auto, auto, auto),
        align: center,
        table.hline(y: 0, stroke: 1.5pt),
        table.header(
          [并发用户数], [平均响应时间(ms)], [QPS], [错误率(%)],
        ),
        table.hline(y: 1, stroke: 0.5pt),
        [100], [156], [642], [0.00],
        [200], [198], [1011], [0.00],
        [300], [247], [1264], [0.01],
        [400], [287], [1398], [0.02],
        [500], [326], [1532], [0.05],
        table.hline(stroke: 1.5pt),
      ),
      caption: [系统性能测试结果]
    )

    性能测试结果表明，系统在500并发用户负载下仍能保持稳定运行，平均响应时间为326毫秒，满足低于500毫秒的设计目标。吞吐量随并发用户数增加而稳步提升，在500并发时达到1532请求/秒。错误率在各并发级别下均保持在0.05%以内，表明系统在高负载场景下具有良好的稳定性。

    #figure(
      image("assets/placeholder.png", width: 80%),
      caption: [系统性能测试响应时间与吞吐量趋势图]
    )
