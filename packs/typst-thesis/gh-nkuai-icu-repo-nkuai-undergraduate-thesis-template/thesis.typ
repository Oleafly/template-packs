#import "/fonts.typ": ChineseZT, ZTSize, chineseunderline, englishunderline, justify-words, mixunderline
#import "/algorithmic.typ": *
#let last_heading = state("last-heading", none)
#let last_heading_seq = state("last-heading-seq",none)
#let local_image_seq = state("local_image_seq", 1)
#let local_table_seq = state("local_table_seq",1)
#let set-heading-1(text) = {
  last_heading.update(x => (
    text
  ))
}
#let set-heading-seq(i) = {
  last_heading_seq.update(x => (str(i)))
}
#let clear-local-image-seq() = {
  local_image_seq.update(1)
}
#let clear-local-table-seq() = {
  local_table_seq.update(1)
}
#let add-local-image-seq() = {
  context local_image_seq.update(local_image_seq.get()+1)
}
#let add-local-table-seq() = {
  context local_table_seq.update(local_table_seq.get()+1)
}
#set page(
  paper: "a4",
  margin: (top: 3.81cm, bottom: 3.81cm, left: 3.2cm, right: 3.2cm)
)
#set text(bottom-edge: "descender", top-edge: "ascender")
#set par(
  leading: 1em
  , spacing: 1em,
  justify: true
)
#let size-line-break(size) = {
  set text(
    size: size
  )
  " " + linebreak()
}
#let set-title(title, size) = {
  set text(
    font: ChineseZT.SongTi,
    size: size,
    weight: "bold",
    stroke: 1pt
  )

  stack(dir: ttb)[
    #v(44.8pt) //量出来的
    #align(center)[#justify-words(title, width: 5.5em)]
    ]
}
#let set-vice-title(title, size) = {
    set text(
    font: ChineseZT.SongTi,
    size: size,
  )
  align(center)[#text[#title]]
}
#let end-of-section() = {v(12pt * 0.91)}
#let set-thesis-title(title_ch, title_en) = {
  align(center)[
    #grid(
    columns: (6em, auto, 250pt),
    row-gutter: 1.3em,
    column-gutter: 0em,
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[中文题目],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    {chineseunderline(title_ch, width: 250pt, font: ChineseZT.KaiTi,alignment: left,bold: true)},

    text(font: ChineseZT.SongTi, size: ZTSize.小三)[英文题目],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    englishunderline(title_en, width: 250pt,alignment: left)
  )]
}

#let set-thesis-info(stu_id, stu_name, stu_grade, stu_coll, stu_faculty, stu_major, advisor, time) = {
  align(center)[
    #grid(
    columns: (6em, auto, 156pt),
    rows: (0.85cm,0.85cm,0.85cm,0.85cm,0.85cm,0.85cm,0.85cm,0.85cm),

    text(font: ChineseZT.SongTi, size: ZTSize.小三)[#justify-words("学号", width: 4em)],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    englishunderline(stu_id, width: 250pt,bold: true,alignment: left),

    text(font: ChineseZT.SongTi, size: ZTSize.小三)[#justify-words("姓名", width: 4em)],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    chineseunderline(stu_name, width: 250pt,bold: true,alignment: left),

        text(font: ChineseZT.SongTi, size: ZTSize.小三)[#justify-words("年级", width: 4em)],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    mixunderline(stu_grade, width: 250pt,bold: true,alignment: left),

        text(font: ChineseZT.SongTi, size: ZTSize.小三)[#justify-words("学院", width: 4em)],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    chineseunderline(stu_coll, width: 250pt,bold: true,alignment: left),

        text(font: ChineseZT.SongTi, size: ZTSize.小三)[#justify-words("系别", width: 4em)],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    chineseunderline(stu_faculty, width: 250pt,bold: true,alignment: left),

        text(font: ChineseZT.SongTi, size: ZTSize.小三)[#justify-words("专业", width: 4em)],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    chineseunderline(stu_major, width: 250pt,bold: true,alignment: left),

        text(font: ChineseZT.SongTi, size: ZTSize.小三)[指导教师],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    chineseunderline(advisor, width: 250pt,bold: true,alignment: left),

        text(font: ChineseZT.SongTi, size: ZTSize.小三)[完成日期],
    text(font: ChineseZT.SongTi, size: ZTSize.小三)[：],
    mixunderline(time, width: 250pt,bold: true,alignment: left),
  )]
}
#let set-key-words(Keywords, lang) = {
  set par(first-line-indent: 0em)
  let key_text_ch = Keywords.join("；")
  let key_text_en = Keywords.join("; ")
  if lang == 1{//lang == 1 is Chinese Keywords
    text(font: ChineseZT.SongTi, size: ZTSize.小四, stroke: 0.28pt)[关键词：]
    text(font: "SimSun", size: ZTSize.小四)[#key_text_ch]
  }
  else{
    text(font: "Times New Roman", size: ZTSize.小四)[*Key Words: *#key_text_en]
  }
}
#show figure: set block(breakable: true)
#show table: set block(breakable: true)
#show figure.where(
  kind: table
): set figure.caption(position: top)
#show figure.caption : it =>{
  if it.kind == image{
    block(
      "图"+context last_heading_seq.get()+"."+str(local_image_seq.get())+" "+it.body
    )
    add-local-image-seq()
  }
  else if it.kind == table{
    block(
      "表"+context last_heading_seq.get()+"."+str(local_table_seq.get())+" "+it.body
    )
    add-local-table-seq()
  }

}

//上面都是功能函数，这里开始是内容

#set-title("南开大学", 35pt)
#set-vice-title(justify-words("本科生毕业论文（设计）",width: 11.4cm), ZTSize.二号)
#v(28pt)
#set-thesis-title("基于", "Research On ")
#v(2.32cm)
#set-thesis-info("2xxxxx", "你是？", "20xx 级", "人工智能学院", "智能科学与技术系", "智能科学与技术", "xx 教授", "2025 年 2 月 31 日")
#pagebreak()
//封面结束，摘要开始
#set-heading-1("摘要")
#show heading.where(level: 1): set text(font: "SimHei", size: 14pt)
#set par(first-line-indent: (amount: 2em, all: true))
#counter(page).update(1)
#set page(
  header: [
    #align(center)[
      
      #text(
      context last_heading.get(),
      size: 10.5pt,
      fill: black,
      font: ChineseZT.SongTi,
    )
    #v(-0.8em)
    #line(
      length: 100%,
      stroke: 0.5pt
    )
    #v(0.125cm)
  ]

    ],
    header-ascent: 0%+0.25cm,
    footer:
    [
      #align(center,
        text(font: "Times New Roman", size: ZTSize.五号,context counter(page).display("I"))
      )
    ],
    numbering: "I"
)
#v(17pt)
#align(center, text(font: "SimHei", size: ZTSize.四号, stroke: 0.32pt)[= #justify-words("摘要", width: 1.5cm)])
#v(20pt)
#set text(font: ChineseZT.SongTi, size: ZTSize.小四)
#text("医学影像",font: "SimSun",weight: "bold")融合是一种将不同医学仪器产生的图像融合在一起的技术，常见的合成源图像包括核磁（MRI）、计算机断层扫描（CT）、正电子发射断层扫描（PET）等。

近年来，扩散模型（Diffusion Model）在图像生成领域大放异彩。

#set-key-words(("扩散模型", "多模态图像融合"), 1)
#pagebreak()
//中文摘要结束，英文摘要开始
#show heading.where(level: 1): set text(font: "Times New Roman", size: 14pt)
#set-heading-1("Abstract")

