/*留意事項：
このテンプレートはMS明朝等でコンパイルされていることを想定して作成している。
公式のオンラインエディタでコンパイルする際には、エディタの置換機能を使って、全ての「.9em」を「.85em」に置換してからコンパイル。
オンラインとローカルではフォントの関係で生成されたPDFにズレが生じるので注意。詳しくはReadMeを読むこと。
*/
#counter(page).update(1)//開始ページ番号
///////////// タイトル ////////////////////
#let title=[日本教育工学会論文 非公式Typstテンプレート]
///////////// サブタイトル /////////////////
#let subtitle=[] //サブタイトルを付けた場合は後述のコメントアウトを外す
///////////// 執筆者 //////////////////////
#let num1 = [#text(font:("MS Mincho","IPAMincho"))[#super[＊1]]#h(-0.5em)]
#let num2 = [#text(font:("MS Mincho","IPAMincho"))[#super[＊2]]#h(-0.5em)]
#let num3 = [#text(font:("MS Mincho","IPAMincho"))[#super[＊3]]#h(-0.5em)]
#let num4 = [#text(font:("MS Mincho","IPAMincho"))[#super[＊4]]#h(-0.5em)]
#let num5 = [#text(font:("MS Mincho","IPAMincho"))[#super[＊5]]#h(-0.5em)]
#let authors=[
  日本太郎#num1
  ・教育次郎#num1
  ・工学花子#num2
  ]

/////////////// 所属 //////////////////////
#let affiliation=[日本教育工学大学教育学部#super[＊1]・日本教育情報大学工学部#super[＊2]]
//////////// 抄録（abstract）//////////////
#let abstract=[#h(1em)
この論文テンプレートは，日本教育工学会が2023年9月7日に改訂したWordのテンプレートに限りなく近づけた，開発途中の非公式のTypstテンプレートです．本テンプレートは，日本教育工学会（Jset）とは一切関係なく，このテンプレートを利用したことによるいかなる損害についても，本テンプレート作成者は一切の責任を負いません。すべて自己責任でお願いいたします。

既知の問題として、本来MSゴシックにしなくてはならない見出し等のアルファベットがMS P明朝になってしまう、というのがあります。

論文執筆にあたっては，日本教育工学会が定める「執筆の手引」に従ってください。
]
//////////// キーワード ////////////////
#let paper_keyword=[日本教育工学会，Typst，テンプレート，スタイル，チェック]
///////////////////////////////////////

