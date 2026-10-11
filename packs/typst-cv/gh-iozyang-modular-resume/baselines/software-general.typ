// 本文件只安排章节和模块；事实措辞在 resume-modules/。
#import "/templates/resume-v1.typ": resume
#import "/resume-modules/header.typ": header
#import "/resume-modules/index.typ": select

#let data = (
  ..header,
  document-title: "模块化简历示例（虚构）",
  headline: "求职意向：软件开发（示例）",
  sections: (
    (title: "教育背景", entries: select(("education",))),
    (title: "实习经历", entries: select(("experience-example",))),
    (title: "项目经历", entries: select((
      "project-activity",
      "project-library",
      // "project-ledger", // 更贴合命令行或测试岗位时可替换选入。
    ))),
    (title: "校园经历", entries: select((
      "campus-open-source",
      "campus-library",
    ))),
    (title: "荣誉奖项", entries: select(("awards-core",))),
  ),
)

#resume(data)