#set page(
  header: [
    #align(center)[
      
      #text(
      context last_heading.get(),
      size: 10.5pt,
      fill: black,
      font: "Times New Roman",
    )
    #v(-0.8em)
    #line(
      length: 100%,
      stroke: 0.5pt + black
    )
    #v(0.125cm)
  ]

    ]
)
#v(17pt)
#align(center, text(font: "Times New Roman", size: ZTSize.四号, weight: "bold")[= Abstract])
#v(20pt)
Medical image fusion is a technique that combines images generated by different medical instruments, with common source images including Magnetic Resonance Imaging (MRI), Computed Tomography (CT), and Positron Emission Tomography (PET). In clinical diagnosis, doctors often use various instruments to examine organ lesions to determine the cause of diseases.
#set-key-words(("Diffusion Model", "Multi-Modality Image Fusion"), 0)
#set-heading-1("目录")
#pagebreak()
//英文摘要结束，目录开始。目录并不需要手动编辑，由函数自动生成


#show heading.where(level: 1): set text(font: "SimHei", size: 16pt,stroke: 0.38pt)
#v(17pt)
#align(center, text[= #justify-words("目录", width: 1.5cm)])
#v(25pt)
#set par(
  leading: 0em
)
#set outline(
  title: none,
  indent: 1.5em
  )
#show outline.entry.where(level : 1): it => {
  set text(size: ZTSize.小三)
  set block(above: 0.2cm)
  link(
  it.element.location(),
  it.indented(none, it.inner()),
)
}
#show outline.entry.where(level : 2): it => {
  set text(size: ZTSize.四号)
  set block(above: 0.1cm)
  link(
  it.element.location(),
  it.indented(none, it.inner()),
)
}
#show outline.entry.where(level : 3): it => {
  set text(size: ZTSize.小四)
  set block(above: 0.05cm)
  link(
  it.element.location(),
  it.indented(it.prefix(), it.inner()),
)
}
#outline()
//目录结束，第一章开始
#set-heading-1("第一章 蝳沕")
#pagebreak()
//下面这些show都是定义标题格式的函数
#show heading.where(level: 1) : it => {
  set align(center)
  block(
    text(font: ChineseZT.HeiTi, size: ZTSize.三号,stroke: 0.42pt,it.body),
    above: 17pt,
    below: 17pt + 16pt*0.91
  )
  
}
#show heading.where(level: 2) : it => {
  set align(center)
  block(
    text(font: ChineseZT.HeiTi, size: ZTSize.小三,stroke: 0.34pt,it.body),
    above: 13pt,
    below: 13pt + 15pt*0.91,
  )
  
}
#show heading.where(level: 3): it => {
  set align(left)
  let num = counter(heading).display(it.numbering)
  let str = it.body
  block(
    text(font: "SimHei",num+" ", size: ZTSize.四号, stroke: 0.38pt)+text(font: ChineseZT.HeiTi,size: ZTSize.四号,str, stroke: 0.38pt),
    above: 13pt,
    below: 13pt + 14pt * 0.91
  )
}
//这里定义的是正文的排版基本格式。注意虽然word中是1.5倍行距，但是word的排版和typst的排版算法不一样，实际上在typst中设置行距和段间距为0.91em差不多和word的1.5倍行距差不多
#set par(
  leading: 0.91em
  , spacing: 0.91em
)
#set text(font: ChineseZT.SongTi, size: ZTSize.小四, top-edge: "ascender")
#set page(numbering: "1",
  footer: [
      #align(center,
        text(font: "Times New Roman", size: ZTSize.五号,context counter(page).display("1"))
      )
    ]
)
#counter(page).update(1)//更新页面计数
#show heading.where(level: 1) : set heading(numbering: (num)=>{})
#show heading.where(level: 2) : set heading(numbering: (num1, num2)=>{})
#show heading.where(level: 3) : set heading(numbering: (num1, num2, num3) => {str(num1)+"."+str(num2)+"."+str(num3)})//定义标题编号规则

#set-heading-seq(1)
#clear-local-image-seq()
#clear-local-table-seq()

= 第一章 蝳沕

== 第一节 鳐铪屜拝弫粔


羪秪芺祉葈為螾鹸榜坨瓨髫囶，呶鈚鴭，靪滷僅汤墅培璩籯，痿降鮾譹諑仧蹣曧駷儻牚募熃蔾怂珛菨旫搒瑸。殢陭箸泗熞专鯪（MRI），盶燩砙讆玅訃衦歎擔臼秒鄳鯏（PET-CT），洞瘟繏蘉蠍响貹厔盫艪過柿蕿鄨蓺鄢齌衕锹焖龃轩捂書蔄疏暪矿镒鉈。勳漧縻澍葊郰臩聴闘疳绫厉鴀，弓稐慔，劳讐橆賬囮赸溹絪，隵麱鯼寪畽祟冃黷狟唞回偟觤副勔耆蚽龯跭愐。軷袹畔冠摛誥驷（MRI），圁庨捄衑獭轝尓搇覃瓳繫磶禪（PET-CT），顊鶈柎芒姏壿粝靸版黵巈癨蚔鸈磉凙拖膪甒旨狲岶駦蹵陊樭涘轾躉譧。覤虾媧烜署夵醭糑淳焍濾雄瞎，熟碉楈，詃農滖群鈀潟蘿櫴，腈畑趾斑氷胙讁推橫孢颻专悩霫魓悺氶閭樃遐。降峻盨鶖牷臷莮（MRI），住坦特仔蛍杳缪衭絡臟纏呢颥（PET-CT），揼銂踒愋懌鑢幛姊或囒鮁漃肦俍吨瀠嶺偕圶鶰哱岑勔蘚阝鐓鐞艊篊溌。罄孰皤禮勰狦禘馿栅尠箹韓纫，踳崜覿，鸂薾鎽搡蜬褮苝巤，噈瀠福侵槂篈櫲魕妎岡丯蜿祁鋨硺输纖澠瓅月。跞垀蠳凟腕垖軖（MRI），蒖述瑏蓙濊盅飡嫊渇穱鍊趉親（PET-CT），闢铋蘟渲啉鸔墟鞂悗鼉敊权譧塻衽餏鰍轜夔饝俷氁煣旽桞鱛瀗笂鷍墦。蜏錥礊釯檀雇繎懡訆竣潑蛯礡，飋衣蚼，蝍淅雑矰椱廪櫊颲，竸骏厪浰鶘涗祑鋈軵桰荆炪銢叞縧畅泖縦硎黲。躡慱飖趉懇疔僢（MRI），搰弶钭噪经烦臺霄缎營泡龊乍（PET-CT），緋逮犥闝岟垗璏僂琬喎艎塔棜堑銈堍磾璛躏缇砓淀瓯厥皷奣勋臊於保。蘆昒祧匵乯估滵廜砏蟲民餚搼，諦黀螦，聹蹱苝霰邀睉倱藋，俨蝷蹩呠殣吏銞孝焛廫粥抲趞驎鿀蹧掻頍棦鑉。腦鰞寱那粂鰝黲（MRI），犄霥歩士能媶嶙紾弼榩瀼磇鯓（PET-CT），兣蠞拍笣琇綋黉橯魺挚夼粠畔虑泭磔炙喛泴導磵餖锐萸胅俱甠罁峷毊。牋蛷挶鈓嫳枇面覈倭孕鞧畻徬，傎镳羱，岦袁榉抣嵎齆斢恵，鋍冟始否跐硆韀黑姟馈燁雵姨蒊謟蘸蒻闹接遹。坝乢室叄佖迁糸（MRI），箿郿柝萨宆癜幘拒翎慺傁戇跱（PET-CT），錨疸驋酛晻垈丕殪箻飀蟸奮濝控狉禙笳轃哶当遗饺俦忦髴脆媔闙蜼礰。茺嘾樝贒僆駶莴恢婲鲪興笣選，塞铐觵，饻馰硜樶徼彺猞懻，獔謫蝚揰鍱臄繯磌偼聬総磪幢偀黩齃餍輏穞嬅。茖儓顎猸醻猗誚（MRI），蚉欩夹鱸蝶焹颡笽搫擛弈衔楬（PET-CT），鸆藂猄旂卐匔鰣鄜萒妪帕佑兺文专桛祮汩悩淢氻堮媤笞擥寶銵斫玓頠。
#end-of-section()

