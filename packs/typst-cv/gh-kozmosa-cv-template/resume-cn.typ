// 简历正文 —— 中文版
//
// 编译：
//   make cn          # 同时出投递版和公开版
//   make cn-submit   # 投递版：完整信息
//   make cn-post     # 公开版：脱敏后的版本
//
// 或者直接用 typst：
//   typst compile resume-cn.typ out.pdf --input level=post --font-path fonts --font-path otfs
//
// 下面是一份示例内容，把每一项换成你自己的经历即可。版式统统由 chicv.typ 控制，
// 这里不用管字体和间距。

#import "chicv.typ": *

#show: chicv

// 姓名。公开版里替换成花名。
= #redact(alter: [your-handle])[张三]

  // 联系方式。公开版里邮箱整段消失。
  #redact(alter: [])[#fa[#envelope] you\@example.com | ]
  #fa[#github] #link("https://github.com/your-handle")[your-handle] |
  #fa[#globe] #link("https://example.com")[个人主页] |
  #fa[#location-arrow] 某省某市

  == #fa[#school] 教育背景

    #cventry(
        tl: [某某大学],
        tr: [2023.09 - 2027.06],
    )[
        - 本科，某某专业 | 排名：#redact(alter: [Top])[3/120（2.5%）]，GPA：3.8/4.0
        - CET-4 600，CET-6 550
    ]

  == #fa[#project-diagram] 项目经历

    #cventry(
        tl: [项目名 — 一句话说明它是什么],
        tr: [2025],
        bl: [你的角色 / 团队规模],
    )[
        - #link("https://github.com/your-handle/repo")[*Repo*]（技术栈）：做成了什么，用什么办法，效果如何
        - 第二条要点，尽量写成「动作 + 方法 + 可量化结果」
    ]

    #cventry(
        tl: [第二个项目],
        tr: [2024],
    )[
        - 示例要点
    ]

  == #fa[#book] 研究经历

    #cventry(
        tl: [论文标题（会议/期刊名）],
        tr: [2025],
        bl: [作者一, #underline[#redact(alter: [your-handle])[张三]], 作者三],
        br: [投稿中 / 已录用],
    )[
        - 你在其中负责的部分，以及带来的结论或提升
    ]

  == #fa[#briefcase] 实践经历

    #cventry(
        tl: [实习 / 竞赛 / 开源贡献名称],
        tr: [2025],
        bl: [角色],
        br: [奖项或成果],
    )[
        - 做了什么，结果是什么
    ]

  == #fa[#laptop.code] 专业技能

    - #emph[编程语言：]Python、TypeScript/JavaScript、C
    - #emph[工具环境：]Linux、Git、VSCode、uv、conda
    // 想换成多行列表，用 #list：
    //   #list(marker: [‣],
    //     [开发环境：Linux、Git、VSCode],
    //     [Agent：Claude Code，Spec/Subagent/Worktree 工作流],
    //   )
    - #emph[学术读写：]LaTeX、Zotero，熟悉论文体例，有排版与绘图经验
    - #emph[语言能力：]CET-4 600 / CET-6 550，能适应英文工作环境

  == #fa[#comment] 其他

    - *博客：*#link("https://example.com")[example.com]