///////////// 文書設定(本文設定は本文開始直前で設定) /////////////
// ページサイズ・余白・本文とフッターとの間
#set page(paper:"jis-b5",margin: (top:24.5mm,bottom:22.5mm,left:16mm,right:16mm,), footer-descent:10pt,)
//斜体のないMSフォントを斜体にする。本文では #emph[...]
//参照：csimide/cuti: Cuti: A simple typst package simulates fake bold / fake italic characters. | Cuti：在 typst 中便捷使用伪粗体/伪斜体　https://github.com/csimide/cuti?tab=MIT-1-ov-file#readme
#let regex-fakeitalic(reg-exp: ".+?", ang: -18.4deg, s) = {
  show regex(reg-exp): it => {
    box(skew(ax: ang, reflow: false, it))
  }
  s
}
#let emph(
  ang: -18.4deg,
  s,
) = regex-fakeitalic(reg-exp: "(?:\b[^\p{Script=Han}\p{Script=Hiragana}\p{Script=Katakana}\p{Script=Hangul}！-･〇-〰—]+?\b|[\p{Script=Han}\p{Script=Hiragana}\p{Script=Katakana}\p{Script=Hangul}])", ang: ang, s)
// 見出し設定 
#import "@preview/numbly:0.1.0": numbly
#set heading(numbering: numbly( //use {level:format} to specify the format
  "{1}．", //見出し1　
  "　{1}.{2}.", //見出し2
  "　 {1}.{2}.{3}.", //見出し3
  "({4})", //見出し4
  "", //見出し5
))
//見出し１
#show heading.where(level: 1):set text(font:("MS Gothic","IPAGothic"),size:8.5pt) //見出し1：フォント
#show heading.where(level: 1): set align(center)//見出し1：中央寄せ
#show heading.where(level: 1): set block(above: 14.5pt, below:6.5pt) //見出し1：上下の余白
//見出し２
#show heading.where(level: 2):set text(font:("MS Gothic","IPAGothic"),size:8.5pt) //見出し2：フォント
#show heading.where(level: 2): set block(above: .9em, below:0em,) //見出し2：上下の余白
//見出し３
#show heading.where(level: 3):set text(font:("MS Gothic","IPAGothic"),size:8.5pt) //見出し3：フォント
#show heading.where(level: 3): set block(above: .9em, below:0em,) //見出し3：上下の余白
//見出し４
#show heading.where(level: 4):set text(font:("MS Mincho","IPAMincho"),size:8.5pt,style: "normal") //見出し4：フォント
#show heading.where(level: 4): set block(above: .9em, below: 0em) //見出し3：上下の余白
//見出し5（参考文献等）
#show heading.where(level: 5):set text(font:("MS Gothic","IPAGothic"),size:8.5pt) //見出し5：フォント
#show heading.where(level: 5): set align(center)//見出し5：中央寄せ
#show heading.where(level: 5): set block(above: 14.5pt, below:6.5pt) //見出し5：上下の余白
#show heading : it =>  { //見出しの直後の段落の字下げ有効
    it
    par()[#text(size:0pt)[#h(0em)]]
}
// 画像（表含む）をnone（その場）が挿入された後の最初の段落の字下げ。段落間を #v(-〇〇em)で調整。
#show figure : it =>  {
    it
    par()[#text(size:0pt)[#h(0em)]#v(-0.9em)] //#v(-〇〇em)は本文行間と合わせる。
}
// 引用
#set quote(block: true)
#show quote: set pad(top:1em,right:0em,bottom:1em,left: 2em,) //引用：上下の1字分の空白
#show quote: set par(justify: true,leading: 0.9em,first-line-indent: 0em,) //引用：段落の両揃え、行間、字下げ。
#show quote: set block(spacing: 0em) //引用：段落間スペース
#show quote: it =>  { //引用直後の段落の字下げ有効
    it
    par()[#text(size:0pt)[#h(0.0em)]]
}
//キャプション「Figure」を「図」に。
#set figure(supplement: [#text(font:("MS Gothic","IPAGothic"))[図]],) 
//キャプションのセパレーターをなしに。
#set figure.caption(separator:[ ],)
//キャプションのフォントサイズ
#show figure.caption: set text(size: 8.5pt)
//figureが「表」(table)のときには、キャプションを「表」にして、上に配置。
#show figure.where(kind: table):set figure(supplement: [#text(font:("MS Gothic","IPAGothic"))[表]],) 
#show figure.where(kind: table): set figure.caption(position: top,)
//キャプションの「図１」「表１」をMSゴシックに。
#show figure.caption: c => [
  #v(0mm)
  #text(font:("MS Gothic","IPAGothic"))[
    #c.supplement #h(-3pt) #c.numbering
  ]
  #c.separator#c.body
]
//ラベルを使って、本文中に「図１」「表１」を表示させた際の設定
#show ref:r =>[#text(font:("MS PGothic","IPAPGothic"))[#r]] 
//下線の位置
#set underline(offset: 2pt) 
//数式に番号をつける
#set math.equation(numbering: "(1)")
//番号リスト
#set enum(numbering: "(1)",body-indent:0em)
//ルビ
#import "@preview/rubby:0.10.1": get-ruby
#let ruby = get-ruby(
  size: 0.5em,         // Ruby font size
  dy: 0pt,             // Vertical offset of the ruby
  pos: top,            // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|",      // The delimiter between words
  auto-spacing: true,  // Automatically add necessary space around words
)
//均等割付
//参照：Typstで均等割付 #Typst - Qiita https://qiita.com/tomoyatajika/items/19cfda43f9760180c332
#let kinto(moji,body) ={
context[
#let size = measure[#body.clusters().at(0)].width
#let wari_width = size * moji
#let body_mojisuu = calc.round(measure[#body].width/size)
#let cell_width = wari_width/body_mojisuu
#let haba = (wari_width - measure[#body].width)/(body_mojisuu - 1)
#let columns_cell = () 
#for i in range(moji) {
  columns_cell.push(cell_width)
}
#let body_array = ()
#let x = int(body.clusters().len())
#for i in range(x) {
  body.clusters().at(i) 
  h(haba)
}
#h(-haba)
]
}
//脚注
#set footnote(numbering: "1")
#show footnote.entry: set text(font:("MS Mincho","IPAMincho"),size:8pt) //脚注：フォント
#set footnote.entry(indent:0em) //脚注：インデント
#show footnote.entry: it => {
  let loc = it.note.location()
  numbering("1　", //脚注番号の後に全角スペース
    ..counter(footnote).at(loc),
  )
  it.note.body
}
// フッターを設定
#set page(
  footer: context {
  set text(font:("MS Gothic","IPAGothic"),size:8pt)
  let page = counter(page).get().first()
  let body = if calc.odd(page) [#h(2.5em)#text(font:("MS PMincho","IPAPMincho"))[Vol． XX，Suppl． (20XX)]#h(1fr) #page#h(1em)]//奇数ページ
  else [#h(2em)#page #h(1fr) 日本教育工学会論文誌 #text(font:("MS Mincho","IPAMincho"))[(#emph[#h(2pt)Jpn．J．Educ．Technol．])]#h(.5em)]//偶数ページ
  align(body)
})
//1ページ目左下の英語プロフィール設定 
#let left_bottom_authors(where, content) = place(
  left + where,
  float: true,
  clearance: 26pt,//左下の本文との距離
  text(font:("MS PMincho","IPAPMincho"),8.5pt)[
    #line(length: 100%, stroke:0.5pt)
    #set par(justify:true, leading: 4.3pt, spacing:4.3pt,first-line-indent:0em, hanging-indent:8pt)
    #pad(left:2em,right:0.5em,content)],
)
///////////////////////// 本文設定 ///////////////////////////
//本文フォント、フォントサイズ
#set text(font:("MS Mincho","IPAMincho"),lang:"ja",size:8.5pt,)
#show regex("[A-Za-z]"): set text(font: ("MS PMincho","IPAPMincho")) //アルファベットをMSP明朝に。 

//段落設定（行間、段落間スペース、字下げ）typst_0.12用
#set par(justify: true,leading:0.9em,spacing:0.9em,first-line-indent:1em,)//MS明朝では0.9em

//表の見栄え設定
#show table: set par(leading:0.8em) /*表の行間*/
#show table: set text(font:("MS Mincho","IPAMincho"),lang:"ja",size:8pt,)/*表のフォント*/
//表のヘッダーをゴシック体に
#show table.cell.where(y: 0): set text(font:("MS Gothic","IPAGothic"))

/////////////// タイトル周りの出力 /////////////////////////
#import "@preview/showybox:2.0.3": showybox
//参照 https://typst.app/universe/package/showybox/
#showybox(shadow:(offset: (x: 2pt, y: 2pt),),width:12% ,frame: (thickness:0.5pt,radius:0pt))[#text(font:("MS Gothic","IPAGothic"),8.5pt)[論　　文]] //論文種別を記述。widthで幅を調整。
#v(-14.5pt)#h(1fr)
#text(font:("MS Gothic","IPAGothic"),8.5pt,baseline: -6pt)[日本教育工学会論文誌] 
#text(font:("MS Mincho","IPAMincho"),7.5pt,baseline: -6pt)[XX (xxxxx) ， 0-0， 20xx]//巻（号）、掲載ページ、年
//タイトル表示
#v(13pt)
#align(center, text(font:("HGGothicE","IPAGothic"),13pt)[#title#text(font:("MS Mincho","IPAMincho"))[#super[†]]])
//#v(-0.5em) //行間調整（サブタイトルをつけるときはコメントアウトを外す）
//サブタイトル表示
#align(center, text(font:("MS Gothic","IPAGothic"),13pt)[#subtitle])
#v(9pt) //行間調整
//執筆者表示
#align(right, text(font:("MS Gothic","IPAGothic"),10pt)[#pad(right: 12.2mm)[#authors]])
#v(-2.4pt)
//所属表示
#align(right, text(font:("MS Mincho","IPAMincho"),8pt)[#pad(right: 10.5mm)[#affiliation]])
#v(4pt)
//抄録（abstract）表示
#pad(left:10.5mm,right:10.5mm,abstract)
//キーワード表示
#pad(left:13.5mm,right:10.5mm,)[
#text(font:("MS Gothic","IPAGothic"),8.5pt)[キーワード：]
#text(font:("MS Mincho","IPAMincho"),8.5pt)[#paper_keyword]]
#v(14pt)//抄録と本文の行間調整
/////ここから2段組/////
#show: columns.with(2) 
#v(.9em)//ページ最初の見出し1の上の調整
//////////////////////// 本文開始 ////////////////////////////

//1ページ目左下の英語プロフィール
#left_bottom_authors(bottom)[
#v(-.5em)
200X年X月X日受理

#super[†] Taro NIHON#super[\*1]，Jiro KYOUIKU#super[\*1] and Hanako KOUGAKU#super[\*2] ：JSET Word Template

#super[\*1] Faculty of Education，Nihon Kyouiku Kougaku University 0-0-0 \Kyouikuchou，Minato-ku， Tokyo，000-0000 Japan

#super[\*2] Faculty of Engineering，Nihon Kyouiku Jouhou University 0-0-0 Kyouikuchou，Toshima-ku，Tokyo，000-0000 Japan
]