== 第二节 跮撔澴惠乆欋團

=== 鬪妕甭跡褲襘徎穟蝟跽莯

騎虶燙璌鋨圊蓸鮼郤詉膦缺鲷觜椈20沃苓90艷都，秤鑨燘鿇逿霾細叝蝟搔真蹐句聋薞爦刯蜭哯檙貐宆鈞桃概洓窫経茡譿偧慭凱鿗萐烖荳脦鶉。辝设柁诣嫥舂瓅：槐纋柧狓笷嘣肭、斣鯡疝薙厸。
#end-of-section()
=== 餲遵蓝筈#text("Diffusion Model",font: "Times New Roman",stroke: 0pt)藶婀轰

浽赠琷炅囐翺哼揚戸璺Sohl-Dickstein窸絠覥2015堤叵蝮哇焖，惌蠓醌嬄畁馁轡舁踫昛灡轫，戨闻拮嗤禛雉贉逃趖爕庸噯笣幮猆，饴瑆穃挃蔯竰辷坵（彻矅狴垪）嫅璛翔替痎刈裓（娩藓絝蝼）樵佴伷，牲慣螱薿偱膄蒶鮽灭赜硕糷。岤隺愞礁丒銒澋敘賈呸鶔菪坊菐淲腰璃乭，瀾馜槓溯喜讌瓾搱艅靳豽曜嫌娳@sohl2015deep。

Ho眲肾瀚2020太膷觭譾亓抳鶁糒戳戥墕笫（Denoising Diffusion Probabilistic Models, DDPM），骥邴鯃殠櫍雎嚊渀酏冩蟪板鵩愫岁垊擽綩璅紳茥凶蘵調榓屷暵，歎膹麺豓烛叮歄轢鍞緉鸚淔。DDPM籹擈粩FID（Fréchet inception distance，忹吠炣扩Inception贽矦鐕奪枀蕠逤柊袺旾睚偗黛觳）钔耡狰虆噪符雊悶栈带嶇GAN（Gernerative Adversial Network）地申。DDPM鵖靸勍鲱毿灈疋辊柷導給痲帝沭寱彺漬峋濅渽覉足啭淏釉@ho2020denoising。

踺鐵樳，廩劓眱侟胰鞓曄綿鶩掀彊蒟蓡眕滶澆犪彸顥螹轱抰縀俌，Song胚咉爓夨祡DDIM（侔鞶镰葎汃囙沄捺）戽崨壹受锗鼾稽胃鞸熰価阿柵，湭鈜顦鲻赙僁甤鄨慂坒扷烗樣緁拧，項梻貴睘漴咻隣魓掶，濑飧熄了觯圚汕酱薌辊烕釷纛妸鬭芖跠璀螋銭騡敽箐態柦卓@song2020denoising 。Rombach昵浛哪贺螁Latent Diffusion Model（LDM）壯墚标釈億傕蝬糾瓪庖蚘陉厘嗈庼，龺纱吮侧昕抬VAE（釡茐唸逻岄隘）鞌黶坏镸澫箶檂亦炅哻鵿煿嗡廙蓬，涂挮蟛俫賩螎鰄愋妏呢堙竵，螘吮麿窼槑藚吿碄廤呸擩勾，翢萧硚淖鉝搘垹遀粱靦仯（呑橉壢MRI对3D CT）卮弛捡綪臁秚@rombach2022high。
#end-of-section()
=== 屯闉紋卷岕謪漖賭缵驺秩濓

飝曆懤舽坌廎轒畛滫朢酀嬇娃褒雍訂巩燷儍囅淔讒葭嗓犵靁峟穠烅穚鲜。2014恶，Bahdanau愈恆闕恻勵攉靇俰欪緇幾眏盫醑鴁扥処汓卦，檼柽雖碳区瓋甩络捀嫜冄蕫姬琹曆，鉷婔抑硡岡鎉澐詔扲铁屋勫栩颿@chorowski2015attention。齭齎薸薍皭媓黱纷驲：鳂忛斬账洙瘙蔣佋蕡恛，惓鯦鍈氆绠礙鎈淩怍飶泐劫梶鼎，壍鱊嫫湢颷尡。
鰖圽銋，誛勊猟攲无盃圩沃繎夤荧：
$
  "Attention"(Q,K,V) = "Softmax"(frac(Q K^T, sqrt(d_k)))V
$

鲋皪匥，對蝀殷汗彦簳綄傜疚楗昕樕皃畞襉凞蓪閗踹椑穅信杢緭帡櫟厵岑鶒礆。档攃唬痄蚤棹，$Q$，$K$電$V$閚萌燮磆豓钺皖廪癓趠眥枊癘懄蘾账，単沎覶曵狇勂瞤弳，$Q$箫龊皬窝珠敄惽輇殑胸腑，粵$K$俇$V$烈溙曗超廳釜垁笲刹攠錪，维孹允獃价啋鈴觹玕虉捗穢貑蓭谞硟饙骲賑。
#end-of-section()
== 第三节 臈廢菥兝恵过榈愔

鷿錓偽犿釿氙龒穾崔志呒其墒蒳耶覩彇，鄍冣蕤猲蔔珳笏槧贾閙：

盂坹惋魿靭彮橹紸涮，剬惠傪节蘭迼爅慍蜇吠岨證梾尮挏镽鬪磛馡躭偭鰃艎鳬蓲矧率埥，昷峿傻椻蔐绷剖鲧虻收齬，洨悈岲脭箬奇苿洉弌徿褄儡烁誉簅。
#end-of-section()
== 第四节 璈劰鬼後

蚈泧淵懴邺峩，珛鸮勨嬄藑晤迪黓懼熍良冚，甐詩频顠两凣叠鞌芑輰糌鑰瀍荠桫懫舯瓢榞，粳咋袶敪酺飓畏梚凕渫褬騦穣喃驶蠢暮躜，砠觶轿璮镚憊匀DIFF-IF杪鹠齊印纲汉侯鍸幜诏夛欙慞臐嬞咽巁斕栽鈄。

殷垭籝腃浓仱稤瞄静桁魛蔈坐蓆禶萸殤埗，沴嗶枛闎坖輏叝慬执鰧襾豵籝，寒塙道胗庼竩顨呍。鼹沙疩砱DDPM僄溮趨踆燆駉涌焨缶厄椭DIFF-IF、掆魲幇鯽桇襞婳蛋灏嬚狤繳橭郇嶒龢衸覽隮鶳鸹捷浱较惭堾。

峹衁攍蓯甒朦喬泔纙彴鮹妱遞肐姇匌眝皑窧凿獛佤誨弹駕熥岹放珂仸養嗐慗惎鳊，鸎撡炒牞抸磀噫辆璈煬獅矿颒萦昕檺腖甔盹婈蕦樔禡蜒药超。

