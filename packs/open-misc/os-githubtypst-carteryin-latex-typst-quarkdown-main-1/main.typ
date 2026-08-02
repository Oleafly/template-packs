#import "@preview/typslides:1.3.2": *

// Project configuration
#show: typslides.with(
  ratio: "16-9",
  theme: "bluey",
  font: "Fira Sans",
  font-size: 20pt,
  link-style: "color",
  show-progress: true,
)

// The front slide is the first slide of your presentation
#front-slide(
  title: "Pixel-Reasoner 数据格式",
  subtitle: [Using _typslides_],
  authors: "尹超",
  info: [
    #datetime.today().display() \
    #link("https://github.com/TIGER-AI-Lab/Pixel-Reasoner")
  ]
)

// Custom outline
#table-of-contents()

// Title slide for Section 1
#title-slide[
  数据输入格式与输出
]

// Slide for Section 1: Overview of Data Format
#slide(title: "数据输入输出格式概述")[
  - Pixel-Reasoner 项目主要处理三种类型的数据：
    1. **RL / Eval** 数据（parquet 格式）
    2. **SFT 数据**（消息列表 format）
    3. **最终模型输入**（chat message 格式）
  - 每种数据类型有独特的格式，要求图像/视频路径与其他字段的一致性。

]

// Slide for RL/Eval Data Input Format
#slide(title: "RL / Eval 数据输入格式")[
  - **数据格式**：parquet
  - 主要字段：
    - `question`: 题目文本
    - `answer`: 答案（通常为 `\boxed{}` 格式）
    - `image`: 图像路径
    - `is_video`: 是否为视频题目
    - `qid`: 唯一 ID


  #pagebreak()
  - 示例：
    ```json
    {
      "qid": "train-xxx-123",
      "question": "What is written on the orange box?\nchoices:\nA: ...\nB: ...",
      "answer": ["\\boxed{A}"],
      "image": ["/abs/path/to/images/0.jpg"],
      "is_video": false
    }
    ```

]

// Slide for SFT Data Input Format
#slide(title: "SFT 数据输入格式")[
  - **数据格式**：JSON 格式，包含消息列表（message_list）
  - 主要字段：
    - `message_list`: 一系列对话消息
    - `qid`: 唯一 ID
  - 每个消息包含：
    - `role`: 用户、助手、系统
    - `content`: 图像或文本内容
  #pagebreak()
  - 示例：
    ```json
    {
      "qid": "0",
      "message_list": [
        {
          "role": "system",
          "content": [
            {"text": "You are a helpful assistant...", "image": null, "video": null}
          ]
        },
        {
          "role": "user",
          "content": [
            {"text": "What is written on the orange box?\nchoices:\nA: ...", "image": null, "video": null},
            {"text": null, "image": "images/0-0.jpg", "video": null}
          ]
        },
        {
          "role": "assistant",
          "content": [
            {"text": "Step-by-step reasoning... \\boxed{A}", "image": null, "video": null}
          ]
        }
      ]
    }
    ```

]

// Slide for Final Model Input Format
#slide(title: "最终模型输入格式")[
  - **模型输入**：将数据格式化为 chat message 格式
  - 将 `question`、`image`（单图或视频帧）、`is_video` 转换为消息列表
  - 示例：
    ```json
    [
      {"role": "user", "content": [{"text": "What is written on the orange box?\nchoices:\nA: ...", "image": null, "video": null}, {"text": null, "image": "images/0-0.jpg", "video": null}]}
    ]
    ```

]

// Slide for Tool Call Output Format
#slide(title: "工具调用输出格式")[
  - **工具调用格式**：每次工具调用返回一个 JSON，格式如下：
    ```xml
    <tool_call>
    {"name":"crop_image_normalized","arguments":{"bbox_2d":[0.12,0.30,0.55,0.62],"target_image":1}}
    </tool_call>
    ```
  - 可用于裁剪图像、选取视频帧等操作。

]

// Slide for Final Answer Format
#slide(title: "最终答案格式")[
  - **最终答案**：在推理过程中返回最终答案，格式为 `\boxed{}`。
  - 示例：
    ```json
    {
      "response": "\\boxed{A}"
    }
    ```

]

// Slide for Evaluation Output Format
#slide(title: "评估输出格式")[
  - **逐样本输出**：每个样本在评估过程中会生成一个 JSONL 文件，记录评估结果。
  - 示例：
    ```json
    {"qids":"vstar-001","question":"What is written on the orange box?","response":"... 
    \\boxed{B}","match":true,"round0_correctness":0,"round1_correctness":1,
    "num_toolcalls":2}
    ```
  - **聚合指标输出**：评估汇总结果，以 JSON 格式存储。
  - 示例：
    ```json
    {"benchname":"Visual Reasoning","pass1":0.85,"ncorrect":50,"ntotal":100,"modelpath":"model_v1"}
    ```

]

// // Focus slide
// #focus-slide[
//   这一部分展示了 Pixel-Reasoner 项目的数据格式和工具调用。
// ]



// // Bibliography slide
// #let bib = bibliography("bibliography.bib")
// #bibliography-slide(bib)