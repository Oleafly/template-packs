#import "../styles/font-settings.typ": *

#let statement-page() = [
#set page(
  margin: (
    top: 75pt,
    bottom: 75pt,
  )
)
#set par(
  leading: 7pt,
  spacing: 1em,
)
#set text(font: global-font, size: font-size.四号, )

#let title(body) = [
  #align(center)[#text(font: font.新魏, size: font-size.二号, body)]
]
#let boxunderline(width) = box(width: width, stroke: (bottom: black), baseline: 30%)[#""]
#let checkbox(size) = box(width: size, height: size, stroke: (0.25mm + black))[#""]

#title("学位论文原创性声明")

本人郑重声明，所呈交的学位论文是本人在导师指导下进行的研究工作及取得的研究成果。尽我所知，除了论文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得中南大学或其他教育机构的学位或证书而使用过的材料。与我共同工作的同志对本研究所作的贡献均已在论文中作了明确的说明。

申请学位论文与资料若有不实之处，本人承担一切相关责任。

#v(0.95em)

学位论文作者签名：#boxunderline(3fr) #"   " 日期：#boxunderline(2fr) 年 #boxunderline(1fr)月 #boxunderline(1fr)日

#v(30pt)

#title("学位论文版权使用授权书")

本学位论文作者和指导教师完全了解中南大学有关保留、使用学位论文的规定：即学校有权保留并向国家有关部门或机构送交学位论文的复印件和电子版，允许本学位论文被查阅和借阅。本人授权中南大学可以将本学位论文的全部或部分内容编入有关数据库进行检索和公开传播，可以采用复印、缩印或其它手段保存和汇编学位论文。
#"  " 本人同意按《中国优秀博硕士学位论文全文数据库出版章程》规定享受相关权益。本人保证：毕业后以学位论文内容发表的论文作者单位注明中南大学；学位论文电子文档的内容和纸质学位论文的内容相一致。

延缓公开论文延缓到期后适用本授权书，涉密论文在解密后适用本授权书。

#v(13pt)

本学位论文属于：(请在以下相应方框内打 “ #box(baseline: 20%)[#text(size: 11pt, "√")] ”）

#v(-5pt)

#checkbox(9.5pt) 公开

#v(-4pt)
#checkbox(9.5pt) 延缓公开，延缓期限（#boxunderline(1.5fr)年#boxunderline(1fr)月#boxunderline(1fr)日至#boxunderline(1.5fr)年#boxunderline(1fr)月#boxunderline(1fr)日）

#v(14pt)
#h(-2em)学位论文作者签名：#boxunderline(1fr) #h(1fr) 指导教师签名：#boxunderline(1fr)

#v(-5.7pt)
#h(-2em)日期：#boxunderline(2fr) 年 #boxunderline(1fr)月 #boxunderline(1fr)日 #h(5fr) 日期：#boxunderline(2fr) 年 #boxunderline(1fr)月 #boxunderline(1fr)日 

#v(-5.7pt)
#h(-2em)（填写阿拉伯数字）

#pagebreak()
#pagebreak()
]