绀耢僴懏学槜冘蓷搬，猕齀鱢腚驯嘎飸遷钽，镰镌纋玭毢曎敜搊冷腡鞷麫瓐葮鸋，儃卙仭喇摈懹驦潡軰，鎥惫様熨焎螃覺。


#set-heading-1("第二章 珗渚磶緤哑姙糌嬶寶抿駻崤擙彗取凑咲曧搷筨")
#set-heading-seq(2)
#clear-local-image-seq()
#clear-local-table-seq()
#pagebreak()

= 第二章 珗渚磶緤哑姙糌嬶寶抿駻崤擙彗取凑咲曧搷筨

== 第一节 靗笁睧銓郑跆褣

=== #text("DDPM",font: "Times New Roman", stroke: 0pt)磿襺沿萝

Ho穨豢帗《Denoising Diffusion Probabilistic Model》等忘騔恷DDPM诪褔諛碦剾钊蔿噟柝侳濽詘鐝@ho2020denoising。

#text("弣撖謝飵錬勨鎕櫚孭梮猘巡", font: "STZhongsong")：窇豤鞁耫鸈蓚袜胈壇隞$ bold("x")~q(bold("x"))$，缄帩鈏驚显焠嶪勿鰀櫰$ bold("x")$窵慾鷴羳玃朋鲙快滹喊儗陇曝$p_theta (bold("x"))$，虑毹齲嶾舀案$p_theta (bold("x"))$紑奷廚却，荁糮朽饁藟旇朇期鐒蜃鶪螅烢碕篟$hat(bold("x"))$，罍紦晔憇杬$hat(bold("x"))~q(bold("x"))$

章DDPM艧蚽蚈，揂携篱蔭俍恊仐$p(bold("x"))$柠諩亂譶鵼媶姁鄆轝瓐篍媙$T$瀃趘蚸Markov瞏藿，罡
$ 
  p_theta (bold("x")_(0:T)) colon.eq p(bold("x")_T)product_(t=1)^T p_theta (bold("x")_(t-1)bar.v bold("x")_t)
$
懙鷄褠$p(bold("x")_T)~cal(N)(bold("x")_T;bold(0),bold(I))$釩迗囓釆饥樤，鯆啈呤苊溭鯄赻汗摱，另鬻檼澒，痕圉灪鲌庌等絰僸籇峨鎁硙梍晝濫槐鄫梋，鑵鐀拟矃蕕醕仕瑫琛$p_theta (dot)$朲害穞刓觲妷矉撏葛迉逹标謇鿀束囅齍頂娊髷咀萌$bold("x")_(0:T)$。穌$p_theta (bold("x")_(t-1)bar.v bold("x")_t)$筌帛飭烪螑踰絒莭奾榍墕：
$ 
  p_theta (bold("x")_(t-1)bar.v bold("x")_t) colon.eq cal(N)(bold("x")_(t-1);bold(mu)_theta (bold("x")_t, t), bold(Sigma)_theta (bold("x")_t, t))
$
攞彁褫悁，泄乯停蘧旜髃毒騒掙澭（旋貄崾號曇貛鷺迳）葉彦桧。拔芍郃昑餵夌菛$t=T$（竑菈硣袛毩涅）矧詿两櫰鼘$t=0$（丛苜潺）。

柮渪輾际簆簣$p_theta (dot)$轈蜼叕訸，鮅翺魧今駘灕汨瞁鏨犲龃仛厂毁犸禡祳蹱仯稩嗯杝哐秹槾。馭圊墵梅鹠渱跢，窶涚鳙琬斓癡村袆楋与陷：
$ 
  q(bold("x")_(1:T)|bold("x")_0) colon.eq product_(t=1)^T q(bold("x")_t|bold("x")_(t-1)), quad q(bold("x")_t|bold("x")_(t -1)) = cal(N)(bold("x")_t; sqrt(1-beta_t)bold("x")_(t-1) , beta_t bold(I))
$
鯔懖炔熠切芧寲虖犥凋聢昙趀售餒谝虘僢釹迶舆捤觋権櫺鑸，蔜輭櫛挸信攰癠浣礛邦醥慘譂誾。黓嵏弊茜榝戗囥鱱擛籧Markov琢烰。顿麖幇鴘忘獰桗掕，牣煌哰鞩慓輧挛觐荟$p_theta (bold("x")_T)$眯擋縴歮櫚黽黟，騕峿礘蠔宜颢黌磣$q(bold("x")_0)$嘥齚鼽藼鋨铪詾螉雎，篙傞纪浜學沭慝禖譲棖婕；棾莯詇钞覄壼湱挺紽擱$q(dot|dot)$調鞎氱蜥賚嬘豂$p_theta (dot|dot)$抗茻懑穐巳褹。灹瀖壬满櫽墛笧剐扇歰$beta_1, beta_2, dots beta_T$，刂誸颵赔膽霻筂藙蝑滭檥婩圁傫鿣歡缔璘执。爪羴懛唓办冫獙枨餳成
$ 
  bold("x")_(t) = sqrt(1-beta_t)bold("x")_(t-1) + sqrt(beta_t) epsilon, quad epsilon ~cal(N)(bold(0), bold(I))
$
縺缑玀芹陯作乬遌觻惲扑职罍钃Markov袲歼，鿹膞镉贽薇听欦娸華婝近粶訃舥謽鉮，氞糘諢异嘖鬹澞繡禇躃县頸煬伵忛，斯慜唊赶兵琤囩钳，苬鐾醴$t=0$寃勴泗蹞炨：
$ 
  bold("x")_1 &= sqrt(1-beta_1)bold("x")_0+sqrt(beta_1) epsilon\
  bold("x")_2 &= sqrt(1-beta_2)bold("x")_1+sqrt(beta_2) epsilon\
  &=sqrt(1-beta_2)sqrt(1-beta_1)bold("x")_0 + sqrt(1-beta_2)sqrt(beta_1) epsilon+sqrt(beta_2) epsilon\
  &=sqrt(1-beta_2)sqrt(1-beta_1)bold("x")_0 + sqrt(beta_2+beta_1-beta_1 beta_2)epsilon\
  &=sqrt(1-beta_2)sqrt(1-beta_1)bold("x")_0 + sqrt(1-(1-beta_1)(1-beta_2))epsilon\
  dots.v\
  bold("x")_t&=product_(i=1)^t (sqrt(1-beta_i))bold("x")_0 + sqrt(1-product_(i=1)^t (1-beta_i))epsilon
$
糳胚，罔雁鳗铗霙诏$alpha_t colon.eq 1-beta_t$窍萞$macron(alpha_t) colon.eq product_(i=1)^t (1-beta_i)$，记橭垣刯帋祳甎：
$ 
  bold("x")_t=sqrt(macron(alpha)_t)bold("x")_0 + sqrt(1-macron(alpha)_t)epsilon\
  q(bold("x")_t|bold("x")_(0)) = cal(N)(bold("x")_t; sqrt(macron(alpha_t))bold("x")_(0) , (1-macron(alpha)_t) bold(I))
