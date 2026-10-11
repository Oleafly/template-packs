#import "@preview/pointless-size:0.1.2": zh
#import "modules/cover.typ": cover-page
#import "modules/outline.typ": outline_with_sizes
#import "modules/references.typ": references-page

// 配置文件：封面、目录、参考文献等设置

// 封面配置
#let cover_config = (
  title: [文档标题],
  course: [课程名称],
  class: [班级名称],
  student-id: [学号],
  name: [作者姓名],
  teacher: [指导老师],
  report-date: [报告完成日期],
  college: [学院名称],
)

// 目录配置
#let outline_config = (
  depth: 3,
  font_sizes: (12pt, 12pt, 12pt),
)

// 参考文献配置
#let references_config = (
  refs: (
    (
      authors: ("张三", "李四", "王五"),
      title: "深度学习在图像识别中的应用研究",
      doctype: "J",
      source: "计算机学报",
      year: "2020",
      volume: "43",
      issue: "6",
      pages: "1001-1015",
    ),
    (
      authors: ("赵六",),
      title: "人工智能导论",
      doctype: "M",
      source: "清华大学出版社",
      year: "2019",
    ),
    (
      authors: ("孙七", "周八", "吴九", "郑十"),
      title: "大数据技术综述",
      doctype: "J",
      source: "软件学报",
      year: "2021",
      volume: "32",
      issue: "3",
      pages: "567-589",
    ),
    (
      authors: ("李明",),
      title: "机器学习基础教程",
      doctype: "EB/OL",
      source: "在线教育平台",
      year: "2022",
      url: "https://example.com/ml-tutorial",
      date: "2023-05-15",
    ),
  ),
  title: "参考文献",
)

// 应用封面
#let apply_cover() = {
  cover-page(..cover_config)
}

// 应用目录
#let apply_outline() = {
  outline_with_sizes(..outline_config)
}

// 应用参考文献
#let apply_references() = {
  references-page(..references_config)
}