= 論文ファイルの作成
論文ファイルは，原則，本テンプレートをもとに作成する．投稿原稿の用紙サイズは，B5サイズとする．

== 論文テンプレートの書式

本テンプレートの題名，著者名，章・節・項の見出し，本文については，フォントサイズや段組みなどの書式が設定されている．

=== フォント，段組み

章・節・項の見出しはMS ゴシックの8.5ポイント，本文はMS 明朝の8.5ポイント，Summary・英語キーワードはMS P明朝の8.5ポイントとなっている．章や節，項の見出しが長く，複数行に渡る場合は，適当な箇所で改行 (Shift＋Enter) し，見やすいように調整する．

本文の段組みは２段組で，１行あたり24字，１ページあたり44行に設定されている．この書式を崩さずに論文を作成することで，１行の文字数，１ページの行数等が定められた形式での執筆が可能となる．

=== 書式を崩さない方法
書式を崩さないために，以下の２点に注意する．

+ 他のWordファイルから文章をコピーして貼り付ける場合は，書式を一緒に貼り付けないように注意する．元の文書で文字列をコピーした後，本テンプレートに[ホーム] > [形式を選択して貼り付け] > [貼り付ける形式] の「テキスト」を選択する．

+ 書式を崩してしまった場合は，段落内にカーソルを置き， [ホーム] リボンメニューの [スタイル] ボックスから，指定したいスタイルを選択する．