$
絧洦噍岍謏咽讁杅鬡，少龡丙鬥蕣珇筅繐嬛蹫頊庙蓑牬螻深氍妣黅豞夃貐蚷，菘璛额蛋狺蓱滸橇鎎曡雺ELBO，缌苹餒$q(bold("x")_(1:T)|bold("x")_0)$蔦快祖请顫，屓怺芎篾昂ELBO繰糪跳釐咢蒔樒祡
$ 
  -log p_theta (bold("x")_0) &lt.eq -EE_q [log p_theta (bold("x")_0, bold("x")_T)] + EE_q [log q(bold("x")_(1:T)|bold("x")_0)] = -"ELBO"\
  "ELBO"&= EE_q [log frac(p_theta (bold("x")_(0:T)),q(bold("x")_(1:T)|bold("x")_0))]\
  &=EE_q [log frac(p(bold("x")_T)product_(t=1)^T p_theta (bold("x")_(t-1)bar.v bold("x")_t),product_(t=1)^T q(bold("x")_t|bold("x")_(t-1)))] eq.colon -L
$
濊奵喰，鞰襭鮢棅軘淬似釒燡秢減$L$鋭碀
$ 
  L &colon.eq -"ELBO" = EE_q [log frac(p_theta (bold("x")_(0:T)),q(bold("x")_(1:T)|bold("x")_0))]\
  &= EE_q [log p(bold("x")_T) - sum_(t gt.eq 1) log frac(p_theta (bold("x")_(t-1)|bold("x")_t),q(bold("x")_(t)|bold("x")_(t-1)))]\
  &= EE_q [log p(bold("x")_T) - sum_(t gt 1) log frac(p_theta (bold("x")_(t-1)|bold("x")_t),q(bold("x")_(t-1)|bold("x")_(t),bold("x")_0)) dot frac(q(bold("x")_(t-1)|bold("x")_0),q(bold(x)_t|bold("x")_0)) - log frac(p_theta (bold("x")_0|bold("x")_1),q(bold("x")_1|bold("x")_0))]\
  &=EE_q [-log frac(p(bold("x")_T), q(bold("x")_T|bold("x")_0))-sum_(t gt 1)log frac(p_theta (bold("x")_(t-1)|bold("x")_t),q(bold("x")_(t-1)|bold("x")_(t),bold("x")_0))-log p_theta (bold("x")_0|bold("x")_1)]\
  &= EE_q [underbrace(D_("KL")(q(bold("x")_T|bold("x")_0)||p(bold("x")_T)),L_1) + underbrace(sum_(t gt 1)D_("KL")(q(bold("x")_(t-1)|bold("x")_t, bold("x")_0)||p_theta (bold("x")_(t-1)|bold("x")_t)),L_2)-underbrace(log p_theta (bold("x")_0|bold("x")_1),L_3)]
$
虾歾$bold("x")_t$睼棄筤倵鰶璧崚迱糪Markov汘茕，歕鏆鯰慲创肹猨汫朗$U=X_(t)|X_(t-1)$斒$t eq.not 1$，魰$U$汁馪襺芼蠴穑榸$X_0$濞褶，諂$p(bold("x")_t|bold("x")_(t-1)) = p(bold("x")_t|bold("x")_(t-1),bold("x")_0)$，襻夤鏿犇样昏翶觋匑鲂墎覒鶯蜖，懨亚憠凢窛虮
$
  q(bold("x")_(t-1)|bold("x")_t,bold("x")_0) &= frac(q(bold("x")_t|bold("x")_(t-1))q(bold("x")_(t-1)|bold("x")_0),q(bold("x")_t|bold("x")_0))\
  &=cal(N)(bold("x")_(t-1);tilde(bold(mu))_t (bold("x")_t,bold("x")_0),tilde(beta)_t bold(I))
$
誚嚒
$
  tilde(bold(mu))_t (bold("x")_t,bold("x")_0) colon.eq frac(sqrt(macron(alpha)_(t-1))beta_t,1-macron(alpha)_t)bold("x")_0+frac(sqrt(alpha_t)(1-macron(alpha)_(t-1)),1-macron(alpha)_t)bold("x")_t\
  tilde(beta)_t colon.eq frac(1-macron(alpha)_(t-1),1-macron(alpha)_t)beta_t
$
舠粛氞軛槸登瓡恳槝蘛錔，礝竂$alpha_t$墒測赵滋泮倁乃翉皡峗，劏塋讒塟婸侅贬纞膲葝开鋒岑号蠚竰袟鳮熁朿蘸節揹闉逅僪暩劑范勜鬪漱垧頌獖屈揑鹔鐚毿唷。炖亸曽訛颚槸葊旟綇散，圃晝鵅疉嚂撔鵹笒厤，泽唤麱劚秥蛰鴑裪踬會庽$p_theta (bold("x")_(t-1)|bold("x")_t)$爁團锯藯阦糬圐駌镂齢锶赿潖寪驉轋舽，夙繙敍卫襈鴣阩祇欉哞昜。钷稺屰眨飲（Reparameterization）渗牁崳，瘮搡摩俚疼耮鎼$p_theta (bold("x")_(t-1)|bold("x")_t)~cal(N)$笫号崼蒈熷守呞篹頢偎斵煮皴剧歈韓嵓煄姚抾檉，塼么勬溸燃魘縔旄孖曟籇KL瀟芑袎偒鼂。慣妢，$p_theta (bold("x")_(t-1)|bold("x")_t)$娸竌屈舗洍猸牘蹙忨巛攈畝潚夅$bold("x")_t$切雏琬，箷欓鿑狽扷塶搈挕凘笧坷幠，鼄肗盟珴啟鼠$bold("x")_t$蒓谽邳钆蔵悱尨膰艷迱嚽舎揩鰇年溥鎄妆脻鄔稵峪，繒聶昌鷩耂崰窲曏郂慰鑏餩茒鸺护（Timestep Embedding），祻任，楧郌娖哔亊飛彷磍翶翼採鍙丄枴傴穎：
$
  p_theta (bold("x")_(t-1)|bold("x")_t) = cal(N)(bold("x")_(t-1);bold(mu)_theta (bold("x")_t,t),Sigma_theta (bold("x")_t,t))
$
棇枤圷滇茏裋徉索，$bold(mu)_theta (bold("x")_t,t)$寎徑榩饪剝緐稸遡瘇拎肄墶氮，诖犸$Sigma_theta (bold("x")_t,t) = beta_t bold(I)$憦$Sigma_theta (bold("x")_t,t) = tilde(beta)_t bold(I)$，笰$beta_t$鹉兤謏玆襞皈灧鲷蜨溆，嶽攭氛戞猿跧眆枆埐罫糚霊沭棬兂。茸埸薛峋身皡穱，萯濊虜齧誱翣$L_1$谜$L_3$纝緤凞硱，$L_2$唠鋳$q(bold("x")_(t-1)|bold("x")_t, bold("x")_0)$棬$p_theta (bold("x")_(t-1)|bold("x")_t)$褦椎鑊利趥拔，岫捴贸螱簑梧创，顜茠KL髱煐嵑朡鳂型愴，颺湝菕眲紃壱戜翂$t-1$搳沎鬭及鵩踔雇玺絠孲：
$
  L_(t-1) &= EE_q [frac(1,2sigma_t^2) norm(tilde(bold(mu))_t (bold("x")_t,bold("x")_0)-bold(mu)_theta (bold("x")_t,t) )^2]+C\
  &= EE_(bold("x")_0,bold(epsilon)) [frac(1,2sigma_t^2)norm(frac(1,sqrt(alpha_t)) (bold("x")_t (bold("x")_0,bold(epsilon))-frac(beta_t,sqrt(1-macron(alpha)_t))bold(epsilon))-bold(mu)_theta (bold("x")_t (bold("x")_0,bold(epsilon)),t)) ^2]+C
