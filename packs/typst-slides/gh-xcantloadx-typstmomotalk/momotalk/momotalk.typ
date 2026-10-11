// 模板
// @param title str|none 标题
// @param author str|none 作者
// @param credit bool 是否显示制作器水印
// @param width str|number 页面宽度
// @param height str|number 页面高度
// @param margin str|number|array[margin] 页面边距
// @param doc content 页面内容
#let chat(
  title: none,
  author: none,
  credit: true,
  width: 300pt,
  height: 841.89pt,
  margin: (left: 10pt, right: 10pt, top: 10pt),
  doc
) = {
  set raw(theme: "assets/vs-dark.tmTheme")
  set text(font: (
    "BlueakaBetaGBK",
    "/momotalk/assets/font.ttf",
    "Cascadia Code",
    "SimHei"
  ))
  show raw: set text(font: ("Cascadia Code", "SimHei"))
  // TODO 无法设置英文字体为 BlueakaBetaGBK
  
  page(
    width: width,
    height: height,
    margin: margin,
    [
      // 制作器水印
      #if (credit) {
        align(text(
          fill: rgb("#ccc"),
          size: 0.8em,
          "Powered by TypstMomoTalk",
        ), right)
      }
      // 标题
      #if (title != none) {
        align(text(
          fill: black,
          size: 1.3em,
          weight: "bold",
          title
        ), center)
      }
      // 作者
      #if (author != none) {
        align(text(
          fill: black,
          size: 1em,
          "——" + author
        ), right)
      }
      #doc
    ]
  )
}

#let COLOR_MSGBOX_STU_BG = rgb("#4c5b6f")
#let COLOR_MSGBOX_SENSEI_BG = rgb("#4a8ac6")
#let COLOR_MESSAGE_NAME_FG = rgb("#4b5055")
#let COLOR_SYS_FG = rgb("#e1e7ec")

#let style = (
  msgbox: (
    inset: (x: 5pt, y: 7pt),
  )
)

// 产生一条分割线
#let hr = align(line(stroke: rgb("#ccc"), length: 90%), center)


// 产生一个消息框
// @param direction 消息框方向。可选 left、right、none
// @param no_box bool 是否显示消息框背景。
#let msgbox(
  direction: "left", // left/right/none
  background_color: COLOR_MSGBOX_STU_BG,
  no_box: false,
  content
) = {
  let color = background_color
  let triangle = polygon.regular(vertices: 3, fill: color)
  triangle = scale(triangle, x: 50%, y: 50%)

  if (no_box){
    return text(content)
  }
  
  if (direction == "left") {
    triangle = rotate(triangle, 270deg)
    rect(
      radius: 5pt,
      inset: style.at("msgbox").at("inset"),
      fill: color,
      {
        text(fill: white, content)
        place(triangle, dx: -11pt, dy: -100% - 2pt)
      }
    )
  }
  else if (direction == "right") {
    triangle = rotate(triangle, 90deg)
    align(rect(
      radius: 5pt,
      inset: style.at("msgbox").at("inset"),
      fill: color,
      {
        text(fill: white, content)
        place(triangle, dx: 100% + 2pt, dy: -100% - 2pt)
      }
    ), right)
  }
  else {
    rect(
      radius: 5pt,
      inset: style.at("msgbox").at("inset"),
      fill: color,
      text(fill: white, content)
    )
  }
}

// 产生一条或多条消息
// @param name str|none 发送者名字。可空。
// @param avatar_path str|none 头像图片路径。可空
// @param direction str 消息方向。可选 left、right。
// @param contents any|arguments|array[any|arguments]
//        消息内容。可以为空，或 content/str 对象。
//        也可以是一个 arguments 对象，相当于传入给 `msgbox` 函数的参数。
#let messages(
  name,
  avatar_path,
  direction: "left",
  background_color: COLOR_MSGBOX_STU_BG,
  contents
) = {
  // 空消息检查
  if (contents == none) {
    panic("contents is empty! contents 参数不能为空！")
  }
  if (type(contents) != array) {
    contents = (contents,)
  }
  if (contents.len() <= 0) {
    panic("contents is empty! contents 参数不能为空！")
  }
  
  // 布局：一行两列的 Grid
  // 伪代码：Grid(左: 头像, 右: Stack(名字, ..内容))
  
  let rendered_contents = ()
  // 先把名字放进去
  rendered_contents.push(text(
    fill: COLOR_MESSAGE_NAME_FG,
    weight: "bold",
    name
  ))

  // 然后渲染消息框
  let render(_content, _direction) = {
    if (type(_content) == arguments) {
      msgbox(.._content)
    }
    else {
      msgbox(
        direction: _direction,
        background_color: background_color,
        _content
      )
    }
  }
  // 第一个消息框有小三角，后续的没有
  rendered_contents.push(render(contents.remove(0), direction))
  for c in contents {
    rendered_contents.push(render(c, "none"))
  }

  // 头像部分
  let avatar_content = {
      if (avatar_path != none) {
        block(
          inset: 0pt,
          outset: 0pt,
          clip: true,
          width: 40pt,
          height: 40pt,
          radius: 20pt,
          align(image(avatar_path, fit: "cover", width: 40pt), center + horizon),
        )
      }else {
        
      }
  }
  // 消息部分
  let message_content = stack(spacing: 4pt, ..rendered_contents)
  // 组装在一起
  if (direction == "left") {
    block()[
      #grid(
        rows: (auto),
        columns: (auto, 1fr),
        column-gutter: 4pt,
        avatar_content,
        message_content
      ) 
    ]
  }
  else {
    align(block()[
      #grid(
        rows: (auto),
        columns: (1fr, auto),
        column-gutter: 4pt,
        message_content,
        avatar_content,
      ) 
    ], right)
  }

}

