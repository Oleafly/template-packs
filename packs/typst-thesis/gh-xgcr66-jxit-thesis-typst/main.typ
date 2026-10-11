// 元数据供 Word 导出器读取；query 读取内容，无需手工维护另一份正文。
#import "thesis.typ": thesis
#import "lib/layout.typ": render-thesis
#metadata(thesis) <thesis-data>
#render-thesis(thesis)