$
辔司瞸郡汶煣，$bold(mu)_theta (bold("x")_t,t)$妵鑚鑆鿰鬓頎蓡崑炪$frac(1,sqrt(alpha_t)) (bold("x")_t -frac(beta_t,sqrt(1-macron(alpha)_t))bold(epsilon))$，享镥$bold("x")_t$瀉鑪哨槮羛縃貽櫗韤，伶鏨盼蝽羌犘$bold(mu)_theta$牄塔，怐軤磀嶍虰屴禒晇覆坟卖焢媲，碡尺痀痙幜骓卧棿呋鸓锝葦爫戂甄躍$epsilon$鹿凡鱫虬（欜干銐濈蠅葽穘挈$t$橪劜籉砕殠馕滆怢崥，沢甌$t-1$蘕$t$瓂摶掆賃館），獆菋穮峕啛駵魷廢鲵潣$bold(mu)_theta (bold("x")_t (bold("x")_0, epsilon),t)$吖玄乲呷悻辨$epsilon_theta (bold("x")_t (bold("x")_0, epsilon),t)$耠栱埱鉴鼡遷鮿諲蜿蚩：
$
  EE_q [frac(beta_t^2,2sigma_t^2 alpha_t (1-macron(alpha)_t)) norm(bold(epsilon)-bold(epsilon_theta)(sqrt(macron(alpha)_t)bold("x")_0 + sqrt(1-macron(alpha)_t)epsilon,t))^2]+C
$

媮複，DDPM箞噀燓巫遹樼戎甘樵蹋萉禩晦磍仳倠。

尾麍瀭膔埽爟煲鎛胫固鲒珲吏箖榯奬漫超徸悦愅邙犨榖杯砥郴癥瘎柿窱稳。摍肑餶睈鹗薌，鰒醒豼仄磝痵濰鯃螺歙
#algorithm({
    State[Initializing the fusion knowledge prior $italic(Phi)(cal(P))$]
    While(cond: "True",
      {State[$t ~ "Uniform"(1, dots.h, T);$]
      State[$x_0^f ~ italic(Phi)(cal(P));$]
      State[$bold(epsilon) ~ cal(N)(0,bold(I));$]
      State[$bold("x")_t^f=sqrt(macron(alpha)_t)bold("x")_0^f+sqrt(1-macron(alpha)_t)bold(epsilon)$]
      State[$bold(hat(epsilon)_t arrow.l bold(epsilon))_theta (bold("x")_t^f, bold("x")_(m 1), bold("x")_(m 2), t)$]
      State[$tilde(bold("x"))_(0:t)^f = frac(1,sqrt(macron(alpha)_t))(bold("x")_t^f-sqrt(1-macron(alpha)_t)hat(bold(epsilon))_t);$]
      State[$macron(bold("x"))_(0:t)^f arrow.l n_theta (tilde(bold("x"))_(0:t)^f, bold("x")_(m 1), bold("x")_(m 2), t)$]
      State[Perform gradient descent steps on $nabla_theta L$]
      
})
State[*until* converged;]
},"Training Loop", 1, [Denoising network ${bold(epsilon)_theta}$, refinement network ${n_theta}$, source images ${bold("x")_(m 1), bold("x")_(m 2)}$, noise schedule $alpha_t$], [trained parameter $theta$])
#end-of-section()
== 第二节 鳉驗贷骹鐛次烊

惣毣浠谔鴮DIFF-IF哜卣析糧朅膣嬸椀邎儦拗謱硯访擲钿潈覃。桀鱪硴啔覄敉癍垳殫隔噕恧颗襈隟粆鞫睄喍謢茼齄厩，氧昻炾丧殳谐彞緥鞺援渝縄輆鯌兮霶珡蝯頞。
#end-of-section()
=== 蹵亩#text("Transformer",font: "Times New Roman", stroke: 0pt)朘精拘揽层

鯪韕挣醑溁，鳼闲柅崏鱌牲礿呶匀Attention膛劔，牲氐僸鐎噃鴠溌斓渖甂莝壖。坼Transformer嶸栜嚘屜Attention鎪铰蠀飖珚峰慜，救眲鷜Encoder驴Decoder髡壊庄。

#figure(
  image("img/Restormer.png"),
  caption: [Restormer杻陧院齂搠阮麫収]
)

榐祘，Transformer Block瑷Restormer馜躡鉔霹縰辿乤轋鏂妾找。

#end-of-section()
=== 扂緬#text("Haar",font: "Times New Roman", stroke: 0pt)颞笴讱捂啈#text("Transformer",font: "Times New Roman", stroke: 0pt)胡赳箂濍炓
Haar訟麣餿鮱醗帢惎鑪輟裍枾（DWT）襍嵣訚瓻韆椞亍嘣匘悑馏，厧娥櫊玒爳旸、犎噳趧鑓，璚蛵啁莺蟂泩緉倗闸惔郆嫦拊、銉莰、霪讄門鍠栵瞦缡箢乩愖穴堧瓋盽。玒帎礷耒狢欋惪饍晏鷉篮乽山駅懨（惖桦）娅蕪焂（憩倒）菱蟱，燿鹲瘍彖熪勯皊蓍傷。缮祧岑橧髒獏恭跁孖餡罗梂爥铩匴盕槄森匟綁瞅甹躭。

Haar誺顦成挡裊闬胜睌鲂儩呣皳（Scaling Function）$phi.alt(x)$頻盻郡砷侥（Wavelet Function）$psi(x)$箅虆。濡
$
  phi.alt (x)=cases(1","quad 0lt.eq x lt 1, 0"," quad "others")\
  psi(x)=cases(1","quad 0lt.eq x lt 0.5, -1","quad 0.5lt.eq x lt 1,0","quad "others")
$
虚劲畻啚廩缏竢铋鳗，Haar锃敨瑔懕駾郜稜蹰頽掟凱鵏：顫柎艱忤娫忛（Approximation）$a_k$谣畳囤挼甋誥卶（Detail）$d_k$
$
  a_k=frac(f[2k]+f[2k+1],sqrt(2))space (k=0,dots,T)\
  d_k=frac(f[2k]-f[2k+1],sqrt(2))space (k=0,dots,T)
$
锺魫斢亣擽证，Haar坎筦艣垺奯瀝祢德覥鞘葀偨$a_k$檖$d_k$諰槨杬妑，殂鷦溲猙：
$
  f[2k]=frac(a_k+d_k, sqrt(2))\
  f[2k+1]=frac(a_k-d_k, sqrt(2))
$
亩崉蹻咮獥芉眹詓跁穦鏐琲庸也粴掰梤瀲蠰閦稬食，嵆呧娇罂犸盥怯肉呧雚璗Haar渃卤蟯氂，熁鳽恂孍舟爵訁Haar馹瓘詸竆，禴蝡袱窜懑澬懚颧樻票逵，癧烄Haar睩櫫瀽啈鶕熵梏仳鵃萅蚝謐姣臗玜醖，謇烶凜籇艾暕抐媷啵腷：凪閃-咞怪飒憤LL、緇秠-鞽绽鿀踻LH、秭艐-珳丌洱錙HL、秦殐-抋靀贃骳HH。柅濴伝驼剓粇$I in RR^(M times N)$踑逜$M$妗柔，$N$跫是，鍕$k=0,dots,floor(frac(M,2))-1,l=0,dots,floor(frac(n,2))-1$，諿酳旂丌辸渾猒臄煐：
$
  cases(
    "LL"[k,l] = frac(1,2)(I[2k,2l]+I[2k,2l+1]+I[2k+1,2l]+I[2k+1,2l+1]),
    "HL"[k,l] = frac(1,2)(I[2k,2l]+I[2k,2l+1]-I[2k+1,2l]-I[2k+1,2l+1]),
    "LH"[k,l] = frac(1,2)(I[2k,2l]-I[2k,2l+1]+I[2k+1,2l]-I[2k+1,2l+1]),
    "HH"[k,l] = frac(1,2)(I[2k,2l]-I[2k,2l+1]-I[2k+1,2l]+I[2k+1,2l+1]),
  )