== 論文執筆時の留意点

論文を執筆する際は，日本教育工学会ウェブサイト及び日本教育工学会論文誌に掲載されている「執筆の手引」(2023年9月7日改定) に従う．また，教育工学選書II第13巻『教育工学論文執筆の要点』のうち，特に「論文執筆の基本と要点 (清水 2018，pp.175-211) 」を参照することが望ましい．

= 執筆の手引
== 論文のページ数
=== ページ数の制限
論文のページ数は，論文種別によって異なるため，以下の既定に従う．
+ 論文，教育システム開発論文，教育実践研究論文，資料は８ページが原則．ただし，８ページ超過の場合は掲載料の超過料金の支払いにより可能．
+ ショートレターは４ページを厳守．
+ 寄書は６ページ以内が原則．
+ 展望，総説の体裁・分量は論文に準ずる．

=== ページ数に関する注意点
図，表内の文字サイズ等から，図，表の大きさが決められるため，十分に注意する．ただし，校正段階でのレイアウトにより，著者の予定ページと異なる場合が多いため，余裕を持たせて計算する．

== 論文種別
本テンプレートの１ページ目の上部左側の枠内に，「論文」「教育システム開発論文」「教育実践研究論文」「資料」「ショートレター」「寄書」「展望」「総説」のいずれか１つを記述する．なお，同ページの上部右側の文字列「日本教育工学会論文誌　XX (xxxxx) ，0-0，20xx」およびフッターは，採択後に事務局が入力するため，編集する必要はない．

