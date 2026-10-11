#import "@preview/cuti:0.2.1": show-cn-fakebold,fakeitalic,show-fakebold, fakebold
#import "Cfg.typ":*

#let LineSpacing = 0.5em //行距
#let MainColor = rgb("284967") //主色
#let SMain=<SMain> // 正文樣式標籤
#let SStrong=<Strong> // 加粗標籤

#let BaseStroke = 0.04em; // 字體基線粗度 (緣STSong太細)

//自定加粗函數。加粗部分皆設潙主色
#let B(doc)={
	text(
		MainColor
		,stroke: BaseStroke+0.03em+MainColor
	)[#doc#SStrong]
}

//加粗旹 把描邊顏色設成和原本ʹ色 一致
#let FnBaseStroke(doc, ..params)={
	context{
		if(text.stroke == none){ //只針對未設置過stroke的文字、降低優先級 防止覆蓋
			set text(
				stroke: BaseStroke+text.fill//加粗旹 把描邊顏色設成和原本ʹ色 一致
			)
			doc
		}else{
			doc
		}
	}
}

//一級標題
#let H(doc)={

	set par(spacing: 0em)
	let Line = box(height: 1pt, width: 53em, fill: MainColor)//標題下方ʹ分隔綫

	//白字
	let White(doc)={
		set text(white)
		doc
	}

	//字ˇ繞ʹ白塊
	let Box = grid(
		columns: (auto, 1fr)
		,rect(fill: MainColor)[#White(doc)]
		,align(bottom)[#box(height: 1pt, width: 50.5em, fill: MainColor)]
	)

	if doc != [] {
		[= #Box]
	}else{
		Line
	}
}

//自定ʹ 無序列表標號
#let I(doc)={//•
	text(MainColor)[・]+doc//+[ \ ]
}
//行內多個無序列表之間隔
#let InLineSpace = h(0.8em)


//用于主文檔(Main.typ)中 #show: Show
#let Show(doc)={
	//僞加粗 第三方包
	show: show-cn-fakebold
	//正文同色加粗
	show text.where(): it=>FnBaseStroke(it) //誌斯寫法、勿用show: FnBaseStroke
	//全局字體縮小
	set text(1em)
	//正文漢字字體: 華文宋
	set text(font: ("", "STSong"))
	//頁邊距
	set page(
		margin: (0.7cm)
	)
	
	//段距, 段內行距
	set par(
		spacing: LineSpacing
		,leading: LineSpacing
	)

	//列表 (縮進, 點號縮進, 行距)
	set list(
		indent: 0em
		,body-indent:0.3em 
		,spacing: LineSpacing
	)

	//換行後之縮進
	set par(hanging-indent: 1em)

	//標題加粗
	show heading: set text(font: (""), weight: "bold")
	//一級二級標題上下間隔
	show heading.where(level: 1): set block(above: 0.4em, below: 0.4em)
	show heading.where(level: 2): set block(above: 0.6em, below: 0.4em)
	
	//一級標題字體大小與色
	show heading.where(level: 1): set text(size: 18pt)
	show heading.where(level:1): set text(MainColor)
	
	//二級標題字體色
	show heading.where(level:2): set text(MainColor)

	//一級二級標題字體縮小
	show heading.where(level: 1): set text(size: 0.8em)
	show heading.where(level: 2): set text(size: 0.9em)

	//加粗字設潙主色
	show strong: set text(
		MainColor
		,weight: "extrabold"
	)

	doc
}

//異ₐ版本ʹ簡歷中 異ₐ表述(僅供Debug模式㕥顯效)
#let Diff(Tag:"", doc)={
	if Mode == ModeDebug{
		//rect(fill: red)[#White(Tag)]
		text(blue)[#doc]
	}else{
		doc
	}
}

//不同版本簡歷中 新增ʹ表述(僅供Debug模式㕥顯效)
#let Add(Tag:"", doc)={
	if Mode == ModeDebug{
		text(green)[#doc]
	}else{
		doc
	}
}

//未用
#let icon(path) = box(
	baseline: 0.125em,
	height: 1.0em,
	width: 1.25em,
	align(center + horizon, image(path))
)

//極小字體。
//用于 不欲顯于正文旹 能使在綫簡歷解析器 解析㞢㕥填入在綫簡歷
#let Micro(doc)={
	text(size: 0.01em)[#doc]
}

