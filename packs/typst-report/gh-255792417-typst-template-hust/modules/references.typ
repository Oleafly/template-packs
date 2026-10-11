#import "@preview/pointless-size:0.1.2": zh

// 小组件：生成单条参考文献（GB/T 7714-2015 格式）
// 参数：
//   number: 序号
//   authors: 作者（数组，最多3个作者，超过则显示"等"）
//   doc_title: 标题
//   doctype: 文献类型（"J"=期刊, "M"=专著, "C"=会议论文, "D"=学位论文, "N"=报纸, "EB/OL"=网络资源等）
//   source: 来源（期刊名、出版社等）
//   year: 年份
//   volume: 卷号（可选）
//   issue: 期号（可选）
//   pages: 页码（可选）
//   url: 网址（可选）
//   date: 访问日期（可选，用于网络资源）
#let reference-item(
  number: 1,
  authors: (),
  doc_title: "",
  doctype: "J",
  source: "",
  year: "",
  volume: none,
  issue: none,
  pages: none,
  url: none,
  date: none,
) = {
  // 处理作者：最多显示3个，超过则加"等"
  let author_text = if type(authors) == array {
    if authors.len() > 3 {
      authors.slice(0, 3).join(", ") + ", 等"
    } else {
      authors.join(", ")
    }
  } else {
    authors
  }

  // 构建参考文献条目（GB/T 7714-2015格式）
  // 格式：[序号] 作者. 标题[文献类型]. 来源, 年份, 卷(期): 页码[引用日期]. 网址

  [[#number] #author_text. #doc_title \[#doctype\]. #source, #year] // 添加卷期号
  if volume != none {
    if issue != none [, #volume\(#issue\)] else [, #volume]
  } else if issue != none [, (#issue)]

  // 添加页码
  if pages != none [: #pages]

  // 添加网址和访问日期
  if url != none {
    if date != none [[#date]. #link(url)] else [. #link(url)]
  }

  [.]
}

// 大组件：生成完整的参考文献页
// 参数：
//   refs: 二维数组，每个元素是一个字典，包含参考文献的各个字段
//   title: 参考文献页标题（默认为"参考文献"）
#let references-page(
  refs: (),
  title: "参考文献",
) = {
  pagebreak()

  // 标题样式
  align(center, text(
    font: "SimHei",
    size: zh(2),
    weight: "bold",
  )[#title])

  v(2em)

  // 设置参考文献正文样式
  set text(font: "SimSun", size: zh(-4))
  set par(leading: 1em, first-line-indent: 0em)

  // 遍历生成每条参考文献
  for (index, ref) in refs.enumerate() {
    reference-item(
      number: index + 1,
      authors: ref.at("authors", default: ()),
      doc_title: ref.at("title", default: ""),
      doctype: ref.at("doctype", default: "J"),
      source: ref.at("source", default: ""),
      year: ref.at("year", default: ""),
      volume: ref.at("volume", default: none),
      issue: ref.at("issue", default: none),
      pages: ref.at("pages", default: none),
      url: ref.at("url", default: none),
      date: ref.at("date", default: none),
    )
    parbreak()
  }
}