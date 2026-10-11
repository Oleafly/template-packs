// 简历模板核心库。
// 提供统一的主文档函数 `resume`，以及求职意向、个人总结、教育经历、工作经历、
// 项目经历、专业技能、奖项荣誉、论文专利、证书、课外活动等板块组件；
// 中英文简历共用同一套排版逻辑，通过 `lang` 参数在 "zh" / "en" 之间切换，
// 自动适配字体、标题样式（中文加粗 / 英文小型大写字母）与行距等排版细节。

// ---------- 通用工具函数 ----------

// 功能：将数组元素用分隔符连接为字符串，自动忽略其中的 none 和空字符串
// 参数：
//   items     — 待拼接的元素数组，元素可以是字符串或 content
//   delimiter — 分隔符，默认 "  |  "
// 返回：content，拼接后的结果
#let join-nonempty(items, delimiter: "  |  ") = {
  items.filter(x => x != none and x != "").join(delimiter)
}

// 功能：生成"标签：值"形式的字段展示；value 为空时连标签一并省略，
//       用于求职意向等"多个可选字段横向罗列"的场景
// 参数：label — 字段标签；value — 字段值
// 返回：content，形如"目标职位：后端开发工程师"；value 为空时返回 none
#let label-field(label, value) = if value != "" { strong(label + "：") + value }

// 功能：格式化单个日期，兼容 datetime 类型与字符串
// 参数：
//   date         — datetime 类型，或字符串（空字符串表示"至今"）
//   present-text — date 为空字符串时显示的文本，英文简历默认 "Present"，中文简历调用时可传 "至今"
// 返回：字符串，格式化后的日期文本
#let format-date(date, present-text: "Present") = {
  if type(date) == datetime {
    date.display()
  } else if type(date) == str and date.len() == 0 {
    present-text
  } else if type(date) == str {
    date
  } else {
    ""
  }
}

// 功能：生成"起始 — 结束"格式的日期区间字符串，中英文简历通用
// 参数：
//   start-date   — 起始日期，为空时只显示 end-date（用于证书颁发日期等单一日期场景）
//   end-date     — 结束日期
//   present-text — 日期为空字符串时显示的文本，参见 format-date
// 返回：content，形如 "2020 — 2024" 的日期区间；起止均为空时返回空字符串
#let dates-helper(
  start-date: "",
  end-date: "",
  present-text: "Present",
) = {
  let start = format-date(start-date, present-text: present-text)
  let end = format-date(end-date, present-text: present-text)
  if start == "" and end == "" {
    ""
  } else if start == "" {
    end
  } else {
    // 连字功能已在 resume() 中被禁用（ligatures: false），
    // 因此不能直接书写 "---"，需用 em dash 符号手动拼接
    start + " " + sym.dash.em + " " + end
  }
}

// ---------- 主文档函数 ----------