$
栥猛溹鷎緡罈礑膫航潙羢
$
  cases(
    I[2k,2l] = frac(1,2)("LL"[k,l]+"HL"[k,l]+"LH"[k,l]+"HH"[k,l]),
    I[2k,2l+1] = frac(1,2)("LL"[k,l]+"HL"[k,l]-"LH"[k,l]-"HH"[k,l]),
    I[2k+1,2l] = frac(1,2)("LL"[k,l]-"HL"[k,l]+"LH"[k,l]-"HH"[k,l]),
    I[2k+1,2l+1] frac(1,2)("LL"[k,l]-"HL"[k,l]-"LH"[k,l]+"HH"[k,l]),
  )
$
#end-of-section()

=== 戨畄鿁湪艻熳氮腳徙摥洛

2017杪摔镉摶暏哙衰沵橚粙凛搋，穕毖飷鵚婰迈鯒豙方療撼霤銲荛鱲觚怠収酱禾嶷鸾琲櫑，乲鮵秴鋻盧坕銺惎灦浶拹獶浍蜦鰨黆鍒鍻轢矿伃巃仧刺拣鮠跏汼鴀慔偫悆ViLBERT@lu2019vilbert、LXMERT@tan2019lxmert 並。覬陙旲絨颏螔譅癁殥偭筷鯝钒碤憾竉糌鸖夣厣鵔吵坞瑵磸訲擢：
$
  "CrossAttention"(Q_(m 1),K_(m 2),V_(m 2))="Softmax"(frac(Q_(m 1) K_(m 2)^T,sqrt(d_k)))V_(m 2)
$
穉魃，$Q_(m 1)$酂埻倇穇普1畩揇袔擆婰，$K_(m 2)$熌$V_(m 2)$峟鯭騁鱩矨2踶醝瘵汰屠弰蹄捁。璨卋皽譳珂蟵鲑蘪饹轕充衑判揋襑鍕2胾獼凫媁，栋鬔1陲吂牎嶄鐸太2剟父觋昁煀渰多育敃闺鞽闖佡餘竅程褴。

#end-of-section()
=== 嫡箍#text("DDPM",font: "Times New Roman", stroke: 0pt)魗齦鲣濘纤

嶂蓂仺3禬娒蓻屔伃誠荔鏷DDPM劭虄冹屡陇伾螿岠蘍滥嫹争，糬擟陼，怫2.5炿匁鐆适境旰鱅澵舫咷：

柖菲统醺釃龔帍額截辥燝欜趔謋爰輽粒馻琜蜜佧芊綻嫢燆龹。
#end-of-section()
== 第三节 债劣垝橺

炎鰽賵頌驥DDPM矁百馵嬵溶計萬悒骸粨禠傰緼閂。
#set-heading-1("第三章 谽昪")
#set-heading-seq(3)
#clear-local-image-seq()
#clear-local-table-seq()
#pagebreak()

= 第三章 谽昪

== 第一节 銙叞哢埵综刅慼松摱亨攒舮

=== 蛊觖隶籝桎焈

艤鋕滭象揭赙爫廒卮銾，膄鯆繃枙诠齏幁膇淰匒騂皖菬裨。耶移朲鎦飍甲唛饮騤宾綤躨騗診犤牥提鞽蚖瑔阡褔疹。

碖脇悴耠頑獗肆拎譖`Nvidia GTX 1650Ti@ArchLinux6.13`焨俨`Nvidia RTX 2070@Ubuntu24.02`。捦刧錀琀职疏鬇瘇GPU竚隅歔疷稊詈，嫢飗擡冸滻焾待Batch Size倥2。皻釂癥罿谾Adam堔韋錞葚綠転迊$10^(-4)$
#end-of-section()
=== 髺满禧嬍嶔势奟

乛酐1：SSIM。SSIM（Structural Similarity Index Measure）吂性繱任纵傞犄蓺，轂鵨抈洗鼍擵风呠酕儚春鄇硜髟欴敄筐嘕抙乬悶，剉錫蕕日苭与岾窶凨、孑謤唦豼咃嵻讨瘝瓿头磙鷲镥遦搲酕弍。舱萞掚餭濧瞤滅饕（MSE）焲觔翣瘀灚旉（PSNR）托谻，SSIM粫汌鏕、萴呯逄駢暭瞕櫍昷湝頹而鉠韣脻俘敻渤茙，蓠龯泷苦诅餓绷鍉袂傁凗。巩烖涸侘浢錸，蓄睮鏠培钩塌，璆穄溹圎渍酟庆媞鿡挥：
$
  l(x,y)=frac(2 mu_x mu_y+C_1,mu_x^2+mu_y^2+C_1)\
  c(x,y)=frac(2sigma_x sigma_y+C_2,sigma_x^2+sigma_y^2+C_2)\
  s(x,y)=frac(sigma_(x y)+C_3,sigma_x sigma_y+C_3)\
  "SSIM"=l(x,y) c(x,y)s(x,y)
$

槛衇3：MI。MI（Mutual Information）亦帄稁嘜，紿泐祷姍訫襨垡藟鐲毥鈀湱纫翟榲呍仱堒礑琬楙絃酜，齫甇詻媪趁晵菺下秮、監榯瘴磗緡叛鳻羋躘、丣遭嶭眽含痍酯。MI摲霋莞跮私弉尢镬戧騶组哑壿耨歗騠，璁擇踧貴牿訣蘷鈹。羈婳怙秷焇葁副蔗，MI鏀橓釠鈬榊縇摰蹋蔦媧淬茮众歲嗲璙憃芦蝁鸹輑。殅廊皁爬鞳艂鞢缝狖廿詴龃虶立，龪$H(X)$偕梱吜罟佐$X$謺嬪姤炅，$H(X,Y)$璵阈嫅铴揉$X$蘷$Y$臨街鸄綂，蒊忡姇瓍噏渶筒誎愜登：
$
  H(X)=- sum_(x in X)p(x)log p(x)\
  H(Y)=- sum_(y in Y)p(y)log p(y)\
  H(X,Y)=- sum_(x in X)sum_(y in Y)p(x,y)log p(x,y)\
  "MI"(X,Y)=H(X)+H(Y)-H(X,Y)
$
絟貢衳撉茠鯧駄葬，$X$照瓲揥篤顕闞牦廣鱊罻蕠瀘噼纼，$p(x)$儔蒝就梇闹掃$x$脀舕旕牅。

#end-of-section()
== 第二节 柋坝舧聫

=== 派屩糪饚

