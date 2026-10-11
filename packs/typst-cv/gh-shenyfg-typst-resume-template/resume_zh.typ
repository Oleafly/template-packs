// 个人信息
#let personal = (
  name: "张三",
  title: "高级AI工程师",
  contact: "📍 上海 　 📞 138-0000-0000 　 ✉️ zhangsan@gmail.com 　 👤 男 　 📅 1994.06",
)

// 配置信息
#let config = (
  title-suffix: "简历",
  fonts: ("PingFang SC", "Arial"),
  education_titles: ("教育背景",),
  work_titles: ("工作经历",),
)

// 简历章节数据
#let sections = (
  (
    title: "个人简介",
    content: [
      ai工程师，4年大型互联网公司 + 1年AI创业公司经验，非常的牛逼。
    ],
  ),
  (
    title: "教育背景",
    content: (
      ("2015 - 2018", "上海交通大学", "软件工程", "硕士"),
      ("2011 - 2015", "同济大学", "计算机科学", "本科"),
    ),
  ),
  (
    title: "工作经历",
    content: (
      (
        "2025.03 – 至今",
        "高级AI工程师",
        "幻境科技（上海）有限公司",
        (
          (
            "2025.11 – 至今",
            "多智能体协作平台 HiveMind",
            "核心开发",
            [
              面向企业级自动化场景的多 Agent 协作平台，支持异构 Agent 动态组网、跨任务状态共享与自适应任务分裂，日均处理任务量超 *50 万次*。

              - *技术栈*：
                Python 3.12，FastAPI，LangGraph，gRPC，Kafka，PostgreSQL，Kubernetes

              - *核心贡献*：
                - 动态组网：设计基于能力标签的 Agent 发现与路由协议，支持百级 Agent 实例按需组合，任务分配延迟 *< 20ms*。
                - 状态共享：基于 Kafka + PostgreSQL 实现跨 Agent 事件溯源，支持任意节点故障后从最近检查点无损恢复。
                - 自适应分裂：实现 LLM 驱动的任务复杂度评估器，自动将超长任务拆解为并行子任务，端到端耗时降低 *40%*。
                - 可观测性：集成 OpenTelemetry 全链路追踪，构建 Agent 调用拓扑实时视图，MTTR 从 25 分钟降至 *6 分钟*。
            ],
          ),
          (
            "2025.07 – 2025.11",
            "智能客服知识库增强系统",
            "RAG / 后端开发",
            [
              为电商平台构建的企业级 RAG 知识库系统，支持多源异构文档实时入库，将客服机器人首次答复准确率从 *61%* 提升至 *89%*。

              - *技术栈*：
                Python，FastAPI，Qdrant，BGE-M3，OpenAI API，Celery，Redis，Docker

              - *主要工作*：
                - 混合检索：实现稠密向量 + BM25 稀疏检索融合策略（RRF Rerank），Top-3 召回率提升 *18 个百分点*。
                - 增量入库：基于 Celery 构建异步文档处理流水线，支持 PDF / Markdown / HTML 自动解析与分块，入库吞吐 *800 doc/min*。
                - 上下文压缩：引入 LLM 摘要节点对长上下文进行动态截断，在保留关键信息的前提下将 token 消耗降低 *35%*。
                - 幻觉治理：设计基于置信度阈值的回退策略，检索得分低于阈值时自动转人工，幻觉投诉率下降 *72%*。
            ],
          ),
          (
            "2025.03 – 2025.07",
            "LLM 推理网关 InferProxy",
            "基础设施开发",
            [
              - 设计统一 LLM 访问网关，支持 OpenAI / Gemini / Claude / 本地 vLLM 多后端路由，实现按模型成本、延迟与 token 配额的动态负载均衡。
              - 实现请求级 Prompt 缓存（语义哈希），重复请求命中率 *43%*，月均 API 费用节省约 *12 万元*。
              - 基于令牌桶算法实现细粒度限流，配合熔断策略保障上游稳定性，网关 P99 延迟 *< 8ms*。
            ],
          ),
        ),
      ),
      (
        "2020.07 – 2025.02",
        "后端工程师 / 平台工程师",
        "某头部金融科技公司",
        (
          (
            "2023.08 – 2025.02",
            "实时风控决策引擎",
            "核心开发",
            [
              支撑千万级日活的实时交易风控系统，负责规则引擎重构与特征平台建设，将单笔决策 P99 延迟从 *380ms* 压缩至 *45ms*。

              - *技术栈*：
                Python，Go，Flink，Redis Cluster，Kafka，Druid，Kubernetes

              - *主要工作*：
                - 规则引擎重构：将硬编码规则迁移至 DSL 配置化体系，规则上线周期从 *3天* 缩短至 *30分钟*，支持灰度发布与一键回滚。
                - 实时特征平台：基于 Flink 构建流批一体特征计算链路，支持 200+ 特征实时更新，特征新鲜度 *< 500ms*。
                - 缓存分层：设计 L1（进程内）/ L2（Redis）两级特征缓存，热点特征命中率 *99.2%*，减少 DB 查询 *60%*。
                - 压测与容量规划：主导全链路压测方案设计，发现并修复 3 处竞态条件，系统峰值吞吐提升至 *8 万 TPS*。
            ],
          ),
          (
            "2022.03 – 2023.08",
            "数据资产治理平台",
            "后端 / 数据开发",
            [
              - *技术栈*：
                Python，Airflow，dbt，Spark，Hive，PostgreSQL，Elasticsearch

              - *主要工作*：
                - 主导数据血缘解析模块开发，自动追踪 SQL / Python 任务的字段级依赖，覆盖 *3000+* 数据表。
                - 构建元数据搜索服务（基于 Elasticsearch），支持按标签、负责人、敏感等级多维过滤，查询响应 *< 200ms*。
                - 推动数据分级分类标准落地，完成 PII 字段自动识别与脱敏改造，通过监管合规审计。
                - 设计调度依赖可视化大盘，帮助数仓团队将关键链路任务 SLA 达成率从 *91%* 提升至 *99.3%*。
            ],
          ),
          (
            "2020.07 – 2022.03",
            "支付清结算核心系统",
            "后端开发",
            [
              参与日均清算金额超百亿的核心支付系统迭代，负责对账模块重构与资金差异自动核销功能开发。

              - *技术栈*：
                Java，Spring Boot，MyBatis，RocketMQ，MySQL，ShardingSphere

              - *主要工作*：
                - 对账重构：将批量文件对账改造为流式处理，对账耗时从 *4 小时* 降至 *22 分钟*，差异识别准确率 *100%*。
                - 自动核销：设计基于规则引擎的差异核销策略，将人工介入率从 *12%* 降至 *1.3%*。
                - 高可用改造：引入幂等 token 机制消除重复扣款，灰度验证期间零资金损失事故。
                - 遵循严格的安全扫描、Code Review 与单元测试（覆盖率 *> 85%*）要求，连续 8 个季度零 P1 事故。
            ],
          ),
        ),
      ),
    ),
  ),
  (
    title: "技能总结",
    content: [
      - *编程语言*：Python，Go，Java，Shell
      - *后端框架*：FastAPI，Spring Boot，gRPC，asyncio
      - *AI / Agent*：LangGraph，RAG，Prompt Engineering，OpenAI API，Gemini API，Claude API，vLLM，MCP Tool Calling
      - *数据库*：PostgreSQL，MySQL，Redis Cluster，Qdrant，Elasticsearch
      - *消息队列 / 流处理*：Kafka，Flink，RocketMQ，Celery
      - *云原生*：Docker，Kubernetes，OpenTelemetry，Prometheus
      - *代码质量*：Code Review，安全扫描，pytest / unittest（覆盖率 > 85%）
      - *开发流程*：Agile / Scrum，灰度发布，全链路压测
    ],
  ),
  (
    title: "英语",
    content: [
      - IELTS 雅思 *7.5* ：可胜任英文环境下的沟通与协作
    ],
  ),
)

#import "resume_template.typ": render_resume
#render_resume(personal, sections, config)