// 功能：简历主文档函数，通过 `#show: resume.with(...)` 调用，负责设置全局排版（字体、页边距、标题样式、链接样式），并渲染姓名、联系方式与可选的证件照
// 参数：
//   author                  — 姓名
//   author-position         — 姓名的对齐方式，可选 left / center / right
//   personal-info-position  — 联系信息的对齐方式，可选 left / center / right
//   pronouns                — 代词（如 she/her），可选
//   age                     — 年龄，中文简历常用；留空则不显示，显示内容由调用方
//                             自行拼接（如传入 "28 岁"）
//   phone / email / location / github / linkedin / personal-site — 常用联系方式字段，留空则不显示
//   extra-contacts          — 额外联系方式，传入 content 数组，用于放置以上字段未覆盖的信息，
//                             例如自定义显示文本的邮箱链接：link("mailto:xxx")[显示文本]
//   photo                   — 证件照路径，中文简历常用；留空(none)则不显示、保持单栏布局；
//                             提供后以悬浮定位显示在右上角（顶部与姓名对齐），联系信息自动改为
//                             竖排以填满头部区域，不会强行把正文往下挤出大片空白
//   photo-width             — 证件照宽度，高度按原图比例自动缩放
//   accent-color            — 强调色，十六进制颜色字符串，用于标题与链接
//   font                    — 显式指定字体；留空(none)时按 lang 自动选择合适字体
//   paper                   — 纸张规格，遵循 Typst page 元素的 paper 取值（如 "us-letter"、"a4"）
//   margin                  — 页边距，建议 0.5in；中文排版如需更紧凑可在调用处覆盖
//   author-font-size        — 姓名字号
//   font-size               — 正文字号
//   lang                    — 语言，"en" 或 "zh"，决定字体、标题样式与行距等细节
//   body                    — 简历正文
// 返回：无（通过 show 规则设置文档样式并输出内容）
#let resume(
  author: "",
  author-position: left,
  personal-info-position: left,
  pronouns: "",
  phone: "",
  email: "",
  location: "",
  age: "",
  github: "",
  linkedin: "",
  personal-site: "",
  extra-contacts: (),
  photo: none,
  photo-width: 2.8cm,
  accent-color: "#000000",
  font: none,
  paper: "us-letter",
  margin: 0.5in,
  author-font-size: 20pt,
  font-size: 12pt,
  lang: "en",
  body,
) = {

  // 根据语言自动选择字体，可被 font 参数显式覆盖
  let resolved-font = if font != none {
    font
  } else if lang == "zh" {
    // 默认中文字体：思源黑体的 Google 开源版本，跨平台可用性最好
    // 可选方案：("SimSun", "Times New Roman")   Windows 原生宋体，适合金融/法律/政府等
    //          ("Songti SC", "Times New Roman") macOS 原生宋体，适合金融/法律/政府等
    //          "Noto Serif CJK SC"
    "Noto Sans SC"
  } else {
    // 默认英文字体：无衬线、跨平台可用性好
    // 可选方案："New Computer Modern"   Computer Modern 的现代 OpenType 扩展版，学术风格更浓
    //          "Times New Roman"       适合金融/法律/政府等
    //          "Noto Serif CJK SC"
    "Arial"
  }

  // 文档元数据
  set document(author: author, title: author)

  set text(
    font: resolved-font,
    size: font-size,
    lang: lang,
    // 禁用连字，防止 ATS（简历筛选系统）解析字体时出现混淆
    ligatures: false,
  )

  set page(
    margin: margin,
    paper: paper,
  )

  // 链接样式：下划线 + 强调色
  show link: underline
  show link: set text(fill: rgb(accent-color))

  // 二级标题：英文用小型大写字母，中文用加粗（中文没有大小写概念，
  // smallcaps 对 CJK 字符无效果甚至可能出现异常），下方统一加分割线
  show heading.where(level: 2): it => [
    // top: 0pt, bottom: -10pt：向上贴合标题、向下收紧与分割线的间距
    #pad(top: 0pt, bottom: -10pt, [
      #if lang == "zh" [#strong(it.body)] else [#smallcaps(it.body)]
    ])
    #line(length: 100%, stroke: 1pt)
  ]

  // 标题统一使用强调色
  show heading: set text(fill: rgb(accent-color))

  // 一级标题（姓名）：位置可配置、加粗、字号较大
  show heading.where(level: 1): it => [
    #set align(author-position)
    // weight: 700 对应 Typst 的 "bold" 字重
    #set text(weight: 700, size: author-font-size)
    #pad(it.body)
  ]

  // 联系信息辅助函数：value 为空则不显示；link-type 非空则生成对应协议的链接
  let contact-item(value, prefix: "", link-type: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#(prefix + value)]
      } else {
        value
      }
    }
  }

  // 姓名 + 联系信息，合并为一个整体，供无照片 / 有照片两种头部布局共用
  // 收集全部联系信息条目，并过滤掉未填写的字段
  let contact-items = (
    contact-item(pronouns),
    contact-item(phone),
    contact-item(email),
    contact-item(location),
    contact-item(age),
    contact-item(github, link-type: "https://"),
    contact-item(linkedin, link-type: "https://"),
    contact-item(personal-site, link-type: "https://"),
    ..extra-contacts,
  ).filter(x => x != none and x != "")

  let header = {
    // 一级标题：显示姓名
    [= #(author)]

    // 个人联系信息：预设字段 + extra-contacts 自由字段
    // 无证件照时保持横向单行、竖线分隔（与不支持照片时完全一致）；
    // 有证件照时改为竖排，让联系信息纵向撑开头部区域，与照片高度更接近，减少空白
    pad(
      top: 0.25em,
      align(personal-info-position)[
        #if photo != none {
          stack(dir: ttb, spacing: 0.75em, ..contact-items)
        } else {
          contact-items.join("  |  ")
        }
      ],
    )
  }

  // 提供 photo 时，证件照以浮动定位悬浮在右上角（顶部与姓名对齐），不占用正常
  // 文档流的高度——header 之后的正文不会被强行下移来"让位"给照片；如果头部信息
  // 比照片矮，后续正文可能会与照片底部区域重叠，可在正文开头自行用 v(...) 预留间距
  // 不提供 photo（默认 none）则保持单栏布局，渲染效果与不支持照片时完全一致
  if photo != none {
    place(top + right, image(photo, width: photo-width))
    block(width: 100% - photo-width - 1em, header)
  } else {
    header
  }

  // 正文：两端对齐；中文适当增大行距以提升可读性
  set par(
    justify: true,
    leading: if lang == "zh" { 0.75em } else { 0.65em },
  )

  body
}