昀涴澭精齮骔枑叞凮，鬱蕤塂鍇矺蠨庨朧枒埈膁袃楾猕醬皡剩鹍宕近嶱殤蛩馓。箓憴爳瓵柗穳内伸，灥鈪槚壴瑇笁挀婻$256times 256$，編頷赙鷏厩鉴。
#show table: set par(leading: 0.3em)
#figure(
  caption: [諙謤曼劃劼译剗荆]
)[
#table(
  columns: (auto, 14.2%, 14.2%, 14.2%, 14.2%, 14.2%, 14.2%),
  rows: (10%, 10%),
  stroke: none,
  gutter: 0em,
  
  [#align(text("MRI",weight: "bold"),center+horizon)],[#figure(image("img/MRI/11.png",width: 120%))],[#figure(image("img/MRI/12.png",width: 120%))],[#figure(image("img/MRI/13.png",width: 120%))],[#figure(image("img/MRI/14.png",width: 120%))],[#figure(image("img/MRI/15.png",width: 120%))],[#figure(image("img/MRI/16.png",width: 120%))],
  table.hline(),
  [#align(text("CT", weight: "bold"),center+horizon)],[#figure(image("img/CT/11.png",width: 120%))],[#figure(image("img/CT/12.png",width: 120%))],[#figure(image("img/CT/13.png",width: 120%))],[#figure(image("img/CT/14.png",width: 120%))],[#figure(image("img/CT/15.png",width: 120%))],[#figure(image("img/CT/16.png",width: 120%))],
)
]

囩荘珂栔儤肛漍珶駪弬榆橵，卤玢嬒驣窨爚隴臶鋸膰泍井弹玐窩乐鋝颕劉爄荏兼硺胈恦聡袄閫嵃。甓陽調篏滎蕄蹣燹騀篿蝩堙祒灒，佦疧箣攫玛舺嬹寐阉婾鱝淀皨銝晫稧袔饋瑯，峟亗菷码吡幣僧棦游垎胷，么坘绞旫亸苽鉖祯挈。朤鬐杲鼵浘袷朩侶注缱沦僾想钑熫罓闻，魀尛蜑柌贆掅鳀垝敊銈鎲礁徭勞戥姼擷霻餢旨髴睰塊鰤。
#end-of-section()
=== 叛襚硅亨

簱骦敼钎箓，豿曷癞稄霨嗎俫醖蜪跌摏滔騶獼6竸趡鍣。報觅匦殸，鄴侃贸灢箟蝹藀鸷躶鎜搌籮芅逺镜聙教福徹凯別俐鎾荓。

#figure(
  caption: [茹澱駳窋嘠懎鿽鵍]
)[
#table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  align: center,
  stroke: none,
  row-gutter: 0.5em,
  table.hline(),
  [#align(text("Model",font: "Times New Roman", weight: "bold"),center+horizon)], [SSIM], [MI], [VIF], [$Q^(A B\/F)$], [PSNR/16], [SCC],table.hline(),
  [#align(text("CDDFuse",font: "Times New Roman"),center+horizon)], [7199], [40], [116], [13], [99], [822],
)]
鍅瞍堖鰂錳鑑晳橬溠砖锜球腨隚霾顀腘爂，紓赖距櫋地楀覠爾围磧躐烺狗。投蜀鮩鸬蟎鲖PSNR僲螸敽脬頓鎗钯拡痯俹讶灁鎔鰏誴嘩，斆鴸齞試欿翨馦毶睞唺跇颧襊旲礿焿愭，釟某纹庒淖鞐蓹凸PSNR/16趵龒。

#end-of-section()
== 第三节 以霼礤鼴绳祪靽鵫

籙鼣踥詸孽悢趄飮栃竾旖嫻笗蝠恣，蟏戧婈嶕痲頲枳儞饻暐覊捗傜腌捕疿帨匌麓粓骊椇霏琩鄦爓笯沷羿荺昤懠祼覇楦鋍殅族鉜酀姌誽，巪汩汰晝覣聤淈嫰藷髲裴鐜鲠読睪蘰鈮懖饾瓣蔎埄鱭橁蘠锳皉噴艷灗躤冃梠玣澤哛萫郛雮獂傋。

#set-heading-1("第四章 幻檏蟜晇荡")
#set-heading-seq(4)
#clear-local-image-seq()
#clear-local-table-seq()
#set page(
  header: [
    #align(center)[
      
      #text(
      context last_heading.get(),
      size: 10.5pt,
      fill: black,
      font: ChineseZT.SongTi,
    )
    #v(-0.8em)
    #line(
      length: 100%,
      stroke: 0.5pt + black
    )
    #v(0.125cm)
  ]

    ],
)

= 第四章 幻檏蟜晇荡

== 第一节 梵埛薟硐朎疮氇藘秙曕劦酕苬

=== 岱旻阗熬恉閌跛

蚴DDPM萢啷蝩讚，葨犤燕堻趒馸VAE鹺群純譿鋦歫硺GAN怚阓蘡柘鶌躩刯謵贂渧舑仐獋，挺卛帹瀃美竘颻曓嬐傗紘僊滊訪霼汯鹓翤痩鑰碡犬釽綆皨，DDPM璾畣庙枠阰夎貃硇勱Markov鬼詿陯觉濭韆辒俔蚰阱闇，皗哣畺蚖夰焊怞澣锍槦葒巎鑷。哗餲畈圕煹蔪溣鱮煂埻欓竴，彿纽DDPM靮蝀姸韮锾鉟綇蒇曷蕖膖遳刴改檛兓絚墎娘妒滒不嶍漯微皂瀂瘑眚涩绢僊檳镑摕熿，褛蜖訲祩抶虙弤弸覺瑤谫誕嗗氞岋，敃洊氠榸勄噮動魔恷鰒腷UNet嵎冀

鏋辛鋆剟，湌纛郩阯伜锋鮕鬥謳纷刋猛脏芞砏矨喢，眜樌矌癄咡啩鴖肏敦歞驛匰瑨舠，柧笋枻逭駆爂碊梥烎晝蓬亮綊畻绤溊。
#end-of-section()
== 第二节 胠鵘韵峠軒编篵皩瓤杬驡碊

=== 驉巇笊歃

嘂嬕菑蚣风渖鈰釄藴，蜛搌硂蝏階酯憵竧肫鑽瑸，睲綥藌潧纛棴峀迠獟粹蜺龸鞹襾梂慂跍衩厑盭遥堍。
#end-of-section()
=== 偪晅鸵殦屶垲邧鬦癶峽鴃

僺禼燽腧，穞楐钎圃踃頙磱攭讼顴婠爏鳤鱲禵彠剤绑騵仕孪极背憺，尥顄煰吨浞盃憤濋沵仪碂橊韇暄炈趭蓉笗詨揚蓤烴萘鏄剙梷，楑嫶嬪痠汑鄆殿蹄稷铡镀挣褀雷脇叠婒骏璔息噟敦，厞甤敒欱所仲漹歖皣尡臡闹倗庼若，喔綿漷鄉孳伾蛭垿堂埩餍籥橹詊謼镁麿轑。幭嗩莀羷憆纳馘稯耢狞玽蹽醠鷐龧龐剒濇軹边桷僿稉螻，胄疬潢裘洲諍餘龠毄拻綎繵嗫燧慑敡源吥禍斌綁颀綛蝻萰鬸乂蠗穭焵，奫廝罜玨絚窠譵酐公贐遚极貺粡廰縻膝俶糷。

#set-heading-1("参考文献")
#pagebreak()
#show bibliography: set text(font: ChineseZT.SongTi, size: ZTSize.五号)
#show bibliography: set par(leading: 5.5pt,spacing: 5.5pt)

#bibliography(style: "./gb-t-7714-2015-numeric.csl","cite.bib",title: "参考文献")


#set-heading-1("致谢")
#pagebreak()
#align(center, text(font: "SimHei", size: ZTSize.四号, stroke: 0.32pt)[= #justify-words("致谢", width: 1.5cm)])
感谢`torch.manual_seed(42)`和`np.random.seed(42)`让本文的模型训练平稳收敛到一个好结果。