== 論文の冒頭
=== 題名
論文の題名は，論文の内容が明確に分かるようにし，「第○報」等は含めない．また，簡潔な表現にするため，できる限り副題がない方が望ましい．字数については，40字以内に収まるようにする．

=== 著者名，所属機関
著者名には，＊１，＊2 のように「\*」と「数字」を上付きで表記する．そして，それらに対応した所属機関を著者名の下段に示す．

１ページ目の下部左側のテキストボックス内に，著者名，題名，所属機関およびその所在地を英語で記述する．当該箇所はテキストボックスになっており，自由に移動することができるため，ページの余白に出ないように位置を調節する．なお，受理日は事務局で編集するため，入力する必要はない．

=== 著者の順と数および所属機関の表記
共著で論文を投稿する場合の著者順は，当該論文に最も貢献した者を「筆頭著者」とする．「共著者」を決定する際は，論文の内容に貢献していない者を著者に加えたり (ギフトオーサーシップ) ，貢献した者を除いたり (ゴーストオーサーシップ) しないことが重要である (清水 2018，p.177) ．そのため，著者全員が論文の内容に関する責任を負い，著者の人数は，論文の内容に貢献し，かつ責任を負うことのできる適正な数に留める．
所属の記載の仕方については，以下のように考えることとする．
+ 原則として，当該の研究が実施された時に所属した，主な研究機関または組織の名前を記載する．
+ もし，投稿時点で新しい所属のある場合等，著者の所属として複数の研究機関または組織の名前を示す必要がある場合には，(1) に該当する組織名を優先して示すことを条件に，その他の所属研究機関または組織の名前を追記して記載することができる．
+ もし，投稿時点で，著者が当該の研究が実施された時の所属先を卒業・修了・退職している場合で，かつ当該研究実施時の所属先をそのまま書くことも適切ではないと判断される特段の事情がある場合には，投稿時点の現所属のみを示すことができる．この場合でも，当該研究を実施した主な研究機関または組織の名前を，付記に明記する．
+ 採録決定時点，あるいは採録決定後、出版刊行時点での所属表記の変更は，原則として認めない．どうしても必要がある場合は，編集委員会と相談の上，主な研究機関または組織の名前を，付記に記載する．

== 抄録 (Summary) 
論文，教育システム開発論文，教育実践研究論文，資料，展望・総説の場合は，400字以内の和文抄録と和文抄録の英訳 (Summary) を付ける．寄書，ショートレターの場合は，300字以内の和文抄録のみを付け，Summaryは不要とする．この字数は８割を満たすこと．抄録が長すぎたり短すぎたりする論文は受け付けない． 

== キーワード 
論文，教育システム開発論文，教育実践研究論文，資料，展望・総説の場合は，５～６語の日本語および英語のキーワード (すべて大文字表記) を付ける．寄書，ショートレターの場合は，日本語キーワードのみを付ける (英語キーワードは不要) ． 

== 本文
本文は，以下に示す決まりに従って記述することが望ましい．
=== 見出し
見出しは，以下のように構成する．
1．	   …章\
1．1．	   …節\
1．1．1． …項\
 (1) 	   …小項\

