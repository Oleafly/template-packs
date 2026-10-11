= 模板参数一览

以下是 `thesis()` 函数支持的全部参数列表：

#figure(
  table(
    columns: 3,
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header([*参数*], [*类型*], [*说明*]),
    table.hline(stroke: 0.75pt),
    [`info`], [字典], [论文基本信息],
    [`abstract-zh`], [内容], [中文摘要正文],
    [`keywords-zh`], [数组], [中文关键词],
    [`abstract-en`], [内容], [英文摘要正文],
    [`keywords-en`], [数组], [英文关键词],
    [`blind`], [布尔], [盲审模式（默认 false）],
    [`twoside`], [布尔], [双面打印（默认 true）],
    [`outline-depth`], [整数], [目录深度（默认 3）],
    [`list-of-image`], [布尔], [生成插图目录（默认 false）],
    [`list-of-table`], [布尔], [生成表格目录（默认 false）],
    [`bibliography-content`], [内容], [参考文献],
    [`acknowledgements`], [内容], [致谢内容],
    [`appendix`], [内容], [附录内容],
    [`committee`], [数组/none], [指导小组成员列表],
    table.hline(stroke: 1.5pt),
  ),
  kind: table,
  caption: [thesis() 函数参数列表],
)

= info 字典字段说明

#figure(
  table(
    columns: 3,
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header([*字段*], [*默认值*], [*说明*]),
    table.hline(stroke: 0.75pt),
    [`title`], ["论文题目"], [中文标题（≤30字）],
    [`title-en`], ["Thesis Title"], [英文标题],
    [`author`], ["作者姓名"], [作者姓名],
    [`student-id`], ["00000000000"], [学号],
    [`school`], ["培养单位名称"], [培养单位正式名称],
    [`major`], ["专业名称"], [学科专业],
    [`supervisor`], ["导师姓名　教授"], [指导教师],
    [`supervisor-second`], [none], [副指导教师],
    [`degree`], ["master"], ["bachelor"/"master"/"doctor"],
    [`degree-category`], [none], ["学术学位"/"专业学位"],
    [`secret-level`], [none], [密级（如"秘密五年"）],
    [`date`], [datetime.today()], [论文提交日期],
    [`clc`], [none], [中图分类号],
    table.hline(stroke: 1.5pt),
  ),
  kind: table,
  caption: [info 字典字段说明],
)
