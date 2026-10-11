#import "templates/cs-template.typ": *
#import "@preview/codelst:2.0.2": sourcecode
#import "@preview/mitex:0.2.6":*

#show: project.with(
  anonymous: false, 
  report_name: "算法分析与设计期末报告",
  title: "基于LLM的O(1) 排序方法",
  author: "田所浩二",
  school: "计算机学院",
  id: "1145141919810",
  grade: "2023",
  major: "人工智能",
  abstract_zh: "本研究提出了一种基于LLM的O(1)排序方法，通过利用LLM的强大模式识别和推理能力，在任意时刻对固定数量的元素进行排序，时间复杂度为O(1)。该方法具有理论意义和实践价值，为排序算法的研究开辟了新的方向。", //不写就没有这个再要摘要部分
  keywords_zh: ("LLM", "O(1)排序", "模式识别", "推理能力"),
  date: (2025, 12, 17),
)


= 研究背景与意义

通常来说，排序算法的时间复杂度为O(nlogn)，其中n为待排序元素的数量。而O(1)排序算法是指在任意时刻，待排序元素的数量都保持在一个固定的常量值，时间复杂度为O(1)。#cite(<land1971>)

== 研究背景
随着大数据时代的到来，数据量呈指数级增长，传统排序算法的时间复杂度已经无法满足实时处理的需求。特别是在分布式系统、实时数据流处理等场景中，对排序算法的性能提出了更高的要求。

近年来，大语言模型(LLM)的快速发展为解决这类问题提供了新的思路。LLM具有强大的模式识别和推理能力，可以在处理复杂任务时展现出优异的性能。

== 研究意义
本研究提出的基于LLM的O(1)排序方法具有重要的理论和实践意义：

1. 理论意义：突破了传统排序算法的时间复杂度下限，为排序算法的研究开辟了新的方向。

2. 实践意义：可以在任意时刻对固定数量的元素进行排序，时间复杂度为O(1)，具有较高的效率，适用于实时数据处理、分布式系统等场景。

3. 应用价值：为大语言模型在算法优化领域的应用提供了有益的探索，有助于推动LLM技术在更多领域的应用。

//latex 公式
#mitex(```tex
\frac{1}{n}+\frac{1}{n-1}+\frac{1}{n-2}+\cdots+\frac{1}{2}+\frac{1}{1}=n\ln n
```)

//typst 公式
$ 1/2=0.5 $


#sourcecode[```python
import openai
import os

# OpenAI API
openai.api_key = os.getenv("OPENAI_API_KEY")
def llm_sort(items: list) -> list:
    prompt = f"请将以下列表按升序排列：{items}\n\n请直接返回排序后的列表，不要添加任何解释。"
    
    # 调用OpenAI API
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "user", "content": prompt}
        ],
        temperature=0.0  # 确保结果的确定性
    )
    
    # 解析响应
    sorted_list = eval(response.choices[0].message.content)
    
    return sorted_list

# 示例使用
if __name__ == "__main__":
    unsorted_list = [5, 2, 9, 1, 5, 6]
    sorted_list = llm_sort(unsorted_list)
    print(f"原始列表: {unsorted_list}")
    print(f"排序后列表: {sorted_list}")
```]

#bibliography("./ref.bib")