// 功能：章节标题辅助函数，等价于 `== 标题`，供偏好函数式调用风格的用户使用
// 参数：title — 标题内容
// 返回：content，二级标题
// 例：#resume-section[工作经历]  等价于  == 工作经历
#let resume-section(title) = heading(level: 2, title)

// ---------- 通用布局组件 ----------

// 功能：简历通用二行二列布局，常用于"标题+日期"一行、"副标题+地点"一行的条目
// 参数：top-left / top-right / bottom-left / bottom-right — 四个位置的展示内容
// 返回：content
#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

// 功能：简历通用一行两列布局，左侧内容与右侧内容两端对齐
// 参数：left / right — 左右两侧的展示内容
// 返回：content
#let generic-one-by-two(
  left: "",
  right: "",
) = {
  [
    #left #h(1fr) #right
  ]
}

// ---------- 板块组件 ----------
// 以下条目类组件（edu / work / project / award / publication / certificate /
// extracurricular）均支持可选的尾随 body：
//   - 不传 body：只渲染表头，要点另起 markdown 列表书写
//   - 传入 body（用 [...] 语法）：表头与要点合并为一次调用

// 功能：渲染板块组件的可选正文（如要点列表）；仅当调用时传入了 body 才输出，
//       用于避免在每个板块组件末尾重复书写同样的判断逻辑
// 参数：body — 可选的正文内容，未传入时为 none
// 返回：content 或 none
#let append-body(body) = if body != none { body }

// 功能：生成外部链接的展示形式，统一以 "url" 文本显示并跳转到 "https://url"，
//       用于 project / publication / certificate 等组件中链接字段的复用逻辑
// 参数：url — 不含协议前缀的链接地址，如 "github.com/foo"
// 返回：content，可点击的链接文本
#let external-link(url) = link("https://" + url)[#url]

// 功能：求职意向板块组件（中文简历常用），以"标签：值"的形式横向罗列意向信息，自动忽略未填写的字段
// 参数：
//   position  — 目标职位
//   city      — 意向城市
//   type      — 工作类型（全职 / 实习 / 兼职 / 远程等）
//   salary    — 期望薪资
//   available — 到岗时间
//   body      — 可选的补充说明
// 返回：content
#let objective(
  position: "",
  city: "",
  type: "",
  salary: "",
  available: "",
  body: none,
) = {
  join-nonempty((
    label-field("目标职位", position),
    label-field("意向城市", city),
    label-field("工作类型", type), 
    label-field("期望薪资", salary),
    label-field("到岗时间", available),
  ))
  append-body(body)
}

// 功能：个人总结板块组件；不附带任何头部字段，仅作为语义标记渲染一段说明文字，便于与其他"标题+要点"形式的板块组件保持统一的调用风格
// 参数：body — 个人总结正文内容
// 返回：content
#let summary(body) = body

// 功能：教育经历板块组件
// 参数：
//   institution — 学校名称
//   dates       — 起止日期字符串，配合 dates-helper() 生成
//   degree      — 学位与专业
//   gpa         — GPA，留空则不在 degree 后面拼接显示
//   location    — 学校所在地
//   consistent  — 为 true 时日期显示在右上角、地点在右下角，与 work/project 等组件的
//                 布局顺序保持一致；默认 false，即地点在右上角、日期在右下角（教育经历的
//                 传统排版习惯）
//   body        — 可选的正文内容（如要点列表）
// 返回：content
#let edu(
  institution: "",
  dates: "",
  degree: "",
  gpa: "",
  location: "",
  consistent: false,
  body: none,
) = {
  // 若提供 GPA，拼接到 degree 后面一并显示
  let degree-line = if gpa != "" {
    degree + "  |  GPA: " + gpa
  } else {
    degree
  }

  if consistent {
    generic-two-by-two(
      top-left: strong(institution),
      top-right: dates,
      bottom-left: emph(degree-line),
      bottom-right: emph(location),
    )
  } else {
    generic-two-by-two(
      top-left: strong(institution),
      top-right: location,
      bottom-left: emph(degree-line),
      bottom-right: emph(dates),
    )
  }
  append-body(body)
}

