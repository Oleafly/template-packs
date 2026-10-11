#import "../components.typ": *

#let resume_content = [
  #section("实习经历")[
    #entry(
      title: "深度学习框架工程实习生",
      org: "某科技公司",
      date: "2025.xx - 2025.xx",
      location: "中国",
      tech: ([Python], [Shell], [Deep Learning Framework], [Operator Workflow], [LLM Agent]),
    )[
      - 参与框架团队工程效率与算子研发辅助工作，编写 Python/Shell 脚本支持数据处理、批量任务执行、日志解析和实验结果汇总。
      - 围绕算子相关场景整理代码、文档、测试样例与运行反馈，熟悉深度学习框架中算子开发、测试、调试和部署的基本流程。
      - 探索 LLM Agent 在算子研发辅助中的应用，构建面向算子理解、代码检索、错误分析和任务自动化的原型流程。
    ]
  ]

  #section("项目经历")[
    #entry(
      title: "LLM 推理框架调研与复现",
      org: "个人项目",
      date: "2026.01 - 至今",
      tech: ([vLLM], [SGLang], [Mooncake], [KTransformers], [Chitu], [KV Cache]),
    )[
      - 系统调研 vLLM、SGLang、Mooncake、KTransformers、Chitu、xLLM 等推理框架，梳理 continuous batching、PagedAttention、prefill/decode 分离、KV Cache 管理和异构推理机制。
      - 基于开源框架搭建本地 OpenAI-compatible 推理服务，记录模型加载、batch 配置、context length、显存占用、吞吐和延迟的 profiling 方法。
      - 对比本地推理、GPU serving 和 CPU-GPU 异构推理路线，沉淀面向 AI Infra 岗位的推理系统选型与优化笔记。
    ]

    #entry(
      title: "算子研发辅助 Agent 原型",
      org: "探索项目",
      date: "2025.xx - 2026.xx",
      tech: ([LLM Agent], [Code Search], [Log Analysis], [Operator Context]),
    )[
      - 将算子文档、实现代码、测试样例、错误日志和执行反馈组织为可检索上下文，探索 Agent 辅助算子理解和问题定位的工作流。
      - 设计脚本化数据处理链路，支持批量解析日志、抽取关键信息、生成结构化摘要，减少重复人工整理成本。
    ]
  ]

  #section("技能")[
    #skill_line("语言", ([C++], [Python], [Rust 基础], [Shell], [Typst]))
    #skill_line("AI Infra", ([LLM Inference], [KV Cache], [Batching], [Profiling], [OpenAI-compatible Serving]))
    #skill_line("框架", ([PyTorch], [Deep Learning Framework], [vLLM], [SGLang], [llama.cpp], [KTransformers]))
    #skill_line("系统", ([Linux], [Git], [Docker 基础], [性能分析], [自动化脚本]))
  ]

  #section("补充说明")[
    #note[
      该模板内容为可替换占位版本。投递前请将姓名、联系方式、日期、学校、公司、项目范围、可公开成果和真实指标替换为你的最终版本。
    ]
  ]
]