=== 本文の記述\
筆者の主張を読者に正確に伝えるために，以下の点に注意する．
+ 本誌読者の多様な専門的背景を念頭に置き，記述は簡潔かつ明瞭にする．
+ 当用漢字，現代かなづかいを用いる．
+ 各段落冒頭は全角１文字下げる．
+ 数字は算用数字を使用し，１桁数字は全角，２桁以上の数字は半角とする．
+ 括弧は半角，句読点 (，および．) は全角とする．ただし，参考文献については，句読点 (,および.)  は半角とする．なお，外国語を表記する場合にあって，その語の一般的な表記法において単語間や句読点の後に半角スペースが必要な場合は，その慣行に従う．
+ 上付き，下付きで表記するべき文字や数字 (例．χ2検定) は，例のように正確に記述する． 
+ 本文および図表での統計記号 (例．p，t，F，SD等) はイタリック体にする．
+ 固有名詞以外の外国語は，できる限り訳語を用い，必要な部分は初出の際のみ原綴を付する．


#h(0em)国国国国国国国国国十国国国国国国国国国十国国国国国国国国国十国国国国国国国国国十国国国国国国国国国十国国国国国国国国国十国国国国国国国国国十国国国国国国国国国十国国国国国国国国国十

===== 注
注はできる限りない方が望ましいが，必要な場合は記述する．

===== #kinto(7,"付記")
必要に応じて付記を記述する．ただし，査読用ファイルに，付記と列挙した参考文献を含めない．

===== #kinto(7,"謝辞")
簡潔に謝辞を記述する．ただし，査読用ファイルに謝辞を含めない．



===== #kinto(7,"参考文献")
#set par(justify:true,linebreaks:"optimized",first-line-indent:0em,hanging-indent:2em)

GODA,Y.,TAKABAYASHI,T. and SUZUKI,K.(2022) Impact of the COVID-19 Pandemic on Education in Japan and the Role of the Japan Society for Educational Technology. In V.Dennen,C.Dickson-Deane, X.Ge, D.Ifenthaler, S.Murthy et al.(Eds.),#emph[Global Perspectives on Educational Innovations for Emergency Situations],Springer,pp.275-284.https://doi.org/10.1007/978-3-030-99634-5_27

堀田龍也 (2021) 初等中等教育のデジタルトランスフォーメーションの動向と課題. 日本教育工学会論文誌, #text(font: ("MS Gothic","IPAGothic"))[45] (3) ：261-271

一般社団法人日本教育工学会 (2021) 投稿規程．https://www.jset.gr.jp/journal/requirements-for-submissions/ (参照日 2022.04.01)


===== Summary

#set par(justify: true,first-line-indent:1em,hanging-indent:0em)

English summary xxxxxxxx xxxx， x xxxx xxxxxxxx xx xxxx xx xxxxxx． xxxxxxxx xxxx， x xxxx xxxxxxxx xx xxxx xx xxxxxx． xxxxx xxxxxxxx xxxx， x xxxxxxxx xx xxxx， xxxxx xxxxxxxx xxxxxx xxxx， x xxxxxxxx xx xxxx， x xxxx．xx xxxxxx． xxxxx xxxxxxxx xxxx， x xxxxxxxx xx xxxx， xxxxx xxxxxxxx xxxxxx xxxx， x xxxxxxxx xx xxxx， x xxxx．xx xxxxxx． xxxxx xxxxxxxx xxxx， x xxxxxxxx xx xxxx， xxxxx xxxxxxxx xxxxxx xxxx， x xxxxxxxx xx xxxx， x xxxx．xx xxxxxx． xxxxx xxxxxxxx xxxx， x xxxxxxxx xx xxxx， xxxxx xxxxxxxx xxxxxx xxxx， x xxxxxxxx xx xxxx， x xxxx．

KEYWORDS: JSET， WORD， TEMPLATE， STYLE，CHECK

#align(right)[(Received Month Day， 20xx)]

===== #kinto(7,"付録")
原則として，論文に必要な情報は本文中に示すこととし，付録は認めない．どうしてもやむを得ず付録を付す必要がある場合は，Summaryの後に記載する．ただし，電子付録は認めない．