// 功能：工作经历板块组件
// 参数：
//   title    — 职位名称
//   dates    — 起止日期字符串
//   company  — 公司/组织名称
//   location — 工作地点
//   body     — 可选的正文内容（如要点列表）
// 返回：content
#let work(
  title: "",
  dates: "",
  company: "",
  location: "",
  body: none,
) = {
  generic-two-by-two(
    top-left: strong(title),
    top-right: dates,
    bottom-left: company,
    bottom-right: emph(location),
  )
  append-body(body)
}

// 功能：项目经历板块组件
// 参数：
//   role  — 担任角色，留空则不显示角色前缀
//   name  — 项目名称
//   url   — 项目链接，不含协议前缀，留空则不显示
//   dates — 起止日期字符串，留空且提供了 url 时，链接会显示在日期本应出现的位置
//   body  — 可选的正文内容（如要点列表）
// 返回：content
#let project(
  role: "",
  name: "",
  url: "",
  dates: "",
  body: none,
) = {
  generic-one-by-two(
    left: {
      // 仅当日期与链接同时存在时，才在标题行内额外附上链接
      let link-note = if url != "" and dates != "" [ (#external-link(url))]
      if role == "" {
        [*#name* #link-note]
      } else {
        [*#role*, #name #link-note]
      }
    },
    right: if dates == "" and url != "" { external-link(url) } else { dates },
  )
  append-body(body)
}

// 功能：专业技能板块组件，一次性渲染多个技能分类，每个分类显示为一行
//       "**分类名**：技能1, 技能2, ..."，视觉效果与手写 markdown 列表一致
// 参数：
//   categories — 数组，每个元素为字典 (label: "分类名", items: (技能...) 或 "已拼接字符串")
//   body       — 可选的补充内容（如额外的自由格式说明），追加在分类列表之后
// 返回：content
#let skills(categories: (), body: none) = {
  list(..categories.map(cat => {
    let items-text = if type(cat.items) == array {
      cat.items.join(", ")
    } else {
      cat.items
    }
    // 半角冒号 + 空格：与手写 markdown 技能条目的既有写法保持一致，中英文均适用；
    // 注意冒号本身不加粗，只有分类标签加粗
    [#strong(cat.label): #items-text]
  }))
  append-body(body)
}

// 功能：奖项与荣誉板块组件
// 参数：
//   name   — 奖项名称
//   issuer — 颁发机构/主办方，可选
//   rank   — 奖项等级或名次，如"一等奖"，可选
//   date   — 获奖日期
//   body   — 可选的补充说明
// 返回：content
#let award(
  name: "",
  issuer: "",
  rank: "",
  date: "",
  body: none,
) = {
  [
    *#name*
    #if issuer != "" [, #issuer]
    #if rank != "" [ (#rank)]
    #h(1fr) #date
  ]
  append-body(body)
}

// 功能：论文 / 专利板块组件
// 参数：
//   title   — 论文标题或专利名称
//   venue   — 发表期刊/会议名称，或专利授权机构/专利号
//   authors — 作者列表，可选；建议将本人姓名加粗后传入，以便与合作者区分
//   url     — 论文/专利链接，不含协议前缀，可选
//   date    — 发表/授权日期
//   body    — 可选的补充说明
// 返回：content
#let publication(
  title: "",
  venue: "",
  authors: "",
  url: "",
  date: "",
  body: none,
) = {
  generic-two-by-two(
    top-left: strong(title),
    top-right: date,
    bottom-left: emph([#venue #if url != "" [ (#external-link(url))]]),
    bottom-right: emph(authors),
  )
  append-body(body)
}

// 功能：证书板块组件
// 参数：
//   name   — 证书名称
//   issuer — 颁发机构
//   url    — 证书验证链接，不含协议前缀，留空则不显示
//   date   — 颁发日期
//   body   — 可选的正文内容
// 返回：content
#let certificate(
  name: "",
  issuer: "",
  url: "",
  date: "",
  body: none,
) = {
  [
    *#name*, #issuer
    #if url != "" [ (#external-link(url))]
    #h(1fr) #date
  ]
  append-body(body)
}

// 功能：课外活动板块组件
// 参数：
//   activity — 活动名称
//   dates    — 起止日期字符串
//   body     — 可选的正文内容
// 返回：content
#let extracurricular(
  activity: "",
  dates: "",
  body: none,
) = {
  generic-one-by-two(
    left: strong(activity),
    right: dates,
  )
  append-body(body)
}
