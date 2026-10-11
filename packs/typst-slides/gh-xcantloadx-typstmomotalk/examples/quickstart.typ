#import "/momotalk/momotalk.typ": *
#import "/momotalk/characters.typ" : *
#show: doc => chat(
  title: "TypstMomoTalk 快速上手", // 标题。可选参数。
  author: "@XcantloadX", // 作者。可选参数。
  height: 1000pt, // 高度。可选参数。
  doc
)

// 以“//”开头的行是注释，不会显示到结果中。
// 提示：上面的文档开头部分暂时不用管，视为固定格式即可。

#yuuka[让我们从最简单的例子开始。]
#yuuka[请对照代码和成品来看。]
#yuuka[（提示：在右边预览里点击文字可以在左边跳转到对应的位置。）]
#hr
#yuuka[输入 `#hr` 可以产生一条分割线。]
#hr

#yuuka[发送单条消息很简单，只需输入 `#学生名称[消息内容]` 即可。]
#yuuka((
  [
    连续发送多条消息，格式为
    ```
    #学生名称(([消息1], [消息2], ..., [消息n]))
    ```
  ],
  [
    为了美观，sensei 可以在中间换行
    ```
    #学生名称((
      [消息1],
      [消息2],
      ...,
      [消息n]
    ))
    ```
  ],
  [需要注意小括号有两对，不要漏了！]
))
#yuuka(([学生名称一共有三种：罗马音、拼音、汉字，三种方式是等价的。], [现在使用的是罗马音。]))
#yegong[这是拼音。]
#梓[这是汉字。]
#yuuka[Sensei 可以按照自己的喜好选择。]

#yuuka[Sensei 的消息也是用类似的方法。\ `#sensei[内容]`]
#sensei[就像这样]
#yuuka[
  如果想要让学生在右边发送消息，稍微复杂一些：\
  `#学生名称(direction: "right")[内容]`
]
#yuuka(direction: "right")[我现在在右边。]

#hr

#yuuka[
  自定义学生步骤如下：
  + 准备一张头像，上传/复制到项目里的某个位置。
    我这里用的是 `examples/azusa.jpg`
  + 按照如下格式输入：
    ```
    #let 学生名称 = messages.with("学生名称", "图片路径")
    ```
  + 然后按照之前的方法使用即可。
]

#let azusa_s = messages.with("꒰ঌ( ᗜ`v´ᗜ )໒꒱", "/examples/azusa.jpg")
#azusa_s[就像这样]

#hr
#yuuka[下面我们来看一下文本格式。]
#yuuka((
  [
  如果需要换行，在行末输入一个 `\`， \
  就像这样。

  如果要分段，只需要单独空一行。
  ],
  [
    这是*粗体 Bold*和_斜体Italic_。由于字体不支持，所以没有效果。\
    这是#underline[下划线]。
  ],
  [
    这是#text(fill: red)[彩色文本]。 \
    `fill` 后面可以是常见的颜色单词，或 RGB 颜色。 \
    例如#text(fill: rgb("#000000"))[黑色文本]，#text(fill: rgb(0, 0, 0))[同样是黑色文本]。
  ]
))
#yuuka[
    下面是列表：
    
    - 无序列表
    - A
    - B
    
    + 有序列表
    + A
    + B
  ]
#yuuka[其他的语法请参考 Typst 文档。]

#hr
#yuuka((
  [接下来是图片，],
  [插入的图片需要提前放到项目的目录下。],
  [语法为 `#image("图片相对路径")`]
))
#yuuka[#image("/examples/azusa.jpg")]
#yuuka((
  [如你所见，默认情况下图片可能会很大。所以我们需要指定宽度。],
  [语法为 `#image("图片相对路径", width: 宽度)`。],
  [宽度的单位可以为 `pt`（绝对） 或 `%`（相对）。]
))
#yuuka((
  [例如 #image("/examples/azusa.jpg", width: 50pt)],
  [或者 #image("/examples/azusa.jpg", width: 30%)]
))
#yuuka[如果需要让图片居中或居右，使用 `#align(image("路径"), xxx)`。]
#yuuka((
  [我是填充我是填充我是填充我是填充 #align(image("/examples/azusa.jpg", width: 50pt), center)],
  [我是填充我是填充我是填充我是填充 #align(image("/examples/azusa.jpg", width: 50pt), right)]
))

#hr

#yuuka[下面介绍特殊消息。]

#story_card("【这里填角色名称】")
#reply_card(
  [回复卡描述文本。如果不需要，填 none],
  ([选项 1], [选项 2], [选项 3], [选项 N])
)
#reply_card(
  none,
  ([选项 1], [选项 2])
)
#reply_card(
  [描述文本],
  none
)

#system[系统消息。]
#system[在系统消息内插入图片的格式与上面一样。]

#yuuka[语音消息：]
#yuuka((voice(5), voice(10), voice(60)))
#sensei(voice(20))
#yuuka[语音电话：]
#yuuka((
  voice_call[],
  voice_call[通话结束 01:45],
))
#sensei(voice_call[对方已拒绝])

#yuuka[行动消息：]
#action[这是一条行动消息。]