// 产生一条系统消息
// @param width 宽度
// @param height 高度
// @param content 内容
#let system(width: 85%, height: auto, content) = [
  #align(
    rect(
      fill: COLOR_SYS_FG,
      inset: (x: 1em, y: 0.5em),
      radius: 5pt,
      height: height,
      width: width)[#content]
  ,center)
]

// ----------- 消息卡片 -----------

// 产生一个消息卡片（例如“羁绊剧情”卡片）
// @param title str 标题
// @param body none|content 卡片内容
// @param options none|content|array[content] 卡片选项
// @param title_color str 标题方块颜色
// @param background_color str 卡片背景颜色
// @param background_image str|none 卡片背景图片（WIP）
// @param option_fore_color str 选项文字颜色
// @param option_back_color str 选项背景颜色
#let card(
  title,
  body,
  options,
  title_color: rgb("#3493f9"),
  background_color: rgb("#f3f7f8"),
  background_image: none,
  option_fore_color: black,
  option_back_color: white
) = {
  // 处理 options 参数
  // bug: https://github.com/typst/typst/issues/2747
  // type(none) 输出为 none
  // 但是 type(none) == none 输出为 false
  if (options == none) {
    options = ()
  }
  else if (type(options) != array) {
    options = (options,)
  }

  let ret = rect(
    fill: background_color,
    stroke: rgb("#cdd3dc") + 0.5pt,
    inset: 1em,
    radius: 5pt,
    width: 85%
  )[
    #align(left)[
      #rect(
          height: 1.5em,
          fill: none,
          stroke: (left: title_color + 2pt, rest: none)
        )[#title]
    ]
    #place(
      dy: -1em + 2pt,
      line(length: 100%, stroke: 0.5pt + rgb("#87929e"))
    )
    #align(body, left)

    // 处理选项
    #for option in options {
      rect(
        fill: option_back_color,
        height: 2em,
        width: 100%,
        stroke: rgb("#ccc") + 0.5pt,
        radius: 4pt,
        outset: (y: 1pt, x: 0pt),
        inset: 0pt,
        align(horizon, text(option, fill: option_fore_color))
      )
      // TODO 选项框阴影（Typst 貌似目前不支持 Rect 的 Shadow）
    }
    // 无选项时要输出一个空文本占位，
    // 否则会让标题的分割线错位
    #if options.len() == 0 {
      ""
    }
    
  ]
  align(ret, center)
}

#let story_card = (name) => card(
  "好感剧情",
  none,
  "进入" + name + "的剧情",
  title_color: rgb("#fc96ab"),
  background_color: rgb("#ffedf1"),
  option_back_color: rgb("#fc96ab"),
  option_fore_color: white,
)

#let reply_card = card.with(
  "回复"
)

// ----------- 扩展消息 -----------
#let voice(seconds, color: white) = {
  // 参数检查
  if (type(seconds) != int) {
    panic("voice(seconds) 参数必须为整数！")
  }
  if (seconds <= 0) {
    panic("voice(seconds) 参数必须大于 0！")
  }
  if (color != white and color != black) {
    panic("voice(seconds, color) color 参数必须为 white 或 black！")
  }
  // TODO 改用 SVG/自定义字体，支持自定义颜色
  let img_path
  if (color == white) {
    img_path = "assets/misc/voice_white.png"
  }
  else {
    img_path = "assets/misc/voice_black.png"
  }
  let msg_width = calc.min(seconds * 3pt, 100pt)
  [
    #box(image(img_path, width: 0.7em, height: 1em), baseline: 10%)
    #h(1em)
    #text(str(seconds) + ["])
    #h(msg_width)
  ]
}

// 语音通话
// @param angle angle 图标旋转角度
// @param contents str|content 提示文本。若为空内容/空字符串，默认为“语音通话”
#let voice_call(
  angle: 0deg,
  content
) = {
  // TODO 改用 SVG/自定义字体，支持自定义颜色
  angle += 135deg
  if (content == [] or content == "") {
    content = "语音通话"
  }
  [
    #box(
      rotate(image("assets/misc/receiver.svg", width: 1em, height: 1em), angle),
      baseline: 10%)
    #content
  ]
}

#let action(
  size: 1em,
  color: COLOR_MSGBOX_STU_BG,
  content
) = {
  align(text(
    fill: color,
    size: size
    )[#content], center)
}

#let small = action.with(
  size: 0.8em,
  color: rgb("#999")
)
#let time = small
#let unsend = (name) => small[“#name”撤回了一条消息]